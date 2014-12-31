angular.module('trkstr', [
  'ngMaterial',
  'trkstr.head-controller',
  'trkstr.actions',
  'trkstr.stores.library',
])
.controller('AppCtrl', function($scope, $timeout, $mdSidenav) {
  $scope.toggleMenu = function(){
    $mdSidenav().toggle();
  };
})
.run(function(TrkstrLibrary, TrkstrActions){
  (new TrkstrActions.LoadAction()).dispatch();
})
;
