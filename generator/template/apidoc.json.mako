{
    "name":"apidoc",
    "version":"0.1.0",
    "description":"apidoc example",
    "title":"you api",
    "url":"",
    "order":[
        %for table in tables:
            %if loop.index==0:
                "Get${table['name']}"
            %else:
                ,"Get${table['name']}"
            %endif
        %endfor
            ]
}
