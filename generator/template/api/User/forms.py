from form import Form
from wtforms.fields import (
    Field,
    IntegerField,
    StringField,
    SelectField,
)
from wtforms.validators import (
    ValidationError,
    StopValidation,
    InputRequired,
    EqualTo,
    Length,
)

import models
from .. import baseForms
from .. import baseValidators


class RegisterForm(Form):
    """
    Used in:
        User.RegisterHandler
            method=['POST']
            Create a new user.
        User.ProfileHandler
            method=['PATCH']
            Edit profile.
    Additional params:
        current_user models.User()
        username_ignore models.User().username
    """
    username = StringField('username', [
        InputRequired(),
        Length(max=20),
    ])
    password = StringField('password', [
        InputRequired(),
        Length(min=8),
    ])
    password2 = StringField('password2', [
        InputRequired(),
        EqualTo('password'),
    ])

    # used in user.ProfileHandler
    self_password = StringField('self_password')

    def validate_self_password(form, field):
        current_user = form.kwargs.get("current_user", None)
        if current_user is None:
            return

        if not current_user.check_password(field.data):
            _ = field.gettext
            raise StopValidation(_("Invalid password."))

    def validate_username(form, field):
        if field.data is None:
            return
        if baseValidators.ignore_match('username_ignore', form, field):
            return

        _ = field.gettext
        count = models.User.query\
            .filter(models.User.username == field.data)\
            .count()
        if count != 0:
            raise ValidationError(_('Already exists.'))


class LoginForm(Form):
    """
    Used in:
        User.LoginHandler
            method=['POST']
            Get auth token.
    """
    username = StringField('username', [
        InputRequired(),
        Length(max=20),
    ])
    password = StringField('password', [
        InputRequired(),
    ])

    def validate_username(form, field):
        _ = field.gettext
        try:
            user = models.User.query\
                .filter_by(username=form.username.data)\
                .first()
            assert user.check_password(form.password.data) is True
            form.kwargs['user'] = user
        except Exception:
            raise ValidationError(_('Invalid username or password.'))

    validate_password = validate_username
