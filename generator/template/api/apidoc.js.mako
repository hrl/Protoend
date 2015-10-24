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

%for table in tables:
<%name= table['name'].lower()%>
/**
 *@api {get} /${name}s/:id Get${table["name"]}
 *@apiName Get${table["name"]}
 *@apiVersion 0.1.0
 *@apiGroup ${table["name"]}
 *
 *@apiParam {Number} id Users unique ID.
%for column in table['columns']:
 *@apiSuccess {${column['type']}} ${column['name']} ...
%endfor
 *@apiSuccessExample {json} Success-Response:
    * HTTP/1.1 {
    <%
        count = len(table['columns'])-1
    %>
    %for column in table['columns']:
        %if loop.index==count:
            "${column['name']}":${column['type']}
        %else:
            "${column['name']}":${column['type']},
        %endif
    %endfor
    }
 *
 *@apiUse MyError
 */

/**
 * @api {post} /${name}s/ Create${table["name"]}
 * @apiName Create${table["name"]}
 * @apiVersion 0.1.0
 * @apiGroup ${table["name"]}
 *
%for column in table['columns']:
 * @apiParam {${column['type']}} ${column['name']} ...
%endfor
 *
 * @apiUse MySuccess
 * @apiUse MyError
 */
/**
 * @api {put} /${name}s/:id Modify${table['name']}
 * @apiName Modify${table['name']}
 * @apiVersion 0.1.0
 * @apiGroup ${table['name']}
 *
 * @apiParam {Number} idunique ID.
%for column in table['columns']:
 * @apiParam {${column['type']}} ${column['name']} ...
%endfor
 *
 * @apiUse MySuccess
 * @apiUse MyError
 */
/**
* @api {delete} /${name}s/:id Delete${table['name']}
 * @apiName Delete${table['name']}
 * @apiVersion 0.1.0
 * @apiGroup ${table['name']}
 *
 * @apiParam {Number} id ${name} unique ID.
 *
 * @apiUse MySuccess
 * @apiUse MyError
 */
%endfor
