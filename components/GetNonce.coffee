noflo = require 'noflo'

class GetNonce extends noflo.Component =>
  
  nonceChars = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n',
                'o','p','q','r','s','t','u','v','w','x','y','z','A','B',
                'C','D','E','F','G','H','I','J','K','L','M','N','O','P',
                'Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3',
                '4','5','6','7','8','9'];


  constructor: ->
    @inPorts =
      in: new noflo.Port 'int'
 
    @outPorts =
      out: new noflo.Port()

    @inPorts.in.on "data", (size) =>
      return unless @outPorts.out.isAttached()
      @outPorts.out.send @nonce size

  nonce: (size) ->
    res = []
    
    i = 0
    
    while i < size
      res[i] = @nonceChars Math.floor(Math.random() * @nonceChars.length)
      i++
    return res.join ''

exports.getComponent = -> new GetNonce
