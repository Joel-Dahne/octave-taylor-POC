# octave-taylor

This is a proof-of-concept implementation of Taylor arithmetic in
Octave. It is not meant to be complete or bug free.

It is intended to work together with the interval package, but again
this is not perfect.

## Short about Taylor arithmetic

Taylor arithmetic is a method for automatically computing derivatives
for functions. It is suitable for computing high order derivatives and
can be generalized to n-dimensional functions. For another
implementation of Taylor arithmetic see for
example
[Real and Complex Taylor Arithmetic in C-XSC](http://www2.math.uni-wuppertal.de/~xsc/preprints/prep_05_4.pdf).

The mathematical foundation for Taylor arithmetic is computations with
Taylor series. For a (real analytic) function `f` we can expand it
into its Taylor series around a points `x0`.

```
f(x) = f(x0) + f'(x0)(x-x0) + f''(x0)/2!(x-x0)^2 + f'''(x0)/3!(x-x0)^3 + ...
```

The idea is that if we know the coefficients for the series we can
from that get the derivatives. This package provides methods for
creating and calculating with Taylor series. There is also some
functions for using the results.

## Implemented functions

### Functions on Taylor expansions

* taylor (value, order, type)
  Class contructor for the taylor-class
* plus (x, y)
  Compute the sum of two taylor-classes
* minus (x, y)
  Compute the difference of two taylor-classes
* times (x, y)
  Compute the product of two taylor-classes
* rdivide (x, y)
  Compute the quotient of two taylor-classes
* exp (x)
* log (x)
* power (x, y)
* sin (x)
* cos (x)

### Functions using Taylor expansions

* TODO newtons interval method
* TODO integrate

## Examples

To create a Taylor expansion you use the class constructor `taylor
()`. The order of the Taylor expansion has to be decided upon
construction, for example if you only need the derivative order 1 is
sufficient. To create a variable with value `v` of order `n` you use

```
x = taylor (v, n, 'var')
```

To create a constant with the same value and order

```
c = taylor (v, n, 'const')
```

It is also possible to directly specify the coefficients for the
expansion, for example

```
f = taylor ([5, 3, 2])
```

will create a function with `f(x0) = 5`, `f'(x0) = 3` and `f''(x0) =
2/2! = 1`.
