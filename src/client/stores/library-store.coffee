LibraryFactory = ($http, LoadAction, Store)->
  class Library extends Store
    constructor: ->
      super()
      @artists = Immutable.Set()
      @doLoad = @register LoadAction, @load
      @Events = Library.Events

    load: ->
      $http.get('/library.json').then ({data})=>
        # Iterate
        for artist, albums of data
          @addArtist artist, albums
        @emit @Events.DataLoded, data
        @emit @Events.DataChanged, data

    addArtist: (artist, albums)->
      artist = {
        name: artist
        albums: Immutable.Set()
      }

      for name, tracks of albums
        album = {
          name,
          tracks: Immutable.List()
        }
        for track in tracks when track?
          album.tracks = album.tracks.push track
        artist.albums = artist.albums.add album

      @artists = @artists.add Immutable.fromJS artist

  Library.Events =
    DataLoded: 'DataLoaded'
    DataChanged: 'DataChanged'

  new Library()

LibraryFactory.$inject = [
  '$http'
  'LoadAction'
  'TrkstrStore'
]

angular.module('trkstr.stores.library', [
  'trkstr.actions'
  'trkstr.stores.base'
])
# .store 'TrkstrLibrary', Library
.run (TrkstrLibrary, LoadAction)->
  (new LoadAction()).dispatch()

.factory 'TrkstrLibrary', LibraryFactory
