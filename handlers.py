import tornado.web
import tornado.gen
from tornado.escape import json_encode
import time 
from threading import Thread 

class Worker(Thread):

    def __init__(self,req):
        self.req = req
        super(Worker,self).__init__()

    def run(self):
        #do the function here
        time.sleep(1)
        self.req.response['path'] = 'aa'


class BaseHandler( tornado.web.RequestHandler ):
    
    def initialize(self):
        pass
    
    def get(self):
        pass
    
    def post(self):
        pass 


class IndexHandler( BaseHandler ):

    def get(self):
        self.redirect( '/static/chartPage.html')



    #@tornado.web.asynchronous 
    #@tornado.gen.engine
    def post(self):
        data = self.get_body_argument('data','')
        if data:
            self.response = {}
            p = Worker(self)
            p.start()
            p.join()
            self.response['static'] = 200
        else:
            self.response['static'] = 400
        self.write(json_encode(self.response))

