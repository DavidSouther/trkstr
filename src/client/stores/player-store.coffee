PlayerFactory = (Actions, Store)->
  class PlayerStore extends Store
    constructor: ->
      super()
      @currentTrack = title: "Nothing Playing..."
      @doPlay = @register Actions.PlayAction, @play
      @Events = PlayerStore.Events

    play: (playAction)->
      @currentTrack = playAction.track
      @emit PlayerStore.Events.TrackChanged

  PlayerStore.Events =
    TrackChanged: 'TrackChanged'

  new PlayerStore()

PlayerFactory.$inject = [
  'TrkstrActions'
  'TrkstrStore'
]

angular.module('trkstr.stores.player', [
  'trkstr.actions'
  'trkstr.stores.base'
]).factory 'PlayerStore', PlayerFactory
