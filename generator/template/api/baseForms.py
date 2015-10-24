from form import Form
from wtforms.fields import (
    Field,
    StringField,
    SelectField,
    IntegerField,
    BooleanField,
    DateTimeField,
)


class SliceMixin():
    limit = IntegerField('limit')
    offset = IntegerField('offset')
