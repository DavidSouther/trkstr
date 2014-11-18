angular.module('trkstr.head-controller', [
  'trkstr.title-service'
]).controller('HeadCtrl', function($scope, TitleSvc){
  $scope.title = TitleSvc.title;
});
