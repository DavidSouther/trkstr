class PlayerStore
  constructor: (PlayAction)->
    @module = 'trkstr'
    @currentTrack = title: "Nothing Playing..."
    @doPlay = @register PlayAction, @play
    @Events = PlayerStore.Events

  play: (playAction)->
    @currentTrack = playAction.track
    @emit PlayerStore.Events.TrackChanged

PlayerStore.Events =
  TrackChanged: 'TrackChanged'

PlayerStore.$inject = [ 'PlayAction' ]

angular.module('trkstr.stores.player', [
  'trkstr.actions'
]).store 'PlayerStore', PlayerStore
