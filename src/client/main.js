angular.module('trkstr', [
  'ngMaterial',
  'trkstr.head-controller',
  'trkstr.actions',
  'trkstr.stores.library',
  'trkstr.library.directive'
])
.controller('AppCtrl', function($scope, $timeout, $mdSidenav) {
  $scope.toggleMenu = function(){
    $mdSidenav().toggle();
  };
})
;
