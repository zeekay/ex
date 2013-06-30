express = require 'express'
request = require 'request'

ex = require '../lib/ex'

describe 'ex', ->
  it 'should return wrapped express app', ->
    ex().app instanceof express().constructor

  it 'should properly wrap get', (done) ->
    app = ex()
    app ->
      @get '/1', ->
        @send '1'

    app.get '/2', ->
      @send '2'

    app.listen 3000, ->
      request 'http://localhost:3000/1', (err, res, body) ->
        throw err if err?

        body.should.eq '1'

        request 'http://localhost:3000/2', (err, res, body) ->
          throw err if err?

          body.should.eq '2'
          done()
