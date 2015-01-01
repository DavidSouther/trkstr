TrkstrActionsFactory = (dispatcher)->
  class Action
    constructor: ->
      @dispatcher = dispatcher.get(@module or 'trkstr')
    dispatch: ->
      @dispatcher.dispatch @

  class LoadAction extends Action
    constructor: ->
      @module = 'trkstr'
      @purpose = "Request dispatched stores refresh their in-memory data."
      super()

  {
    LoadAction
  }

TrkstrActionsFactory.$inject = [
  'songDispatcherFactory'
]

angular.module('trkstr.actions', [
  'songDispatcher'
]).factory 'TrkstrActions', TrkstrActionsFactory
