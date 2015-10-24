from handlers import *
import tornado.web
import tornado.ioloop
#@from tornado import autoreload
import os

TEMPLATEPATH = os.path.join(os.path.dirname(__file__),'templatepath')
STATICPATH = os.path.join(os.path.dirname(__file__),'static')

class Application( tornado.web.Application  ):
    def __init__(self):
        handlers = [
            ('/',IndexHandler),
            (r"/static", tornado.web.StaticFileHandler,
             dict(path=STATICPATH)),
        ]

        settings = dict(
            template_path = TEMPLATEPATH,
            static_path = STATICPATH,
            #default_handler_class=NotFoundHandler,
            gzip=True,
            #@cookie_secret=SECRET_KEY,
            #xsrf_cookies=True
            )
        tornado.web.Application.__init__(self,handlers,**settings)


if __name__ == '__main__':
    application = Application()
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
