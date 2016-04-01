growly = require 'growly'

class GrowlRouter

  route: (app) =>

    app.post '/register', (request, response) =>
      {appname, appicon, notifications} = request.body
      appname ?= 'growl-express'
      growly.register appname, appicon, notifications, (error) =>
        return response.status(500).send(error.message) if error?
        response.sendStatus(200)

    app.post '/notify', (request, response) =>
      {text, options} = request.body
      text ?= 'Hello World ' + new Date
      growly.notify text, options, (error, action) =>
        return response.status(500).send(error.message) if error?
        response.status(200).send(action)

    app.post '/setHost', (request, response) =>
      {host, port} = request.body
      growly.setHost host, port
      response.sendStatus(200)

module.exports = GrowlRouter
