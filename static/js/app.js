/**
 * Created by hook on 10/24/15.
 */
var Angular = angular.module('protoend', ['ngRoute', 'homeCtrl']);
Angular.config(['$routeProvider', function($routeProvider) {
    $routeProvider.
        when('/', {templateUrl: './templates/home.html'}).
    //    //when('/phones/:phoneId', {templateUrl: 'partials/phone-detail.html', controller: PhoneDetailCtrl}).
        otherwise({redirectTo: '/'});

}]);
