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

[express]: http://expressjs.com
[zappa]: https://github.com/mauricemach/zappa
