cors         = require 'cors'
morgan       = require 'morgan'
express      = require 'express'
bodyParser   = require 'body-parser'
errorHandler = require 'errorhandler'
GrowlRouter  = require './growl-router'

class Server
  constructor: ({@disableLogging, @port})->

  address: =>
    @server.address()

  run: (callback) =>
    app = express()
    app.use morgan 'dev', immediate: false unless @disableLogging
    app.use cors()
    app.use errorHandler()
    app.use bodyParser.urlencoded limit: '1mb', extended : true
    app.use bodyParser.json limit : '1mb'
    app.options '*', cors()

    router = new GrowlRouter
    router.route app

    @server = app.listen @port, callback

  stop: (callback) =>
    @server.close callback

module.exports = Server
