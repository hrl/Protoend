<%text>import json
import uuid

import models
from .. import base
from . import forms
</%text>


__all__ = [
    '${table["name"]}sHandler',
    '${table["name"]}Handler',
]
<%
    column_default = {
        "GUID": "uuid.uuid4()",
        "{current_user}": "self.current_user"
    }
%>

class ${table["name"]}sHandler(base.APIBaseHandler):
    def get(self):
        self.finish_objects(
            forms.${table["name"]}sForm,
            models.${table["name"]}
        )

    % if table["permission"] == "login":
    @base.authenticated()
    % endif
    def post(self):
        form = forms.${table["name"]}Form(
            self.json_args,
            locale_code=self.locale.code
        )

        if form.validate():
            ${table["name"]} = self.create_${table["name"]}(form)

            self.set_status(201)
            self.finish(json.dumps(
                ${table["name"]}.format_detail()
            ))
        else:
            self.validation_error(form)

    @base.db_success_or_500
    def create_${table["name"]}(self, form):
        ${table["name"]} = models.${table["name"]}(
            % for column in table["columns"]:
            % if column["userInput"] == False:
            ${column["name"]}=${column_default.get(column["type"], None)},
            % else:
            ${column["name"]}=form.${column["name"]}.data,
            % endif
            % endfor
        )
        self.session.add(${table["name"]})
        return ${table["name"]}


class ${table["name"]}Handler(base.APIBaseHandler):
    def get(self, key):
        self.finish_object(
            models.${table["name"]},
            key
        )

    % if table["permission"] == "login":
    @base.authenticated()
    % endif
    def patch(self, key):
        ${table["name"]} = self.get_or_404(
            self.session.query(models.${table["name"]}),
            key
        )
        form = forms.${table["name"]}sForm(
            self.json_args,
            locale_code=self.locale.code
        )

        if form.validate():
            ${table["name"]} = self.edit_${table["name"]}(form, ${table["name"]})

            self.finish(json.dumps(
                ${table["name"]}.format_detail()
            ))
        else:
            self.validation_error(form)

    @base.db_success_or_500
    def edit_list(self, form, ${table["name"]}):
        attr_list = [
            % for column in table["columns"]:
            % if column["userInput"] != False:
            '${column["name"]}',
            % endif
            % endfor
        ]
        self.apply_edit(${table["name"]}, form, attr_list)
        
        return ${table["name"]}
