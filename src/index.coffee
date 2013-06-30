ex = require './ex'

connectMiddleware = [
  'basicAuth'
  'bodyParser'
  'compress'
  'cookieParser'
  'cookieSession'
  'csrf'
  'directory'
  'errorHandler'
  'favicon'
  'json'
  'limit'
  'logger'
  'methodOverride'
  'multipart'
  'query'
  'responseTime'
  'session'
  'static'
  'staticCache'
  'timeout'
  'urlencoded'
  'vhost'
]

for middleware in connectMiddleware
  do (middleware) ->
    Object.defineProperty ex, middleware,
      enumerable: true
      get: ->
        require('express/node_modules/connect').middleware[middleware]

module.exports = ex
