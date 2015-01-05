class LibraryController
  constructor: (@Library, @Actions)->
    @artists = @Library.artists
    @Library.on @Library.Events.DataChanged, @update.bind @

  update: ->
    @shown = {}
    @artists = @Library.artists

  toggle: (name)->
    @shown[name] = !@shown[name]

  play: (track)->
    (new @Actions.PlayAction(track)).dispatch()

LibraryController.$inject = [
  'TrkstrLibrary'
  'TrkstrActions'
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
