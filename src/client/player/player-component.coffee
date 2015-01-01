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

    @replace = no
    @restrict = 'E'
    @controllerAs = 'state'
    @bindToController = yes
    @scope = {}

PlayerDirective.factory = ->
  new PlayerDirective()
PlayerDirective.factory.$inject = []

angular.module('trkstr.player.component', [
  'trkstr.stores.player'
  'player.template'
]).directive 'player', PlayerDirective.factory
