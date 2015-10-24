apps = [
]

urls = [
    (r'/User/register', 'User.RegisterHandler'),
    (r'/User/login', 'User.LoginHandler'),
    (r'/User', 'User.ProfileHandler'),
    % for table in tables:
    (r'/${table["name"]}s','${table["name"]}.${table["name"]}sHandler'),
    %if table['columns'][0]['type'] == 'GUID':
    (r'/${table["name"]}s/(?P<key>[0-9a-zA-Z]{32})','${table["name"]}.${table["name"]}Handler'),
    %else:
    (r'/${table["name"]}s/(?P<key>[0-9]+)','${table["name"]}.${table["name"]}Handler'),
    %endif
    % endfor
]
