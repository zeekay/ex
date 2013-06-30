## Introduction
Ex is a razor-sharp DSL for [Express][express] inspired by [Zappa][zappa].

### Install

```bash
npm install ex
```

### Usage
Ex usage mostly matches express usage binding `this` in useful ways. A simple
server example:

```coffeescript
ex = require 'ex'

app = ex()

app ->
  @get '/', ->
    @send 'hello world'

  @run()
```

You can also pass a callback to ex and it'll create an express app for you, and
call your callback with the express app as `this'.

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
