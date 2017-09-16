# octave-taylor

This is an implementation of Taylor arithmetic in Octave. It started
as a proof of concept implementation but the current goal is to
develop a full package.

Much of the work have been done with spare time from the Google Summer
of Code project
[https://gsocinterval.blogspot.se/](https://gsocinterval.blogspot.se/)

The package is developed to work with the [interval
package](https://octave.sourceforge.io/interval/index.html) for Octave
but should in general also work with normal floating point numbers and
even complex numbers.

## Short about Taylor arithmetic

Taylor arithmetic is a method for automatically computing derivatives
for functions. It is suitable for computing high order
derivatives. For a short introduction to Taylor arithmetic and this
package see
[this](https://gsocinterval.blogspot.se/2017/07/a-package-for-taylor-arithmetic.html)
blogpost.

For another implementation of implementation of Taylor arithmetic see
for example [Real and Complex Taylor Arithmetic in
C-XSC](http://www2.math.uni-wuppertal.de/~xsc/preprints/prep_05_4.pdf).

## Implemented functions

### Taylor constructor

* @taylor/taylor

### Utility functions

* @taylor/cat
* @taylor/columns
* @taylor/ctranspose
* @taylor/diag
* @taylor/end
* @taylor/horzcat
* @taylor/iscolumn
* @taylor/ismatrix
* @taylor/isrow
* @taylor/isscalar
* @taylor/issquare
* @taylor/isvector
* @taylor/length
* @taylor/ndims
* @taylor/numel
* @taylor/order
* @taylor/postpad
* @taylor/prepad
* @taylor/reshape
* @taylor/resize
* @taylor/rows
* @taylor/size
* @taylor/subsasgn
* @taylor/subsref
* @taylor/transpose
* @taylor/tril
* @taylor/triu
* @taylor/vertcat

### Printing

* @taylor/taylortotext
* @taylor/disp
* @taylor/display

### Comparison

* @taylor/eq
* @taylor/ne

### Taylor functions

* @taylor/plus
* @taylor/minus
* @taylor/times
* @taylor/rdivide
* @taylor/ldivide
* @taylor/sqr
* @taylor/exp
* @taylor/ln
* @taylor/sin
* @taylor/cos

## Functions to be implemented

### Taylor functions

* @taylor/rsqrt
* @taylor/sqrt1px2
* @taylor/sqrtp1m1
* @taylor/sqrt1mx2
* @taylor/sqrtx2m1
* @taylor/pow
* @taylor/expm1
* @taylor/lnp1
* @taylor/tan
* @taylor/cot
* @taylor/sinh
* @taylor/cosh
* @taylor/tanh
* @taylor/coth
* @taylor/asin
* @taylor/acos
* @taylor/atan
* @taylor/acot
* @taylor/asinh
* @taylor/acosh
* @taylor/atanh
* @taylor/acoth
* @taylor/erf
* @taylor/erfc

### Taylor array functions

* @taylor/dot
* @taylor/prod
* @taylor/sum
* @taylor/sumabs
* @taylor/sumsq
* @taylor/jacobian
* @taylor/hessian

## Usage

### Creating a Taylor expansion

To create a Taylor expansion you use the class constructor `taylor
()`. The order of the Taylor expansion has to be decided upon
construction, for example if you only need the first derivative order
1 is sufficient. To create a variable with value `v` of order `n` you
use

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
f = taylor (infsupdec ([5, 3, 2]))
```

will create a function with `f(x0) = [5]_com`, `f'(x0) = [3]_com` and
`f''(x0) = [2]_com/2! = [1]_com`.

### Computing with Taylor expansions

The Taylor package overloads most numerical functions and Taylor
expansions can thus be used in computation much like ordinary
intervals or numbers.

The implementation of numerical functions is not yet completed.

## Authors, License, Credits

This package is the work of Joel Dahne. It takes much inspiration, and
depends on, the [interval
package](https://octave.sourceforge.io/interval/index.html) for
Octave. It is released under the terms of the GNU General Public
License, version 3.
