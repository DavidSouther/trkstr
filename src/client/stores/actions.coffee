TrkstrActionsFactory = (dispatcher)->
  class Action
    constructor: ->
      @dispatcher = dispatcher.get('trkstr')
    dispatch: ->
      @dispatcher.dispatch @

  class LoadAction extends Action
    constructor: ->
      @purpose = "Request dispatched stores refresh their in-memory data."
      super

  {
    LoadAction
  }

TrkstrActionsFactory.$inject = [
  'songDispatcherFactory'
]

angular.module('trkstr.actions', [
  'songDispatcher'
]).factory 'TrkstrActions', TrkstrActionsFactory
