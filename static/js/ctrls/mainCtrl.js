/**
 * Created by mingtao on 15-10-24.
 */

var app = angular.module('app',[]);

app.controller('mainCtrl', function($scope) {
    $scope.allLink = [];
    $scope.linkContainer = [];

    $scope.pushLink_1 = function(i, j) {
        if(document.status == 'link') {
            var container = $scope.linkContainer;

            if (container.length == 0) {
                container.push([i, j]);
                //加上函数：下一个只能选整个表
            } else if (container.length == 1) {
                $scope.allLink.push([container[0], i]);
                container.length = 0;
                //画图
            }

        }
    };

    /*
    $scope.pushLink_2 = function(i) {
        if(document.status == 'link') {
            var container = $scope.linkContainer;

            if (container.length == 1) {
                $scope.allLink.push([container[0], i]);
            }
            container.length = 0;
        }
    };
    */

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
                    default: 1,
                    unique: false,
                    userInput: false,
                    display: false
                }
            ],
            editing: false
        },
        {
            name: 'ame',
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
                    default: 1,
                    unique: false,
                    userInput: false,
                    display: false
                }
            ],
            editing: false
        }
    ];


});