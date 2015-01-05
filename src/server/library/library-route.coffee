Watcher = require './library-watcher'

module.exports = (app, config)->
  watcher = new Watcher(config.stassets)
  app.use (q, s, n)->
    if watcher.matches q.path
      return watcher.handle(q, s, n)
    else
      n()
