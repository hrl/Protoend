/**
 * Created by mingtao on 15-10-24.
 */

var app = angular.module('app',[]);

app.controller('mainCtrl', function($scope) {
    //删除第i个表的第j行
    $scope.delItem = function(i, j) {
        $scope.tables[i].columns.splice(j, 1);
    };

    //删除第i张表
    $scope.delTable = function(i) {
        $scope.tables.splice(i, 1);
    };

    $scope.tables = [
        {
            name: 'name',
            permission: 'null',
            columns: [
                {
                    name: 'filedName',
                    type: 'Integer',
                    relation: 'null',
                    default: 'null',
                    unique: 'false',
                    userInput: 'true',
                    display: 'true'
                }
                ,
                {
                    name: 'filedName',
                    type: 'UnicodeText',
                    relation: 'null',
                    default: 'null',
                    unique: 'false',
                    userInput: 'false',
                    display: 'false'
                }
            ]
        }
        ,
        {
            name: 'name',
            permission: 'null',
            columns: [
                {
                    name: 'filedName',
                    type: 'PASSWORD',
                    relation: 'null',
                    default: 'null',
                    unique: 'false',
                    userInput: 'null',
                    display: 'true'
                }
            ]
        }
    ];


});