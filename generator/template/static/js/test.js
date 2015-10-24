/**
 * Created by hook on 10/24/15.
 */
$(document).ready(function(){
    $.ajax({
        type: 'GET',
        url:'#',
        success: function(){
            console.log("拉取文章列表成功");
        }
    });
    $("#btn-login").on("click", function(){
        $(".div-mask").fadeIn();
        $("#div-login").fadeIn();
    });
    $("#btn-signup").on("click", function(){
        $(".div-mask").fadeIn();
        $("#div-signup").fadeIn();
    });
    $(".btn-cancel").on("click", function(){
        $(".div-pop").fadeOut(0);
        $(".div-mask").fadeOut(0);
    });
    $("#btn-login-submit").on("click", function(){
        $.ajax({
            type: 'POST',
            url:'#',
            success: function(){
                $(".btn-cancel").click();
                $("#btn-signup").fadeOut(0);
                $("#btn-login").fadeOut(0);
                $("#btn-addBlog").fadeIn(0);
            }
        })
    });
    $("#btn-signup-submit").on("click", function(){
        $.ajax({
            type: 'POST',
            url:'#',
            success: function(){
                $(".btn-cancel").click();
                $("#btn-signup").fadeOut(0);
                $("#btn-login").fadeOut(0);
                $("#btn-addBlog").fadeIn(0);
            }
        })
    });
    $("#btn-addBlog").on("click",function(){
        $(".div-mask").fadeIn();
        $("#editor-container").fadeIn();
    });
    var editor = new Simditor({
        textarea: $('#blog-editor')
        //optional options
    });

});