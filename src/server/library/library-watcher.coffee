Path = require 'path'
awp = '../../../node_modules/rupert/node_modules/stassets/lib/Watchers/Asset'
AssetWatcher = require awp

class LibraryWatcher extends AssetWatcher
  constructor: (@config)->
    @config = JSON.parse JSON.stringify @config
    @config.source or= Path.normalize Path.join __dirname, '../../../music'
    unless @config.source instanceof Array
        @config.source = [ @config.source ]
    @config.root = @config.source
    @meta = yes

    super()

    @log @config

  pattern: ->
    super [
      "**/*.mp3"
    ]

  matches: (path)-> path in ['/library.json']
  type: -> "application/json"

  render: (_, filename)->
    [x, artist, album, track, title, format] = filename.match ///
      / # Opening slash
      ([^/]+)/ # Artist
      ([^/]+)/ # Album
      ([0-9]+)- # Track
      (.*)
      \.(mp3) # Type
    ///

    track = parseInt track
    path = @pathpart filename

    {artist, album, track, title, format, path}

  concat: (_)->
    library = {}

    _.forEach (listing)->
      artist = library[listing.artist] or= {}
      album = artist[listing.album] or= []
      album[listing.track] or=
        title: listing.title
        format: listing.format
        path: listing.path

    JSON.stringify library

module.exports = LibraryWatcher
