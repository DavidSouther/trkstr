class LibraryController
  constructor: (@Library)->
    @artists = @Library.artists
    @Library.on @Library.Events.DataChanged, @update.bind @

  update: ->
    @artists = @Library.artists

LibraryController.$inject = [
  'TrkstrLibrary'
]

class LibraryDirective
  constructor: ->
    @controller = LibraryController
    @templateUrl = 'library'
    @replace = no
    @restrict = 'E'
    @controllerAs = 'state'
    @bindToController = yes
    @scope = {}

LibraryDirective.factory = ->
  new LibraryDirective()

LibraryDirective.factory.$inject = []

angular.module('trkstr.library.directive', [
  'trkstr.actions',
  'trkstr.stores.library',

  'library.template',
  'ngMaterial'
]).directive 'library', LibraryDirective.factory
