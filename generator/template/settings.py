import os

__all__ = [
    "site_settings",
    "database_settings",
    "redis_settings",
    "cache_settings",
]

BASE_DIR = os.path.dirname(__file__)
TEMPLATE_DIR = os.path.join(BASE_DIR, 'templates/').replace('\\', '/')
STATIC_DIR = os.path.join(BASE_DIR, 'static/').replace('\\', '/')
LOCALE_DIR = os.path.join(BASE_DIR, 'locale/').replace('\\', '/')

site_settings = {
    "debug": True,
    "cookie_secret": "__TODO:_GENERATE_YOUR_OWN_RANDOM_VALUE_HERE__",
    "xsrf_cookies": False,
    "login_url": "/login",
    "autoescape": None,
    "port": 8000,
    "base_path": BASE_DIR,
    "template_path": TEMPLATE_DIR,
    "static_path": STATIC_DIR,
    "locale_path": LOCALE_DIR,
    "locale_domain": "wtforms",
    "salt_length": 12,
}

database_settings = {
    "default": "sqlite:///database.db",
}

redis_settings = {
    'host': 'localhost',
    'port': 6379,
}

cache_settings = {
}
