angular.module('trkstr', [
  'ngMaterial',
  'trkstr.head-controller',
  'trkstr.library.component',
  'trkstr.player.component'
])
.controller('AppCtrl', function($scope, $timeout, $mdSidenav) {
  $scope.toggleMenu = function(){
    $mdSidenav().toggle();
  };
})
;
