import tornado.web
from settings import site_settings

apps = [
    # (r'/prefix', 'app_name')
    # appA
    #     __init__.py
    #     urls.py
    (r"/api", "api"),
]

urls = [
    # (r'relative_url', 'RequestHandler')
    (r"/static", tornado.web.StaticFileHandler,
     dict(path=site_settings['static_path'])),
]
