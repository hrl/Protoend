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
        }
    });

//要改成document.on
    $(document).on('click', '.theTable', function(e) {
        if(!document.move) {
            var offset = {top: $(this)[0].offsetTop, left: $(this)[0].offsetLeft};

            this.posix = {'x': e.pageX - offset.left, 'y': e.pageY - offset.top};
            $.extend(document, {'move': true, 'move_target': this});
        } else {
            $.extend(document, {'move': false});
        }
    });
});
