class Library extends EventEmitter
  constructor: (@http, Actions, dispatcher)->
    @dispatcher = dispatcher.get('trkstr')
    @doLoad = @dispatcher.register Actions.LoadAction, @load.bind @

  load: ->
    @http.get('/library.json').then ({data})=>
      console.log data
      @emit 'DataLoaded'

Library.$inject = [
  '$http'
  'TrkstrActions'
  'songDispatcherFactory'
]

angular.module('trkstr.stores.library', [
  'trkstr.actions'
]).service 'TrkstrLibrary', Library
