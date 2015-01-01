StoreFactory = (dispatcher)->
  class Store extends EventEmitter
    constructor: ->
      super()
      @module or= 'trkstr'
      @dispatcher = dispatcher.get(@module)

    register: (ActionCtor, fn)->
      @dispatcher.register ActionCtor, fn.bind @

StoreFactory.$inject = [
  'songDispatcherFactory'
]

angular.module('trkstr.stores.base', [
  'songDispatcher'
]).factory 'TrkstrStore', StoreFactory
