import os
import shutil
import json
import tarfile

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


def render_all(input_path, output_path, tar_path, render_data):
    render_data = parse_raw_input(json.loads(render_data))
    render_dir(input_path, output_path, render_data)
    apiinput_path = os.path.join(output_path,'api')
    apioutput_path = os.path.join(output_path,'apidoc')
    os.system('apidoc -i %s -o %s'%(apiinput_path,apioutput_path))
    tar = tarfile.open(tar_path, 'w')
    tar.add(output_path, 'backend')
    tar.close()


def render_dir(input_path, output_path, render_data):
    if output_path.split('.')[-1].lower() == 'mako':
        # render dir name
        # tmp handle
        parent_path = os.path.dirname(output_path)
        for table in render_data["tables"]:
            output_sub_path = os.path.join(parent_path, table["name"])
            render_sub_data = {
                'table': table
            }
            render_dir(input_path, output_sub_path, render_sub_data)
        return

    # normal dir
    # mkdir
    try:
        os.mkdir(output_path)
    except:
        shutil.rmtree(output_path)
        os.mkdir(output_path)

    # render sub dir
    for item in os.listdir(input_path):
        input_sub_path = os.path.join(input_path, item)
        output_sub_path = os.path.join(output_path, item)
        if os.path.isdir(input_sub_path):
            render_dir(input_sub_path, output_sub_path, render_data)
        elif output_sub_path.split('.')[-1].lower() == 'mako':
            render_file(input_sub_path, output_sub_path[:-5], render_data)
        else:
            shutil.copyfile(input_sub_path, output_sub_path)


def render_file(template_path, target_path, data):
    print("render: " + template_path)
    print("    to: " + target_path)
    file_template = open(template_path, 'r')
    data_template = file_template.read()
    file_template.close()

    file_target = open(target_path, 'w')
    data_target = Template(data_template).render(**data)
    file_target.write(data_target)
    file_target.close()
