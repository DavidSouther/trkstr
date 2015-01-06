TrkstrActionsFactory = (song)->
  class Action
    constructor: ->
      @module or= 'trkstr'
      @dispatcher = song.getDispatcher @module
    dispatch: ->
      @dispatcher.dispatch @

  class LoadAction extends Action
    constructor: ->
      @module = 'trkstr'
      @purpose = "Request dispatched stores refresh their in-memory data."
      super()

  class PlayAction extends Action
    constructor: (@track)->
      @module = 'trkstr'
      @purpose = 'Request a track be played.'
      super()

  {
    LoadAction
    PlayAction
  }

TrkstrActionsFactory.$inject = [
  'songFactory'
]

angular.module('trkstr.actions', [
  'songFlux'
]).factory 'TrkstrActions', TrkstrActionsFactory
