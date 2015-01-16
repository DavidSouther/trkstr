class PlayerController
  constructor: (@store)->
    @store.on @store.Events.TrackChanged, @play.bind @
    @play()

  play: ->
    @track = @store.currentTrack

PlayerController.$inject = [
  'PlayerStore'
]

class PlayerDirective
  constructor: ->
    @controller = PlayerController
    @templateUrl = 'player'

angular.module('trkstr.player.component', [
  'trkstr.stores.player'
  'player.template'
]).component 'player', PlayerDirective
