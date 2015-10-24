import tornado.web


class BaseHandler( tornado.web.RequestHandler ):
    
    def get(self):
        #return the static file
        pass
    
    def post(self):
        pass 


class IndexHandler( tornado.web.RequestHandler ):

    def get(self):
        self.write( 'hello world')

    def post(self):
        pass
