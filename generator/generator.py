from mako.template import Template
import os
import shutil


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


def render_dir(input,output,render_data=None):
    try:
        os.mkdir(output)
    except:
        shutil.rmtree(output)
        os.mkdir(output)
    if not os.path.isabs(input):
        input = os.path.join(os.getcwd(),input)
    if not os.path.isabs(output):
        output = os.path.join(os.getcwd(),output)

    if os.path.isdir(output) and os.path.splitext(output)[-1].lower()=='.mako':
        #function for dir dirname *.mako
        os.rmdir(output)
        print(output)
    else: 
        for item in os. listdir(input):
            path = os.path.join(input,item) #inputpath
            outpath = os.path.join(output,item) #outputpath
            if  os.path.isdir(path):
                render_dir(path,outpath) 
            elif os.path.isfile(path) and os.path.splitext(path)[-1].lower()=='.mako':
                #function for file *.mako 
                pass
            else:
                shutil.copyfile(path,outpath)
        
        



def render_file(template_path, target_path, data):
    file_template = open(template_path, 'r')
    data_template = file_template.read()
    file_template.close()

    file_target = open(target_path, 'w')
    data_target = Template(data_template).render(**data)
    file_target.write(data_target)
    file_target.close()
