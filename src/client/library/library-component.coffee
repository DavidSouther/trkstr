class LibraryController
    constructor: (@Library, @PlayAction)->
      @artists = @Library.artists
      @Library.on @Library.Events.DataChanged, @update.bind @

    update: ->
      @shown = {}
      @artists = @Library.artists

    toggle: (name)->
      @shown[name] = !@shown[name]

    play: (track)->
      (new @PlayAction(track)).dispatch()

LibraryController.$inject = [
  'TrkstrLibrary'
  'PlayAction'
]

class LibraryComponent
  constructor: ->
    @controller = LibraryController
    @templateUrl = 'library'

angular.module('trkstr.library.component', [
  'trkstr.actions',
  'trkstr.stores.library',

  'library.template',
  'ngMaterial'
]).component 'library', LibraryComponent
