express = require 'express'

module.exports = (app) ->
  unless app?
    app = express()

  wrapper = (fn) ->
    fn.call wrapper

  wrapper.app = app
  wrapper.locals = app.locals
  wrapper.routes = app.routes
  wrapper.configure = -> app.configure.apply app, arguments

  for env in ['development', 'production', 'test']
    do (env) ->
      wrapper[env] = (fn) ->
        configure.call app, env, ->
          fn.call app

  # inject req/res properties into route handlers
  for verb in ['all', 'get', 'patch', 'post', 'put', 'del']
    do (verb) ->
      wrapper[verb] = (path, args...) ->
        if verb == 'get' and args.length == 0
          return app.get path

        handler = args.pop()
        middleware = []

        while mw = args.pop()
          if Array.isArray mw
            middleware = middleware.concat mw
          else
            middleware.push mw

        app[verb] path, middleware, (req, res, next) ->
          ctx =
            next: next
            req: req
            res: res

            # req properties
            accepted: req.accepted
            acceptedCharsets: req.acceptedCharsets
            acceptedLanguages: req.acceptedLanguages
            body: req.body
            cookies: req.cookies
            files: req.files
            fresh: req.fresh
            host: req.host
            ip: req.ip
            ips: req.ips
            originalUrl: req.originalUrl
            params: req.params
            path: req.path
            protocol: req.protocol
            query: req.query
            route: req.route
            secure: req.secure
            signedCookies: req.signedCookies
            stale: req.stale
            subdomains: req.subdomains
            xhr: req.xhr

            # req methods
            accepts: -> req.accepts.apply req, arguments
            acceptsCharset: -> req.acceptCharset.apply req, arguments
            acceptsLanguage: -> req.acceptsLanguage.apply req, arguments
            is: -> req.is.apply req, arguments
            param: -> req.param.apply req, arguments

            # res properties
            charset: res.charset
            locals: res.locals

            # res methods
            attachment: -> res.attachment.apply res, arguments
            clearCookie: -> res.clearCookie.apply res, arguments
            cookie: -> res.cookie.apply res, arguments
            download: -> res.download.apply res, arguments
            format: -> res.format.apply res, arguments
            json: -> res.json.apply res, arguments
            jsonp: -> res.jsonp.apply res, arguments
            links: -> res.links.apply res, arguments
            location: -> res.location.apply res, arguments
            redirect: -> res.redirect.apply res, arguments
            render: -> res.render.apply res, arguments
            send: -> res.send.apply res, arguments
            sendfile: -> res.sendfile.apply res, arguments
            status: -> res.status.apply res, arguments
            type: -> res.type.apply res, arguments

          handler.apply ctx, req.params

  # chain additional callbacks
  wrapper.extend = ->
    fns = [fns] unless Array.isArray fns

    fns.forEach (fn) ->
      fn.call wrapper

  wrapper.set = -> app.set.apply app, arguments
  wrapper.enable = -> app.enable.apply app, arguments
  wrapper.disable = -> app.disable.apply app, arguments
  wrapper.enabled = -> app.enabled.apply app, arguments
  wrapper.disabled = -> app.disabled.apply app, arguments
  wrapper.use = -> app.use.apply app, arguments
  wrapper.engine = -> app.engine.apply app, arguments
  wrapper.param = -> app.param.apply app, arguments
  wrapper.all = -> app.all.apply app, arguments
  wrapper.render = -> app.render.apply app, arguments
  wrapper.listen = -> app.listen.apply app, arguments

  wrapper
