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
