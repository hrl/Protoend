/**
 *
 * Created by mingtao on 15-10-24.
 */
$('.drawLink').click(function() {
    $('.theTable tr').addClass('isActive');
    document.status = 'link';
});

//画线
document.drawLine = function(mapping) {
    //mapping [  [1, 2]  ,   3    ]
    var c=document.getElementById("realCanvas");
    var cxt=c.getContext("2d");
    cxt.moveTo(10,10);
    cxt.lineTo(150,50);
    cxt.lineTo(10,50);
    cxt.stroke();
};
