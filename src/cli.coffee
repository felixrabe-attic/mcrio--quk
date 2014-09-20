minimist = require 'minimist'
fs = require 'fs'
{join, resolve} = require('path')
require('mcrio-stdlib').monkey()
resolvePath = require 'resolve-path'

module.exports = ->
  # CONFIGURATION

  argv = minimist process.argv.splice 2

  config =
    port: parseInt argv.port ? argv.p ? process.env.PORT ? 8000


  # APPLICATION

  express = require 'express'
  less = require 'less'
  coffee = require 'coffee-script'

  app = express()

  localRootPath = process.cwd()
  localBowerPath = join localRootPath, 'bower_components'

  installationRootPath = resolve __dirname, '..'
  installationBowerPath = join installationRootPath, 'bower_components'

  # **/index.html
  app.use (req, res, next) ->
    path = resolvePath localRootPath, req.path.slice 1
    if path.endsWith '/'
      path = path.slice 0, -1
    indexFilePath = path + '/index.html'
    fs.exists indexFilePath, (doesExist) ->
      return next() unless doesExist
      fs.readFile indexFilePath, 'utf8', (err, content) ->
        return next err if err
        res.set 'Content-Type', 'text/html'
        res.end content

  # **/*.less
  app.use convertOnTheFly localRootPath, '.less', (req, res, content, next) ->
    less.render content, (err, css) ->
      return next err if err
      res.set 'Content-Type', 'text/css'
      res.end css

  # **/*.coffee
  app.use convertOnTheFly localRootPath, '.coffee', (req, res, content, next) ->
    try
      js = coffee.compile content, bare: true
    catch err
      return next err
    res.set 'Content-Type', 'application/javascript'
    res.end js

  app.use express.static localRootPath
  app.use express.static localBowerPath
  app.use express.static installationBowerPath

  server = app.listen config.port, ->
    console.log "Listening on port #{server.address().port}"

  process.on 'SIGINT', ->
    # This causes Ctrl-C to be followed by a handy newline:
    console.log ''
    process.exit()

# <path>/**/*.<ext>
convertOnTheFly = (basePath, ext, conv) ->
  (req, res, next) ->
    return next() unless req.method in ['GET', 'HEAD']
    filePath = resolvePath basePath, req.path.slice 1
    return next() unless filePath.endsWith(ext)
    fs.exists filePath, (doesExist) ->
      return next() unless doesExist
      fs.readFile filePath, 'utf8', (err, content) ->
        return next err if err
        conv req, res, content, next
