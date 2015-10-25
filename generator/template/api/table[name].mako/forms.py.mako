<%text>from form import Form
import uuid
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
<%
    prime_column = table["columns"][0]
    column_default = {
        "GUID": "uuid.uuid4()",
    }
%>


class ${table["name"]}sForm(Form, baseForms.SliceMixin):
    sortby = SelectField('sortby', default='${prime_column["name"]}', choices=[
        ('${prime_column["name"]}', '${prime_column["name"]}'),
    ])
    order = SelectField('order', default="asc", choices=[
        ("asc", "asc"),
        ("desc", "desc"),
    ])


class ${table["name"]}Form(Form):
    % for column in table["columns"]:
    % if column["userInput"] != False:
    ${column["name"]} = Field(
        '${column["name"]}',
        default=${column_default.get(column["default"], None)},
        validators=[
            % if column["userInput"] == True:
            InputRequired(),
            % endif
            % if column["relation"] != None:
            baseValidators.${column["relation"]["target"]["name"]}_get,
            % endif
        ],
    )
    % endif
    % endfor
