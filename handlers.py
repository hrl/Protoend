import string
import random
import os
import os.path

import tornado.web
import tornado.gen

from generator import generator


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

    def post(self):
        data = self.request.body.decode('utf8')

        base_dir = os.path.dirname(__file__)
        static_dir = os.path.join(base_dir, 'static/')
        generator_template_dir = os.path.join(base_dir, 'generator/template')
        generator_output_base_dir = os.path.join(static_dir, 'generator/')

        random_value = ''.join(
            [random.choice(string.ascii_letters) for i in range(12)]
        )
        generator_output_dir = os.path.join(generator_output_base_dir,
                                            random_value)
        generator_output_tar = os.path.join(generator_output_base_dir,
                                            random_value + '.tar')
        os.mkdir(generator_output_dir)

        generator.render_all(generator_template_dir,
                             generator_output_dir,
                             generator_output_tar,
                             data)

        self.redirect('/static/generator/' + random_value + '.tar')
