/*
 * The following method is derived in part from the article 'Top Down Operator Precedence' by
 * Douglas Crockford, available at http://javascript.crockford.com/tdop/tdop.html.
 * Also see:
 * https://eli.thegreenplace.net/2010/01/02/top-down-operator-precedence-parsing
 * http://effbot.org/zone/simple-top-down-parsing.htm
 *
 *
 * BigNumber.evaluate( [expression [, scope]] )
 *
 * Return a new BigNumber whose value is the result of evaluating a string expression in the context
 * of a scope object.
 *
 * [expression] {string} An arithmetic/boolean expression.
 * [scope] {object} An object defining variables and/or functions.
 *
 * Examples:
 * BigNumber.evaluate('0.1 + 0.2').toString();    // '0.3'
 * BigNumber.evaluate('3sin(e)', { e: '2.718281828459', sin: function (n) { return Math.sin(n) } }).toString();    // '1.23234387150885045'
 *
 *
 * Operator precedence:
 *    ( )
 *    ^ power √ (\u221A) square root   (right-associative)
 *    ! + -  (unary)
 *    * / %
 *    + -
 *    < > <= >=
 *    == !=
 *    &&
 *    ||
 *
 *
 * The comparison operators return `1` for `true` and `0` for `false`.
 *
 *     BigNumber.evaluate('2 > 3')                 // '0'
 *
 * As with JavaScript, the logical operators `&&` and `||` return one of their operands.
 *
 *     BigNumber.evaluate('2 && 3')                // '3'
 *
 * Numbers may be in exponential notation.
 *
 *     BigNumber.evaluate('1.234e+5 == 123400')    // '1'
 *
 * User-defined variables and functions are supported through a scope object passed as the second argument.
 *
 *     BigNumber.evaluate('sin(x)', { x: 3, sin: function (n) { return Math.sin(n) })    // '0.1411200080598672'
 *
 * Once a scope is defined, it exists until it is replaced by a new scope.
 *
 *     BigNumber.evaluate('x + y', { x: 0.1, y: 0.2 })    // '0.3'
 *     BigNumber.evaluate('2(x - 3y)')                    // '1'
 *     BigNumber.evaluate('2xy')                          // '0.04'
 *
 *     // Pass null or {} to clear the scope
 *     BigNumber.evaluate('xy', null)                     // 'BigNumber.evaluate error: unknown symbol: x'
 *
 * As shown above, multiplication is implicit for immediately adjacent values, but note that multiplication and division are left-associative:
 *
 *     BigNumber.evaluate('1/2x', { x: 4 })               // '2'         (1/2)*x
 *     BigNumber.evaluate('1/(2x)')                       // '0.125'     1/(2*x)
 *
 * The previously evaluated expression, with any added `*`, is available at `BigNumber.evaluate.expression`.
 *
 *     BigNumber.evaluate('2x(3x + 4y)')
 *     BigNumber.evaluate.expression                      // '2*x*(3*x + 4*y)'
 *
 * Each variable's value and each function's return value is passed to the `BigNumber` constructor,
 * so a *number*, *string* or *BigNumber* object can be used in the definition in the scope object.
 *
 *     BigNumber.evaluate('x % y + z', { x: 4, y: '3', z: new BigNumber('2') })    // '3'
 *
 * The values that are passed to functions are `BigNumber` number objects, so their prototype methods are available.
 *
 *     BigNumber.evaluate('add(0.1, 0.2)', { add: function(a, b) { return a.plus(b) })    // '0.3'
 *
 * The definition of a valid identifier for a variable or function is the same as for JavaScript except
 * that the only non-ASCII characters allowed are the letters of the Unicode Greek and Coptic range: `\u0370-\u03FF`.
 * I.e. an identifier must start with a letter, `_` or `$`, and any further characters must be letters, numbers, `_` or `$`.
 *
 *     BigNumber.evaluate('2πr', { π: Math.PI, r: 1 })          // '6.283185307179586'
 *
 * A variable or function's value can be changed without having to redefine the scope,
 * by passing an object containing the updated definitions as the first and only argument to `BigNumber.evaluate`.
 *
 * Below, the value of `π` is updated and the last expression `'2πr'` is re-evaluated each time.
 *
 *     BigNumber.evaluate({ π: '3.14159265358979323846' })      // '6.28318530717958647692'
 *     BigNumber.evaluate({ π: 3 })                             // '6'
 *
 * A new scope has not been created so `r` is still available.
 *
 *     BigNumber.evaluate('r')                        // 1
 *     BigNumber.evaluate('r', {})                    // 'BigNumber.evaluate error: unknown symbol: r'
 *
 * When a new expression is passed to `BigNumber.evaluate` it is tokenized and those tokens are re-evaluated
 * on each subsequent `evaluate` call until a new expression is passed and a new set of tokens is created.
 *
 *     BigNumber.evaluate('x^y', { x: 2, y: 3 })      // '8'           2^3
 *     BigNumber.evaluate({ y: -3 })                  // '0.125'       2^-3
 *     BigNumber.evaluate({ x: 4 })                   // '0.015625'    4^-3
 *     BigNumber.evaluate()                           // '0.015625'
 *
 *     BigNumber.evaluate('1')                        // '1'
 *     BigNumber.evaluate({ y: 4 })                   // '1'
 *     BigNumber.evaluate('x^y')                      // '256'         4^4
 *
 *     // Clear tokens by passing an empty string or null
 *     BigNumber.evaluate('')                         // null
 *
 * New variables or functions cannot be added via the updating object.
 *
 *     BigNumber.evaluate({ z: 5 })          // 'BigNumber.evaluate error: identifier not in scope: z'
 *
 * As with the BigNumber prototype methods, the results of operations involving division are calculated
 * to the number of decimal places specified by the value of `DECIMAL_PLACES` and rounded using the `ROUNDING_MODE`.
 *
 *     BigNumber.set({ DECIMAL_PLACES: 5 });
 *     BigNumber.evaluate('1/3')                      // '0.33333'
 *
 *
 * Summary:
 *
 *       expression  |  scope      |  action
 *     --------------|-------------|---------------------------------------------------------------
 *       string      |  object     |  Create and evaluate new tokens after creating new scope
 *       string      |  undefined  |  Create and evaluate new tokens using existing scope
 *       string      |  null       |  Create and evaluate new tokens after clearing existing scope
 *       undefined   |  object     |  Re-evaluate existing tokens after creating new scope
 *       undefined   |  undefined  |  Re-evaluate existing tokens using existing scope
 *       undefined   |  null       |  Re-evaluate existing tokens after clearing existing scope.
 *       null        |  object     |  Create new scope and clear existing tokens and return null
 *       null        |  undefined  |  Clear existing tokens and return null
 *       null        |  null       |  Clear existing scope and clear existing tokens and return null
 *       object      |  -          |  Re-evaluate existing tokens after updating existing scope
 *
 *
 * An example scope emulating the functionality of the JavaScript Math object:
 *
 *     scope = {
 *         // Constants (to 40 d.p.)
 *         E:       '2.7182818284590452353602874713526624977572',
 *         LN2:     '0.6931471805599453094172321214581765680755',
 *         LN10:    '2.3025850929940456840179914546843642076011',
 *         LOG2E:   '1.4426950408889634073599246810018921374266',
 *         LOG10E:  '0.4342944819032518276511289189166050822944',
 *         PI:      '3.1415926535897932384626433832795028841972',
 *         SQRT1_2: '0.7071067811865475244008443621048490392848',
 *         SQRT2:   '1.4142135623730950488016887242096980785697',
 *         PHI:     '1.6180339887498948482045868343656381177203',
 *         // Methods
 *         abs: function (n) { return n.abs() },
 *         acos: function (n) { return Math.acos(n) },
 *         asin: function (n) { return Math.asin(n) },
 *         atan: function (n) { return Math.atan(n) },
 *         atan2: function (y,x) { return Math.atan2(y,x) },
 *         ceil: function (n) {
 *           n.isNegative() ? n.round(0,0) : n.round(0,0).plus(1);
 *         },
 *         cos: function (n) { return Math.cos(n) },
 *         exp: function (n) { return Math.exp(n) },
 *         floor: function (n) {
 *           return n.isPositive() ? n.round(0,0) : n.round(0,0).minus(1);
 *         },
 *         log: function (n) { return Math.log(n) },
 *         max: function () {
 *           for ( var n, i = 1, max = arguments[0]; i < arguments.length; i++ )
 *             if ( max.lt( n = arguments[i] ) ) max = n;
 *           return max;
 *         },
 *         min: function () {
 *           for ( var n, i = 1, min = arguments[0]; i < arguments.length; i++ )
 *             if ( min.gt( n = arguments[i] ) ) min = n;
 *           return min;
 *         },
 *         pow: function (x,y) { return Math.pow(x,y) },
 *         random: function (dp) {    // [decimal places]
 *           var r = Math.random().toString();
 *           if ( dp > 0 ) {
 *             dp += 2;
 *             while ( r.length < dp ) r += Math.random().toString().slice(2);
 *             r = r.slice(0, dp);
 *           }
 *           return r;
 *         },
 *         round: function (n) {
 *           return n.isPositive() ? n.round(0,1) : n.round(0,1).plus(1);
 *         },
 *         sin: function (n) { return Math.sin(n) },
 *         sqrt: function (n) { return n.sqrt() },
 *         tan: function (n) { return Math.tan(n) }
 *     };
 *
 *     BigNumber.evaluate('max(sin(E),cos(PI)', scope)    // '0.41078129050290885'
 *
 * TODO: Add support for NaN and Infinity.
 */
