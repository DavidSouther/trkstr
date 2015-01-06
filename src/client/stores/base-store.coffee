StoreFactory = (song)->
  class Store extends EventEmitter
    constructor: ->
      super()
      @module or= 'trkstr'
      @dispatcher = song.getDispatcher(@module)

    register: (ActionCtor, fn)->
      @dispatcher.register ActionCtor, fn.bind @

StoreFactory.$inject = [
  'songFactory'
]

angular.module('trkstr.stores.base', [
  'songFlux'
]).factory 'TrkstrStore', StoreFactory
