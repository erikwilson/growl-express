growly = require 'growly'

class GrowlRouter

  route: (app) =>

    app.post '/register', (request, response) =>
      {appname, appicon, notifications} = request.body
      appname ?= 'growl-express-'+Date.now()
      growly.register appname, appicon, notifications, (error) =>
        return response.status(500).send(error.message) if error?
        response.sendStatus(200)

    app.post '/notify', (request, response) =>
      {text, options} = request.body
      growly.notify text, options, (error, action) =>
        return response.status(500).send(error.message) if error?
        response.status(200).send(action)

module.exports = GrowlRouter
