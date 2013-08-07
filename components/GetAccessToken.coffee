noflo = require "noflo"

class GetAccessToken extends noflo.Component
  
  constructor: ->
    @consumer = null
    @inPorts =
      consumer = new noflo.Port()
      in: new noflo.Port()
    @outPorts =
      error: new noflo.Port()
      out: new noflo.Port()

    @inPorts.consumer.on "data", (data) =>
      @consumer = data

    @inPorts.in.on "data", (data) =>
      @consumer.getOAuthAccessToken(data.oauth_token,
                                     data.oauth_token_secret,
                                     data.oauth_verifier, @callback)

    callback: (error, oauth_access_token, oauth_access_token_secret, res) ->
      if error
        unless @outPorts.error.isAttached()
          throw error
        @outPorts.error.send error
        @outPorts.error.disconnect()
        return

      @outPorts.out.connect()
      return unless @outPorts.listening.isAttached()
      @outPorts.out.send
        oauth_access_token: oauth_access_token
        oauth_access_token_secret: oauth_access_token_secret
        res: res

exports.getComponent = -> new GetAccessToken
