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
