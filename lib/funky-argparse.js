var F, exports, funkyjsArgparse, root;

F = require('funkyjs');

funkyjsArgparse = function(argv, cwd) {
  var getTrueValue;
  getTrueValue = function(val) {
    return F('if', F('isNumber', val), F('toNumber', val), F('if', F('compose', 'isBoolean', 'strToBool', val), F('strToBool', val), val));
  };
  return F('unpair', (function(out, args) {
    return F('while', F('size', args), F('if', /^--?/.test(args[0], F('if', /^--?[^=]+=(?:\s|.)*$/.test(args[0], (function() {
      return [(F('strRightBack', args[0], '=')).replace(/^--?/, ''), F('strRight', args[0], '=')];
    }), F('if', /^--?/.test(args[1], (function() {
      return [args.shift().replace(/^--?/, ''), true];
    }), (function() {
      return [args.shift().replace(/^--?/, ''), getTrueValue(args.shift())];
    }))))), (function() {
      return [' ', getTrueValue(args.shift())];
    }))));
  })([], F('map', F('if', argv, F(argv), F('rest', process.argv, 2)), function(el) {
    return F('if', /^\//.test(el, F('join', '', F('if', cwd, cwd, process.cwd()), el), el));
  })));
};

root = this;

if (typeof exports !== 'undefined') {
  if (typeof module !== 'undefined' && module.exports) {
    exports = module.exports = funkyjsArgparse;
  }
  exports.funkyjsArgparse = funkyjsArgparse;
} else {
  root.funkyjsArgparse = funkyjsArgparse;
}
