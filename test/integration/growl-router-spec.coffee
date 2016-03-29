http    = require 'http'
request = require 'request'
Server  = require '../../src/server'

describe 'growl-express', ->
  @timeout 30000

  beforeEach (done) ->
    serverOptions =
      port: undefined,
      disableLogging: true

    @server = new Server serverOptions

    @server.run =>
      @serverPort = @server.address().port
      done()

  afterEach (done) ->
    @server.stop done

  describe 'On POST /register', ->
    beforeEach (done) ->
      options =
        uri: '/register'
        baseUrl: "http://localhost:#{@serverPort}"
        json: true
        body:
          notifications:
            [{ "label": "test", "icon": "http://imgur.com/amjVCj6.jpg" }]

      request.post options, (error, @response, @body) =>
        done error

    it 'should return a 200', ->
      expect(@response.statusCode).to.equal 200

  describe 'On POST /notify', ->
    beforeEach (done) ->
      userAuth = new Buffer('some-uuid:some-token').toString 'base64'

      options =
        uri: '/notify'
        baseUrl: "http://localhost:#{@serverPort}"
        json: true
        body:
          text: "huzzah",
          options:
            title: "test passed!"
            label: "test"

      request.post options, (error, @response, @body) =>
        console.log "\tresponse-body: '#{@body}'"
        done error

    it 'should return a 200', ->
      expect(@response.statusCode).to.equal 200
