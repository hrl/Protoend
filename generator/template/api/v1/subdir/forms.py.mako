<%text>from form import Form
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
</%text>
