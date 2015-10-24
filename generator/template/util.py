import random
import datetime
import hashlib
import uuid
import functools
import json

import redis

from dateutil.tz import (
    tzlocal,
    tzutc
)

from tornado import gen

from settings import (
    site_settings,
    redis_settings,
)


def get_salt(length=12,
             allowed_chars='abcdef0123456789'):
    return ''.join(random.choice(allowed_chars) for i in range(length))


def set_password(pwd):
    salt = get_salt(length=site_settings["salt_length"])
    new_pwd = salt + pwd + salt
    encoded_pwd = hashlib.sha256(new_pwd.encode("utf8")).hexdigest()
    final_pwd = salt + encoded_pwd

    return final_pwd


def check_password(request_pwd, final_pwd):
    salt = final_pwd[:site_settings["salt_length"]]
    encoded_pwd = final_pwd[site_settings["salt_length"]:]
    request_new_pwd = salt + request_pwd + salt
    request_encoded_pwd = hashlib.sha256(request_new_pwd.encode('utf8'))\
        .hexdigest()
    if request_encoded_pwd == encoded_pwd:
        return True
    else:
        return False


def get_utc_time():
    return datetime.datetime.now(tzlocal()).astimezone(tzutc())


def conn_redis():
    return redis.StrictRedis(host=redis_settings["host"],
                             port=redis_settings["port"])


def generate_url(urls, apps=None, name=None):
    if apps is None:
        apps = []
    mapping = []

    mapping.extend(urls)

    for prefix, app_name in apps:
        if name == "__main__":
            app_path = app_name
        else:
            app_path = "%s.%s" % (name, app_name)
        app = __import__(app_path, fromlist=['mapping'])
        for app_url in app.mapping:
            new_url = list(app_url)

            new_url[0] = prefix + new_url[0]

            if isinstance(new_url[1], str):
                new_url[1] = "%s.%s" % (app_name, new_url[1])

            if len(app_url) == 4:
                new_url[3] = '%s.%s' % (app_name, new_url[3])
            mapping.append(tuple(new_url))
    return mapping


class LockMixin():
    @staticmethod
    def get_unique_value():
        return uuid.uuid4().hex

    def lock(self, cli, key, ttl):
        unique_value = self.get_unique_value()
        result = cli.set(key, unique_value, nx=True, ex=ttl)
        if result:
            return (key, unique_value, ttl)
        else:
            return False

    def unlock(self, cli, key, unique_value, *args):
        if cli.get(key) == unique_value:
            return cli.delete(key)
        else:
            return False

    @gen.coroutine
    def cache_or_lock(self, cli, cache_key, lock_key, ttl, wait):
        cache_result = cli.get(cache_key)
        if cache_result:
            raise gen.Return((cache_result, None))

        while True:
            lock_result = self.lock(cli, lock_key, ttl)
            cache_result = cli.get(cache_key)
            if cache_result or lock_result:
                raise gen.Return((cache_result, lock_result))
            else:
                wait = random.random() * wait
                yield gen.sleep(wait)


def cached(cli, cache_ttl, lock_ttl, wait, dynamic_key=False, prefix=''):
    def _cached(func):
        @gen.coroutine
        @functools.wraps(func)
        def warpper(self, *args, **kwargs):
            if dynamic_key:
                key = args
                if kwargs:
                    sorted_items = sorted(kwargs.items())
                    for item in sorted_items:
                        key.append(item)
                key = hashlib.md5(json.dumps(key).encode('utf8')).hexdigest()
                cache_key = "cache:" + (prefix and prefix + ':') + key
                lock_key = "lock:" + (prefix and prefix + ':') + key
            else:
                cache_key = self.cache_key
                lock_key = self.lock_key

            cache_result, lock_result = \
                yield self.cache_or_lock(cli,
                                         cache_key,
                                         lock_key,
                                         lock_ttl,
                                         wait)
            if cache_result is None:
                cache_result = yield func(self, *args, **kwargs)
                cli.set(cache_key, cache_result, ex=cache_ttl)
            if lock_result:
                self.unlock(cli, *lock_result)
            raise gen.Return(cache_result)

        return warpper
    return _cached
