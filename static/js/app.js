/**
 * Created by hook on 10/24/15.
 */
var Angular = angular.module('protoend', ['ngRoute', 'homeCtrl', 'app', 'successCtrl']);
Angular.config(['$routeProvider', function($routeProvider) {
    $routeProvider.
    when('/', {templateUrl: './templates/home.html'}).
    when('/editor', {templateUrl: './templates/chartPage.html', controller: 'mainCtrl'}).
    when('/success', {templateUrl: './templates/success.html', controller: 'successController'}).
    otherwise({redirectTo: '/'});
}]);
