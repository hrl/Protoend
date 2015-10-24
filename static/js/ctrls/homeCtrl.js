/**
 * Created by hook on 10/24/15.
 */

var homeCtrl = angular.module('homeCtrl',[]);
homeCtrl.controller('homeCtrl', function () {
    $(document).ready(function() {
        $('#pagepiling').pagepiling({
            menu: null,
            direction: ' horizontal',
            verticalCentered: true,
            sectionsColor: [],
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
            afterLoad: function(anchorLink, index){},
            afterRender: function(){}
        });

    });
});