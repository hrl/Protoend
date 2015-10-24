/**
 *@apiDefine  MySuccess
 *
 *@apiSuccess (Success 200) status 200
 *@apiSuccessExample {json} Success-Response:
 *  HTTP/1.1 {
 *      "status":200
 *  }
 */
/**
 *@apiDefine  MyError
 *@apiError (Error 4xx)  status 400
 *@apiErrorExample {json} Error-Response:
 *  HTTP/1.1 {
 *     "status":400
 *  }
 *
 */

<%!
    type_sample = {
        "GUID": "6fb1cfcea1784046bbce67548d0065e4",
    }
%>

%for table in tables:
<% name = table['name'] %>
<% primary_column = table['columns'][0] %>
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
 * @api {get} /${name}s/:key Get${table["name"]}
 * @apiName Get${table["name"]}
 * @apiVersion 0.1.0
 * @apiGroup ${table["name"]}
 *
 * @apiParam {${primary_column["type"]}} key
 *
 * @apiUse ${table['name']}_detail_200
 * @apiUse ${table['name']}_error_404
 */

/**
 * @api {post} /${name}s Create${table["name"]}
 * @apiName Create${table["name"]}
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
 * @api {patch} /${name}s/:key Modify${table['name']}
 * @apiName Modify${table['name']}
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
 * @api {delete} /${name}s/:key Delete${table['name']}
 * @apiName Delete${table['name']}
 * @apiVersion 0.1.0
 * @apiGroup ${table['name']}
 *
 * @apiParam {${primary_column["type"]}} key
 * @apiUse ${table['name']}_success_204
 * @apiUse ${table['name']}_error_404
 */
%endfor
