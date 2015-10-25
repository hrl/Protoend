apps = [
]

urls = [
% for table in tables:
    <%
        handler = table['name'] + 'shandler'
        handler1 = table["name"] + 'Handler'
    %>
    (r'/${table["name"]}s/','handlers.${handler}'),
    %if table['columns'][0]['type'] == 'GUID':
    (r'/${table["name"]}s/(?P<id>[0-9a-zA-Z]+)/','handlers.${handler1}')
    %else:
    (r'/${table["name"]}s/(?P<id>[0-9]+)/','handlers.${handler1}')
    %endif
% endfor
]
