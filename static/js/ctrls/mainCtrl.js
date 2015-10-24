/**
 * Created by mingtao on 15-10-24.
 */

var app = angular.module('app',[]);

app.controller('mainCtrl', function($scope) {
    $scope.show = function() {
        console.log(typeof $scope.tables[0].columns[0].unique);
    };
    //删除第i个表的第j行
    $scope.delItem = function(i, j) {
        $scope.tables[i].columns.splice(j, 1);
    };

    //删除第i张表
    $scope.delTable = function(i) {
        $scope.tables.splice(i, 1);
    };

    //新增一条
    $scope.createItem = function(i) {
        var newData = {
            name: 'filedName',
            type: 'Integer',
            relation: null,
            default: null,
            unique: false,
            userInput: true,
            display: true
        };
        $scope.tables[i].columns.push(newData);

    };
    //新建一张表
    $scope.createTable = function() {
        var newData = {
            name: 'name',
            permission: 'null',
            columns: []
        };
        $scope.tables.push(newData);
    };

    $scope.tables = [
        {
            name: 'name',
            permission: 'null',
            columns: [
                {
                    name: 'filedName',
                    type: 'Integer',
                    relation: null,
                    default: null,
                    unique: false,
                    userInput: true,
                    display: true
                },
                {
                    name: 'filedName',
                    type: 'UnicodeText',
                    relation: null,
                    default: null,
                    unique: false,
                    userInput: false,
                    display: false
                }
            ],
            editing: true
        }
    ];


});