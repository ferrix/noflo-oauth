noflo = require "noflo"

class GetRequestToken extends noflo.Component =>

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
      @consumer.getOAuthRequestToken(@callback)

  callback: (error, oauth_token, oauth_token_secret, res) ->
    if error
      unless @outPorts.error.isAttached()
        throw error
      @outPorts.error.send error
      @outPorts.error.disconnect()
      return

    @outPorts.out.connect()
    return unless @outPorts.out.isAttached()
    @outPorts.out.send
      oauth_token: oauth_token
      oauth_token_secret: oauth_token_secret
      res: res

export.getComponent = -> new GetRequestToken

