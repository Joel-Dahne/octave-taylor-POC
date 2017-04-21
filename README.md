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
* get_order (x)
* get_coef (x, n)
  Get the n-th coefficient of the Taylor expansion
* get_derivative (x, n)
  Get the n-th derivative, the n-the coefficient times factorial of n

### Functions using Taylor expansions

* TODO newtons interval method
* TODO integrate

## Usage

### Creating a Taylor expansion

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

### Computing with Taylor expansions

Taylor expansions can be used for computations much like ordinary
numbers. For example with `x = taylor (0, 5, "var")` we get

```
x + x = [0; 2; 0; 0; 0; 0]
x.*x = [0; 0; 1; 0; 0; 0]
exp (x) = [1.0000000; 1.0000000; 0.5000000; 0.1666667; 0.0416667; 0.0083333]
sin (x) =[0.00000; 1.00000; 0.00000; -0.16667; 0.00000; 0.008332]
```

all of which we recognize as the coefficients for the functions fifth
order Taylor expansion at `x=0`. If we instead want the derivatives we
can use `get_derivative` and get

```
get_derivative (x + x) = [0; 2; 0; 0; 0; 0]
get_derivative (x.*x) = [0; 0; 2; 0; 0; 0]
get_derivative (exp (x)) = [1; 1; 1; 1; 1; 1]
get_derivative (exp (x)) = [0; 1; 0; -1; 0; 1]
```

again we recognize all of these. We can also compute more complicated
functions, with `x = taylor (-2, 40, "var")` we for example get

```
get_derivative (exp (sin (exp ( cos (x) + 2.*x.^5))), 40) = 1.4961e+53
```

#### Using intervals

So how accurate is this result? One way to check that is to use
intervals arithmetics instead of floating points. Using
the
[interval package](https://octave.sourceforge.io/interval/index.html)
we can calculate with Taylor expansions and get guaranteed
results. Continuing on the above example using intervals we get, with
`x = taylor (infsup (-2), 40, "var")`,

```
get_derivative (exp (sin (exp ( cos (x) + 2.*x.^5))), 40) \subset [1.4957e+53, 1.4965e+53]
```

So the approximation we got is valid to at least 3 decimals. As a
final example we have with `x = taylor (infsup (1), 4, "var")` and
using `format long`

```
get_derivative ((5 + (cos (3.*x).^2).^(exp (x) + sin (7.*x))), 4) \subset [-671.122145754611, -671.122145754446]
```

were we see that the enclosure is very tight.

### Integration
Taylor expansions can be used to calculate integrals. This is done by
approximating the function with the polynomial given by the Taylor
expansion. The error of this approximation can then be calculated
using the remainder term in the expansion. An implementation of this
is found in `integrate_taylor`.

We can use `integrate_taylor` to calculate the integral of `f(x) =
sin(x)x` on the interval 0 to 1

```
integrate_taylor (@(x) sin (x) .* x, infsup(0, 1)) \subset [0.30116, 0.30117]
```

If no other arguments are given it defaults to using a 6th order
Taylor expansion and tolerance `sqrt(eps)`. To use another order or
tolerance we add those arguments as

```
integrate_taylor (@(x) sin (x) .* x, infsup(0, 1), 20, 1e-12) \subset [0.30116, 0.30117]
```

Next, consider the function `f(x) = sin(x + exp(x))`. Calculating this
with the built-in function `quad` gives

```
quad (@(x) sin (x + exp (x)), 0, 8)
ABNORMAL RETURN FROM DQAGP
ans =  0.36205
```

so `quad` has some problems calculating the integral. Doing the same
calculations using `integrate_taylor` with order 40 we get

```
integrate_taylor(f, infsup(0, 8), 40) \subset [0.3474, 0.34741]
```

We see that `quad` did not get quite the right result, even if it was
not to far off. This computation does however take quite some time,
about 5 minutes. This comes both from interval calculations being
slower than ordinary floating points and the Taylor expansions not
handling vectorization effectively at the moment.
