angular.module('trkstr', [
  'ngMaterial',
  'trkstr.head-controller'
])
.controller('AppCtrl', function($scope, $timeout, $mdSidenav) {
  $scope.toggleMenu = function(){
    $mdSidenav().toggle();
  };
})
;
