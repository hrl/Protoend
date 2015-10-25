/**
 * Created by mingtao on 15-10-24.
 */

var app = angular.module('app',[]);

app.controller('mainCtrl', function($scope, $rootScope) {
    document.allLink = [];

    $scope.submit = function() {
        //先将link合并
        for (var link = 0; link < document.allLink.length; link++) {
            var obj = $scope.tables[document.allLink[link][0][0]].columns[document.allLink[link][0][1]];
            obj.relation = {
                "type": "ManyToOne",
                "target": $scope.tables[document.allLink[link][1]].name
            };
        }

        $.ajax({
            url: "/",
            type: 'POST',
            data: JSON.stringify({
                "modules": ["User"],
                "tables": $scope.tables
            }),
            contentType: 'application/json',
            success: function (data) {
                $scope.$apply(function () {
                    $rootScope.tar=data.tar;
                    $rootScope.doc=data.doc;
                });
            }
        });
    };
    $scope.ok = function() {

        $scope.editNum = null;
    };
    $scope.edit = function(i) {

        $scope.editNum = i;
    };

    $scope.editNum = 1;
    $scope.linkContainer = [];

    $scope.pushLink = function(i, j) {
        if(document.status == 'link') {
            var container = $scope.linkContainer;

            if (container.length == 0) {
                container.push([i, j]);
                //加上函数：下一个只能选整个表
            } else if (container.length == 1) {
                //自己不能连自己
                if(container[0][0] != i) {
                    document.allLink.push([container[0], i]);
                    document.drawLine([container[0], i]);
                }
                container.length = 0;
            }

        }
    };

    //删除第i个表的第j行
    $scope.delItem = function(i, j) {
        $scope.tables[i].columns.splice(j, 1);
    };

    //删除第i张表
    $scope.delTable = function(i) {
        $scope.tables.splice(i, 1);

        //删除相应的relation
        for(var i in document.allLink) {
            var a = document.allLink[i];
            if(a[0][0] == i || a[1] == i) {
                document.allLink.splice(i, 1);
                console.log('rela');
            }

        }
        ctx.clearRect(0,0,1000,1000);
        for(var i in document.allLink) {
            document.drawLine(document.allLink[i]);
        }
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
    $scope.createTable = function($event) {
        if(document.status == 'add') {
            var newData = {
                //随机
                name: 'Table' + $event.offsetX,
                permission: null,
                columns: [{
                    name: 'id',
                    type: 'Integer',
                    relation: null,
                    default: null,
                    unique: true,
                    userInput: false,
                    display: true
                }],
                editing: true,
                coor: [$event.offsetX, $event.offsetY]
            };
            $scope.tables.push(newData);
            document.status = null;
        }
    };

    $scope.tables = [
        {
            name: 'name',
            permission: null,
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
            ]
        },
        {
            name: 'ame',
            permission: null,
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
            ]
        }
    ];
    $('#chart').mousemove(function(e) {
        if (!!document.move) {
            var posix = !document.move_target ? {'x': 0, 'y': 0} : document.move_target.posix,
                callback = document.call_down || function() {
                        $(document.move_target).css({
                            'top': e.pageY - posix.y,
                            'left': e.pageX - posix.x
                        });
                    };

            callback.call(this, e, posix);
            ctx.clearRect(0,0,1000,1000);

            for(var i in document.allLink) {
                document.drawLine(document.allLink[i]);
            }
        }
    });

//要改成document.on
    $(document).on('click', '.theTable', function(e) {
        //移动
        if(document.status == 'move') {
            if (!document.move) {
                var offset = {top: $(this)[0].offsetTop, left: $(this)[0].offsetLeft};

                this.posix = {'x': e.pageX - offset.left, 'y': e.pageY - offset.top};
                $.extend(document, {'move': true, 'move_target': this});
            } else {
                $.extend(document, {'move': false});
                document.status = null;
            }
        }

    });

    //使表处于可移动状态
    $(document).on('click', '#move', function(e) {
        document.status = 'move';
    });

    //使表处于可移动状态
    $(document).on('click', '#createTable', function(e) {
        document.status = 'add';
    });
    $('.drawLink').click(function() {
        $('.theTable tr').addClass('isActive');
        document.status = 'link';
    });

//画线
    document.drawLine = function(mapping) {
        //mapping [  [1, 2]  ,   3    ]
        //如果要随机的话，要在生成mapping时就搞好


        var aspect = $('#objAspect');
        var startObj = $('[theindex='+mapping[0][0]+'] tr:nth-child('+(mapping[0][1]+1)+')');
        var endObj = $('[theindex='+mapping[1]+'] tr:nth-child(1)');
        if(1) {
            //从左边
            var start = [startObj.offset().left-aspect.offset().left,startObj.offset().top+startObj.height()/2-aspect.offset().top];
            var end = [endObj.offset().left-aspect.offset().left,endObj.offset().top+endObj.height()/2-aspect.offset().top];
            ctx.lineWidth = 1;
            var x = Math.min(start[0], end[0]) - 20;
            var second = [x, start[1]];
            var third = [x, end[1]];
            ctx.beginPath();
            ctx.moveTo(start[0], start[1]);
            ctx.lineTo(second[0], second[1]);
            ctx.lineTo(third[0], third[1]);
            ctx.lineTo(end[0], end[1]);
            ctx.stroke();
            ctx.closePath();

        } else {
            //从右边


        }
    };
    var c=document.getElementById("realCanvas");
    var ctx=c.getContext("2d");

    document.editNum = 1;


});