{spawn} = require 'child_process'

# Monkey-patch, unpatch existing object.
exports.patcher = (obj) ->
  patched = []
  patcher =
    patch: (name, func) ->
      original = obj[name]
      if typeof original is 'function'
        wrapper = ->
          original.apply obj, arguments
        replacement = func wrapper
      else
        replacement = func original
      obj[name] = replacement
      patched.push [name, original]
      return

    unpatch: ->
      while patched.length
        [name, original] = patched.pop()
        if original
          obj[name] = original
        else
          delete obj[name]
      return

exports.exec = (args, callback) ->
  # Simple serial execution of commands, no error handling
  serial = (arr) ->
    complete = 0
    iterate = ->
      exports.exec arr[complete], ->
        complete += 1
        if complete == arr.length
          return
        else
          iterate()
    iterate()
    # passed callback as second argument
    if typeof opts is 'function'
      callback = opts

  if Array.isArray args
    return serial args

  args = args.split(/\s+/g)
  cmd = args.shift()
  proc = spawn cmd, args

  # echo stdout/stderr
  proc.stdout.on 'data', (data) ->
    process.stdout.write data

  proc.stderr.on 'data', (data) ->
    process.stderr.write data

  # callback on completion
  proc.on 'exit', (code) ->
    if typeof callback is 'function'
      callback null, code
