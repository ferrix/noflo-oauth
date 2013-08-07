noflo = require 'noflo'

class GetOAuthConsumer extends noflo.Component =>

  constructor: ->
    @version = "1.0"
    @signatureMethod = "HMAC-SHA1"
    @callbackUrl = null
    @nonceSize = 32

    @inPorts =
      requestUrl = noflo.Port 'string'
      accessUrl = noflo.Port 'string'
      consumerKey = noflo.Port 'string'
      consumerSecret = noflo.Port 'string'
      version = noflo.Port 'string'
      signatureMethod = noflo.Port 'string'
      callbackUrl = noflo.Port 'string'
      nonceSize = noflo.Port 'int'

    @outPorts =
      error = noflo.Port()
      
    @inPorts.signatureMethod.on "data", (method) ->
      if method isnt 'PLAINTEXT' or method isnt 'HMAC-SHA1':
        error = 'Unsupported signature method'
        unless outPorts.error.isAttached()
          throw error
        outPorts.error.send error
        return
      @signatureMethod = method

    @inPorts.nonceSize.on "data", (size) ->
      @nonceSize = size

    @inPorts.version.on "data", (version) ->
      @version = version

    @inPorts.requestUrl.on "data", (url) ->
      @requestUrl = url

    @inPorts.accessUrl.on "data", (url) ->
      @accessUrl = url

    @inPorts.callbackUrl on "data", (url) ->
      @callbackUrl = url

    @inPorts.consumerKey on "data", (key) ->
      @consumerKey = key

    @inPorts.consumerSecret on "data", (key) ->
      @consumerSecret = key
        
      
