from mako.template import Template


def parse_raw_input(data):
    data["modules"] = [
        {
            "name": "User",
            "primary_key": "User.id",
            "reverse_relations": [],
            "columns": [
                {
                    "name": "id",
                    "type": "GUID"
                }
            ]
        }
    ]
    for table in data["tables"]:
        table.setdefault("reverse_relations", [])
        for i in range(len(table["columns"])):
            column = table["columns"][i]
            if i == 0:
                table["primary_key"] = table["name"] + '.' + column["name"]
                column["primary_key"] = True
                column["unique"] = True
            else:
                column["primary_key"] = False
            column.setdefault("default", None)
            column.setdefault("unique", False)
            column.setdefault("userInput", True)
            column.setdefault("display", True)
            if column.setdefault("relation"):
                target_name = column["relation"]["target"]
                target = [
                    x for x in data["tables"]+data["modules"]
                    if x["name"] == target_name
                ][0]
                target.setdefault("reverse_relations", []).append({
                    "type": column["relation"]["type"],
                    "target": table
                })
                column["relation"]["target"] = target
    return data


def render_all():
    pass


def render_dir():
    pass


def render_file(template_path, target_path, data):
    file_template = open(template_path, 'r')
    data_template = file_template.read()
    file_template.close()

    file_target = open(target_path, 'w')
    data_target = Template(data_template).render(**data)
    file_target.write(data_target)
    file_target.close()
