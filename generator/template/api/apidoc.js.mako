<%!
    type_sample = {
        "GUID": "6fb1cfcea1784046bbce67548d0065e4",
    }
%>

/**
 * @apiDefine User_detail_200
 * @apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 200 OK
 *  {
      <%
          table = [x for x in modules if x["name"] == "User"][0]
      %>
      % for relation in table["reverse_relations"]:
      <%
          target = relation["target"]
          column = target["columns"][0]
      %>
      % if relation["type"] == "OneToOne":
 *    "${target['name']}_key" = "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${target['name']}_key" = ["${type_sample.get(column['type'], column['type'])}"],
      % endif
      % endfor
 *    "id": "6fb1cfcea1784046bbce67548d0065e4",
 *    "username": "username"
 *  }
 */

/**
 * @apiDefine User_detail_201
 * @apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 201 Created
 *  {
      <%
          table = [x for x in modules if x["name"] == "User"][0]
      %>
      % for relation in table["reverse_relations"]:
      <%
          target = relation["target"]
          column = target["columns"][0]
      %>
      % if relation["type"] == "OneToOne":
 *    "${target['name']}_key" = "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${target['name']}_key" = ["${type_sample.get(column['type'], column['type'])}"],
      % endif
      % endfor
 *    "id": "6fb1cfcea1784046bbce67548d0065e4",
 *    "username": "username"
 *  }
 */

/**
 * @api {post} /User/register Register
 * @apiName Register
 * @apiVersion 0.1.0
 * @apiGroup User
 *
 * @apiParam {Unicode(20)} username
 * @apiParam {UnicodeText} password
 * @apiParam {UnicodeText} password2
 * 
 * @apiUse User_detail_201
 *
 * @apiErrorExample {json} Error-Response:
 *  HTTP/1.1 400 Bad Request
 *  [
 *    {
 *      "name": "username",
 *      "error": [
 *        "Already exists"
 *      ]
 *    }
 *  ]
 */

/**
 * @api {post} /User/login Login
 * @apiName Login
 * @apiVersion 0.1.0
 * @apiGroup User
 *
 * @apiParam {Unicode(20)} username
 * @apiParam {UnicodeText} password
 * @apiParam {UnicodeText} password2
 * 
 * @apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 200 OK
 *  {
 *    "auth": "signed_value"
 *  }
 * @apiErrorExample {json} Error-Response:
 *  HTTP/1.1 400 Bad Request
 *  [
 *    {
 *      "name": "username",
 *      "error": [
 *        "Invalid username or password"
 *      ]
 *    },
 *    {
 *      "name": "password",
 *      "error": [
 *        "Invalid username or password"
 *      ]
 *    }
 *  ]
 */

/**
 * @api {get} /User Get Self Detail
 * @apiName Get Self Detail
 * @apiVersion 0.1.0
 * @apiGroup User
 * 
 * @apiUse User_detail_200
 */

%for table in tables:
<% name = table['name'] %>
<% primary_column = table['columns'][0] %>
/**
 * @apiDefine ${table['name']}_details_200
 * @apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 200 OK
 *  [
 *    {
        % for relation in table["reverse_relations"]:
        <%
            target = relation["target"]
            column = target["columns"][0]
        %>
        % if relation["type"] == "OneToOne":
 *      "${target['name']}_key" = "${type_sample.get(column['type'], column['type'])}",
        % else:
 *      "${target['name']}_key" = ["${type_sample.get(column['type'], column['type'])}"],
        % endif
        % endfor
        % for column in [x for x in table['columns'] if x['display'] == True]:
        % if column["relation"]:
        % if not loop.last:
 *      "${column['name']}_key": "${type_sample.get(column['type'], column['type'])}",
        % else:
 *      "${column['name']}_key": "${type_sample.get(column['type'], column['type'])}"
        % endif
        % else:
        % if not loop.last:
 *      "${column['name']}": "${type_sample.get(column['type'], column['type'])}",
        % else:
 *      "${column['name']}": "${type_sample.get(column['type'], column['type'])}"
        % endif
        % endif
        % endfor
 *    }
 *  ]
 */

