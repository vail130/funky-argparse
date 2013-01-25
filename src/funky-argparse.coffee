F = require 'funkyjs'

funkyjsArgparse = (argv, cwd) ->
  getTrueValue = (val) ->
    (F 'if',  (F 'isNumber', val), (F 'toNumber', val),
      (F 'if', (F 'compose', 'isBoolean', 'strToBool', val), (F 'strToBool', val), val))
  
  # Create object from array pairs in list
  (F 'unpair',
    # Create list of array pairs from argv
    ((out, args) ->
      # While args isn't empty
      (F 'while', (F 'size', args),
        # If arg is param
        (F 'if', /^--?/.test args[0],
          # If arg has value set
          (F 'if', /^--?[^=]+=(?:\s|.)*$/.test args[0],
            (-> [(F 'strRightBack', args[0], '=').replace(/^--?/, ''),
              (F 'strRight', args[0], '=')]),
            (F 'if', /^--?/.test args[1],
              (-> [args.shift().replace(/^--?/, ''), true]),
              (-> [args.shift().replace(/^--?/, ''), getTrueValue args.shift()]))),
          (-> [' ', getTrueValue args.shift()]))))(
            # Empty list to store results
            [],
            # List of argv using user-defined argv and cwd as defaults
            # with full paths for anything starting with a slash
            (F 'map', (F 'if', argv, (F argv), (F 'rest', process.argv, 2)),
              (el) ->
                (F 'if', /^\//.test el,
                  (F 'join', '', (F 'if', cwd, cwd, process.cwd()), el), el))))

# Modeled after Underscore.js export
root = @
if typeof exports isnt 'undefined'
  if typeof module isnt 'undefined' and module.exports
    exports = module.exports = funkyjsArgparse
  exports.funkyjsArgparse = funkyjsArgparse
else
  root.funkyjsArgparse = funkyjsArgparse