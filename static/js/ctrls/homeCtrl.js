/**
 * Created by hook on 10/24/15.
 */

var homeCtrl = angular.module('homeCtrl',[]);
homeCtrl.controller('homeCtrll', function ($scope) {
    $(document).ready(function() {
        $('#pagepiling').pagepiling({
            menu: null,
            direction: 'horizontal',
            verticalCentered: true,
            sectionsColor: ['#EEB65B','#EEB65B','#EEB65B'],
            anchors: [],
            scrollingSpeed: 700,
            easing: 'swing',
            loopBottom: false,
            loopTop: false,
            css3: true,
            navigation: false,
            normalScrollElements: null,
            normalScrollElementTouchThreshold: 5,
            touchSensitivity: 5,
            keyboardScrolling: true,
            sectionSelector: '.section',
            animateAnchor: false,
            //events
            onLeave: function(index, nextIndex, direction){},
            afterLoad: function(anchorLink, index){
                if(index == 2){
                    //$("#thumbnail1").fadeIn(1000).css('display', 'inline-block');
                    //$("#thumbnail2").fadeIn(1600).css('display', 'inline-block');
                    //$("#thumbnail3").fadeIn(2200).css('display', 'inline-block');
                }
            },
            afterRender: function(){}
        });
    });
    $(".thumbnail-wrapper").on("click",function(){
        window.location= "#editor";
    });
    $("#btn-start").on("click",function(){
        $.fn.pagepiling.moveSectionDown()
    })
});