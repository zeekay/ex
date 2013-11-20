## Introduction
A razor-sharp DSL for [express][express] inspired by [Zappa][zappa].

### Install

```bash
npm install ex
```

### Usage
Ex binds `this` to useful things and provides a few utility methods which are
helpful. The simple ex app is probably:

```coffeescript
require('ex') ->
  @get '/', ->
    @send 'hello world'

  @run()
```

The default express app could be rewritten like so:

```coffeescript
ex = require 'ex'

ex ->
  # all environments
  @set 'port', process.env.PORT or 3000
  @set 'views', __dirname + '/views'
  @set 'view engine', 'jade'
  @use ex.favicon()
  @use ex.logger 'dev'
  @use ex.bodyParser()
  @use ex.methodOverride()
  @use @app.router
  @use ex.static __dirname + '/public'

  # development only
  @development ->
    @use ex.errorHandler()

  @get '/', ->
    @render 'index', title: 'Ex'

  @run =>
    console.log 'Ex listening on port ' + @get 'port'
```

[express]: http://expressjs.com
[zappa]: https://github.com/mauricemach/zappa
