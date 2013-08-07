noflo = require 'noflo'
crypto = require 'crypto'
sha1 = require 'sha1'

class SignHMACSHA1 extends noflo.Component =>

  constructor: ->
    @key = ''
    @inPorts =
      cleartext: new noflo.Port()
      key: new noflo.Port()
    @outPorts =
      hash: new noflo.Port()

    @inPorts.key.on "data", (data) ->
      @key = key

    @inPorts.in.on "data", (cleartext) ->
      if crypto.Hmac
        hash = crypto.createHmac("sha1", @key).update(cleartext).digest("base64")
      else
        hash = sha1.HMACSHA1(key, cleartext)
      return unless @outPorts.hash.isAttached()
      @outPorts.hash.send hash

exports.getComponent = -> new SignHMACSHA1