/**
 * @apiDefine ${table['name']}_detail_200
 * @apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 200 OK
 *  {
      % for relation in table["reverse_relations"]:
      <%
          target = relation["target"]
          column = target["columns"][0]
      %>
      % if relation["type"] == "OneToOne":
 *    "${target['name']}_key" = "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${target['name']}_key" = ["${type_sample.get(column['type'], column['type'])}"],
      % endif
      % endfor
      % for column in [x for x in table['columns'] if x['display'] == True]:
      % if column["relation"]:
      % if not loop.last:
 *    "${column['name']}_key": "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${column['name']}_key": "${type_sample.get(column['type'], column['type'])}"
      % endif
      % else:
      % if not loop.last:
 *    "${column['name']}": "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${column['name']}": "${type_sample.get(column['type'], column['type'])}"
      % endif
      % endif
      % endfor
 *  }
 */

/**
 * @apiDefine ${table['name']}_detail_201
 * @apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 201 Created
 *  {
      % for relation in table["reverse_relations"]:
      <%
          target = relation["target"]
          column = target["columns"][0]
      %>
      % if relation["type"] == "OneToOne":
 *    "${target['name']}_key" = "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${target['name']}_key" = ["${type_sample.get(column['type'], column['type'])}"],
      % endif
      % endfor
      % for column in [x for x in table['columns'] if x['display'] == True]:
      % if column["relation"]:
      % if not loop.last:
 *    "${column['name']}_key": "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${column['name']}_key": "${type_sample.get(column['type'], column['type'])}"
      % endif
      % else:
      % if not loop.last:
 *    "${column['name']}": "${type_sample.get(column['type'], column['type'])}",
      % else:
 *    "${column['name']}": "${type_sample.get(column['type'], column['type'])}"
      % endif
      % endif
      % endfor
 *  }
 */

/**
 * @apiDefine ${table['name']}_success_204
 * @apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 204 No Content
 */

/**
 * @apiDefine ${table['name']}_error_404
 * @apiErrorExample {json} Error-Response:
 *  HTTP/1.1 404 Not Found
 *  [
 *    {
 *      "error": [
 *        "Not Found"
 *      ]
 *    }
 *  ]
 */

/**
 * @api {get} /${name}s/:key Get ${table["name"]}
 * @apiName Get ${table["name"]}
 * @apiVersion 0.1.0
 * @apiGroup ${table["name"]}
 *
 * @apiParam {${primary_column["type"]}} key
 *
 * @apiUse ${table['name']}_detail_200
 * @apiUse ${table['name']}_error_404
 */

/**
 * @api {get} /${name}s Get ${table["name"]} List
 * @apiName Get ${table["name"]} List
 * @apiVersion 0.1.0
 * @apiGroup ${table["name"]}
 *
 * @apiParam {${primary_column["type"]}} key
 * @apiParam {Integer} offset
 * @apiParam {Integer} limit
 * @apiParam {String} sortby
 * @apiParam {String} order
 *
 * @apiUse ${table['name']}_details_200
 */

/**
 * @api {post} /${name}s Create ${table["name"]}
 * @apiName Create ${table["name"]}
 * @apiVersion 0.1.0
 * @apiGroup ${table["name"]}
 *
 % for column in [x for x in table['columns'] if x['userInput'] != False]:
 % if column['userInput'] == True:
 * @apiParam {${column['type']}} ${column['name']}
 % else:
 * @apiParam {${column['type']}} [${column['name']}]
 % endif
 % endfor
 * @apiUse ${table['name']}_detail_201
 */

/**
 * @api {patch} /${name}s/:key Modify ${table['name']}
 * @apiName Modify ${table['name']}
 * @apiVersion 0.1.0
 * @apiGroup ${table['name']}
 *
 * @apiParam {${primary_column["type"]}} key
 % for column in [x for x in table['columns'] if x['userInput'] != False]:
 % if column['userInput'] == True:
 * @apiParam {${column['type']}} ${column['name']}
 % else:
 * @apiParam {${column['type']}} [${column['name']}]
 % endif
 % endfor
 * @apiUse ${table['name']}_detail_200
 * @apiUse ${table['name']}_error_404
 */

/**
 * @api {delete} /${name}s/:key Delete ${table['name']}
 * @apiName Delete ${table['name']}
 * @apiVersion 0.1.0
 * @apiGroup ${table['name']}
 *
 * @apiParam {${primary_column["type"]}} key
 * @apiUse ${table['name']}_success_204
 * @apiUse ${table['name']}_error_404
 */
%endfor
