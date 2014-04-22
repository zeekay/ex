express = require 'express'
request = require 'request'
should  = (require 'chai').should()

ex = require '../lib'

describe 'ex', ->
  it 'should wrap express app when callback is express app', ->
    app = express()
    ex(app).app.should.eq app

  it 'should return new wrapped express app when called without callback', ->
    ex().app instanceof express().constructor

  it 'should return new wrapped express app and immediately apply callback when callback is not an express app', (done) ->
    app = ex ->
      @get '/1', ->
        @send '1'

      @run =>
        request 'http://localhost:3000/1', (err, res, body) =>
          throw err if err?

          body.should.eq '1'
          app.stop ->
            done()

  it 'should properly wrap get', (done) ->
    app = ex()
    app ->
      @get '/1', ->
        @send '1'

    app.get '/2', ->
      @send '2'

    app.run ->
      request 'http://localhost:3000/1', (err, res, body) ->
        throw err if err?

        body.should.eq '1'

        request 'http://localhost:3000/2', (err, res, body) ->
          throw err if err?

          body.should.eq '2'
          app.stop ->
            done()
