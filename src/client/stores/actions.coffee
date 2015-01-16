class LoadAction
  constructor: ->
    @module = 'trkstr'
    @purpose = "Request dispatched stores refresh their in-memory data."

class PlayAction
  constructor: (@track)->
    @module = 'trkstr'
    @purpose = 'Request a track be played.'

# TrkstrActionsFactory.$inject = [
#   'songFactory'
# ]

angular.module('trkstr.actions', [
  'songFlux'
])
# .factory 'TrkstrActions', TrkstrActionsFactory
.action LoadAction
.action PlayAction
