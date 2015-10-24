import tornado.web
import tornado.gen
from tornado.escape import json_encode
import time
from threading import Thread
from generator import generator
import os


class Worker(Thread):
    def __init__(self, req):
        self.req = req
        self.input_path = os.path.join(os.getcwd(), 'generator/template')
        self.output_path = os.path.join(os.getcwd(), 'static/files')
        super(Worker, self).__init__()

    def run(self):
        # do the function here
        generator.render_all(self.input_path,
                             self.output_path,
                             self.output_path,
                             self.req.data)
        self.req.response['path'] = os.path.join('/static/files', 'backend.tar')


class BaseHandler(tornado.web.RequestHandler):
    def initialize(self):
        pass

    def get(self):
        pass

    def post(self):
        pass


class IndexHandler(BaseHandler):
    def get(self):
        self.redirect('/static/chartPage.html')


    #@tornado.web.asynchronous
    #@tornado.gen.engine
    def post(self):
        self.data = self.get_body_argument('data', '')
        self.name = self.get_argument('name', '')
        self.response = {}
        if self.data and self.filename:
            p = Worker(self)
            p.start()
            p.join()
            self.response['static'] = 200
        else:
            self.response['static'] = 400
        self.write(json_encode(self.response))
