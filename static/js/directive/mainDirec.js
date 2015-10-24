/**
 * Created by mingtao on 15-10-24.
 */

app.directive('myTable', function() {
    return {
        restrict: 'A',
        template: '\
            <table>                                         \
                <tr>                                        \
                    <td>1</td>                              \
                    <td>                                        \
                    {{myName}}\
                    <select ng-model="ww">\
                    <option>11</option>\
                    <option>22</option>\
                    </select>\
                    </td>                              \
                 </tr>                  \
            </table>                                        \
            sssss\
            {{JSON.parse(sfTable).columns}}\
            <li ng-repeat="i in [1,2]">\
            {{i}}\
            </li>                                                  \
            ',
        replace: false,
        scope: {
            sfTable: '@'
            //name: this.sfTable.name,
            //url: this.sfTable.url,
            //permission: this.sfTable.permission,
            //columns: this.sfTable.columns
        },
        controller: function() {
       //     console.log(sfTable);
        }
    };
});