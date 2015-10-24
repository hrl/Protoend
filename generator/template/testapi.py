from mako.template import Template

tables = [
    {
        "name": "User",
        "url": "/users",
        "permission": None,
        "columns": [
            {
                "name": "id",
                "type": "GUID",
                "default": "GUID",
                "userInput": False
            },
            {
                "name": "username",
                "type": "Unicode(20)"
            },
            {
                "name": "password",
                "type": "PASSWORD",
                "display": False
            },
            {
                "name": "mail",
                "type": "CHAR(128)",
                "unique": True
            }
        ]
    },
    {
        "name": "Blog",
        "url": "/blogs",
        "permission": "login",
        "columns": [
            {
                "name": "id",
                "type": "INTEGER",
                "default": "GUID",
                "userInput": None
            },
            {
                "name": "owner",
                "type": "GUID",
                "ralation": {
                    "type": "OneToOne",
                    "target": "User"
                },
                "default": "{current_user}",
                "userInput": False
            },
            {
                "name": "title",
                "type": "Unicode(20)",
                "display": True
            },
            {
                "name": "detail",
                "type": "UnicodeText",
                "display": True
            }
        ]
    }
]

mytemplate = Template(filename='./apidoc.json.mako')
with open('apidoc.json','w') as f:
    f.write(mytemplate.render(tables=tables))
