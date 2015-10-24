import json

import models
from .. import base
from . import forms


__all__ = [
    "RegisterHandler",
    "LoginHandler",
    "ProfileHandler",
]


class RegisterHandler(base.APIBaseHandler):
    """
    URL: /user/register
    Allowed methods: POST
    """
    def post(self):
        """
        Create a new user.
        """
        form = forms.RegisterForm(self.json_args,
                                  locale_code=self.locale.code)
        if form.validate():
            user = self.create_user(form)

            self.set_status(201)
            self.finish(json.dumps({
                'auth': self.create_signed_value('uid', user.id.hex).decode('utf8'),
            }))
        else:
            self.validation_error(form)

    @base.db_success_or_500
    def create_user(self, form):
        user = models.User(username=form.username.data,
                           password=form.password.data)
        self.session.add(user)
        return user


class LoginHandler(base.APIBaseHandler):
    """
    URL: /user/login
    Allowed methods: POST
    """
    def post(self):
        """
        Get auth token.
        """
        form = forms.LoginForm(self.json_args,
                               locale_code=self.locale.code)
        if form.validate():
            user = form.kwargs['user']

            self.finish(json.dumps({
                'auth': self.create_signed_value('uid', user.id.hex).decode('utf8'),
            }))
        else:
            self.validation_error(form)


class ProfileHandler(base.APIBaseHandler):
    """
    URL: /user
    Allowed methods: GET, PATCH
    """
    @base.authenticated()
    def get(self):
        """
        Check your profile.
        """
        self.finish(json.dumps(
            self.current_user.format_detail()
        ))

    @base.authenticated()
    def patch(self):
        """
        Edit your profile.
        """
        form = forms.RegisterForm(self.json_args,
                                  locale_code=self.locale.code,
                                  current_user=self.current_user,
                                  username_ignore=self.current_user.username)
        if form.validate():
            self.edit_profile(form)

            self.finish(json.dumps(
                self.current_user.format_detail()
            ))
        else:
            self.validation_error(form)

    @base.db_success_or_500
    def edit_profile(self, form):
        attr_list = ['username']
        self.apply_edit(self.current_user, form, attr_list)

        if form.password.data:
            self.current_user.set_password(form.password.data)
