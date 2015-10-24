/**
 *
 * Created by mingtao on 15-10-24.
 */

$(document).ready(function() {
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
});