BigNumber.evaluate = (function () {
  var index,
    token,
    TOKENIZER,
    TOKENS,
    SCOPE,
    err = 'BigNumber.evaluate error: ',
    DEFAULT_TOKENIZER = TOKENIZER = /(?:(\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)|(0)|(\)))(?=([\w($\u221A\u0370-\u03FF]|!(?!=))?)|([!<>=]=|[-+*\/(^%><!\u221A,]|&&|\|\|)|\S/g,
    VALID_IDENTIFIER = /^[a-zA-Z_$\u0370-\u03FF][\w\u0370-\u03FF$]*$/,

    OPERATORS = (function () {
      var ops = {},

        // lbp: left binding power.
        add = function (op, lbp, fn, prefix) {
          var obj = {};

          if ((obj.lbp = lbp)) {
            obj.infix =
              typeof fn == 'string'
                ? lbp < 50 // I.e. comparison methods returning true/false
                  ? function (left) { return new BigNumber(+left[fn](evaluate(lbp))); }
                  : function (left) { return left[fn](evaluate(lbp)); }
                : fn;

            if (prefix) obj.prefix = prefix;
          } else {
            obj.prefix = fn;
          }

          ops[(obj.val = op)] = obj;
        };

      add('^', 80, function (left) { return left.pow(evaluate(79)); });
      add('*', 60, 'times');
      add('/', 60, 'div');
      add('%', 60, 'mod');
      add('+', 50, 'plus', function () { return evaluate(70); });
      add('-', 50, 'minus', function () {
        var r = new BigNumber(evaluate(70));
        r.s = -r.s;
        return r;
      });
      add('>', 40, 'gt');
      add('>=', 40, 'gte');
      add('<', 40, 'lt');
      add('<=', 40, 'lte');
      add('==', 30, 'eq');
      add('!=', 30, function (left) { return new BigNumber(+!left.eq(evaluate(30))); });
      add('&&', 20, function (left) {
        var r = evaluate(20);
        return left.isZero() ? left : r;
      });
      add('||', 10, function (left) {
        var r = evaluate(10);
        return left.isZero() ? r : left;
      });
      add('\u221A', 0, function () { return evaluate(79).sqrt(); });

      // If 'left' is 0 return 1 else return 0.
      add('!', 0, function () { return new BigNumber(+(evaluate(70).isZero())); });
      add('(', 0, function () {
        var r = evaluate(0);
        if (token.val != ')') throw err + 'expected )';
        token = TOKENS[++index];
        return r;
      });
      add(')', 0);
      add(',', 0);

      return ops;
    })(),

    func_prefix = function () {
      var args = [];

      if (token.val != '(') throw err + 'expected (';
      token = TOKENS[++index];

      if (token.val != ')') {
        while (true) {
          args.push(evaluate(0));

          if (token.val != ',') {
            if (token.val != ')') throw err + 'expected )';
            break;
          }
          token = TOKENS[++index];
        }
      }
      token = TOKENS[++index];

      return new BigNumber(SCOPE[this.val].apply(null, args));
    },

    var_prefix = function () { return SCOPE[this.val]; },

    num_prefix = function () { return this.val; },

    evaluate = function (rbp) {
      var left,
        t = token;

      if (!t.prefix) throw err + 'unexpected ' + (t.val == 'end' ? 'end' : 'symbol: ' + t.val);

      token = TOKENS[++index];
      left = t.prefix();

      while (rbp < token.lbp) {
        t = token;
        token = TOKENS[++index];
        left = t.infix(left);
      }

      // 'left' is returned to 'infix' or 'prefix', or it may be the final result.
      return left;
    };

  return function (expression, scope) {
    var arr,
      id,
      parsed,
      val,
      has = Object.prototype.hasOwnProperty;

    // Update SCOPE and reuse existing TOKENS.
    if (expression && typeof expression == 'object') {
      scope = expression;

      for (id in scope) {
        if (has.call(SCOPE, id)) {
          val = scope[id];

          if (typeof SCOPE[id] == 'function') {
            if (typeof val == 'function') {
              SCOPE[id] = val;
            } else {
              throw err + 'not a function: ' + id + ': ' + val;
            }
          } else {
            SCOPE[id] = new BigNumber(val);
          }
        } else {
          throw err + 'identifier not in scope: ' + id;
        }
      }

      if (!TOKENS) return null;
    } else {

      // Create new SCOPE.
      if (scope && typeof scope == 'object') {
        SCOPE = {};
        arr = [];

        for (id in scope) {
          if (has.call(scope, id)) {

            // Allow characters in Unicode 'Greek and Coptic' range: \u0370-\u03FF
            // VALID_IDENTIFIER: /^[a-zA-Z\u0370-\u03FF_$][\w\u0370-\u03FF$]*$/
            if (!VALID_IDENTIFIER.test(id)) throw err + 'invalid identifier: ' + id;
            val = scope[id];
            SCOPE[id] = typeof val == 'function' ? val : new BigNumber(val);
            arr.push(id);
          }
        }

        if (arr[0]) {
          arr.sort(function (a, b) { return b.length - a.length; });
          TOKENIZER = new RegExp(
            '(?:(\\d+(?:\\.\\d+)?(?:[eE][+-]?\\d+)?)|(' + arr.join('|').replace(/\$/g, '\\$') +
              ')|(\\)))(?=([\\w($\\u221A\\u0370-\\u03FF]|!(?!=))?)|([!<>=]=|[-+*\\/(^%><!\\u221A,]|&&|\\|\\|)|\\S', 'g'
          );
        } else {
          TOKENIZER = DEFAULT_TOKENIZER;
        }

        // Clear SCOPE.
      } else if (scope === null) {
        SCOPE = null;
        TOKENIZER = DEFAULT_TOKENIZER;
      }

      // Tokenize.
      if (expression != null && /\S/.test((expression += ''))) {
        parsed = '';
        TOKENS = [];
        TOKENIZER.lastIndex = 0;

        // × multiplication \xd7  (215)
        // ÷ division       \xf7  (247)
        // Uncomment the line below to support the use of the above multiplication and division symbols.
        // expression = expression.replace(/\xd7/g, '*').replace(/\xf7/g, '/');

        // Uncomment the line below to support the use of '**' for the power operation, as well as '^'.
        expression = expression.replace(/\*\*/g, '^');

        // Example TOKENIZER with capture groups numbered (and a scope with a variable 'x' and a function 'y'):
        //    1                                2     3       4                                    5
        // (?:(\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)|(x|y)|(\)))(?=([\w($\u221A\u0370-\u03FF]|!(?!=))?)|([!<>=]=|[-+*\/(^%><!\u221A,]|&&|\|\|)|\S
        while ((arr = TOKENIZER.exec(expression))) {
          // BigNumber.
          if ((val = arr[1])) {
            token = { val: new BigNumber(val), prefix: num_prefix };

            // Operator.
          } else if ((val = arr[5] || arr[3])) {
            token = OPERATORS[val];

            // Function/variable.
          } else if ((val = arr[2])) {
            token =
              typeof SCOPE[val] == 'function'
                ? ((arr[4] = null), { val: val, prefix: func_prefix })
                : { val: val, prefix: var_prefix };
          } else {
            TOKENS = null;
            throw err + 'unknown symbol: ' + arr[0].charAt(0);
          }

          TOKENS.push(token);
          parsed += val;

          // Add '*' if a number is followed by a variable, square root, '(' or '!', OR a variable
          // or ')' is followed by a number, variable, square root, '(' or '!'.
          if (arr[4]) {
            TOKENS.push(OPERATORS['*']);
            parsed += '*';
          }
        }

        BigNumber.evaluate.expression = parsed;
        TOKENS.push({ val: 'end' });
      } else if (expression !== void 0 || !TOKENS) {

        // 'expression' is null, undefined, '' or white-space.
        return (BigNumber.evaluate.expression = TOKENS = null);
      }
      // else re-evaluate existing TOKENS if 'expression' is undefined.
    }

    // Evaluate tokens.
    token = TOKENS[(index = 0)];
    val = new BigNumber(evaluate(0));

    if (token.val != 'end') throw err + 'unexpected symbol: ' + token.val;

    return val;
  };
})();
