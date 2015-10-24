<%text>import uuid
import json

from wtforms.validators import (
    ValidationError,
    StopValidation,
)
import models


def ignore_match(kw, form, field):
    ignore = form.kwargs.get(kw, None)
    if ignore is not None\
            and ignore == field.data:
        return True


def boolean_check(form, field):
    if field.data is None:
        return
    if field.data is True:
        field.data = True
    else:
        field.data = False


def objects_get(query, msg):
    def _objects_get(form, field):
        datas = list()
        for data_id in set(field.data):
            try:
                data = query.get(data_id)
                assert data is not None
                datas.append(data)
            except Exception:
                raise StopValidation(msg)
        field.data = tuple(datas)
    return _objects_get


def object_get(query, msg):
    def _object_get(form, field):
        try:
            target = query.get(field.data)
            assert target is not None
            field.data = target
        except Exception:
            raise StopValidation(msg)
    return _object_get
</%text>


% for table in tables:
def ${table["name"]}_get(form, field):
    _ = field.gettext
    return object_get(models.${table["name"]}.query,
                      _('Invalid ${table["name"]}.'))(form, field)


def ${table["name"]}s_get(form, field):
    _ = field.gettext
    return objects_get(models.${table["name"]}.query,
                       _('Invalid ${table["name"]}.'))(form, field)


% endfor
