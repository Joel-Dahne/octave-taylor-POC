# octave-taylor

This is a proof-of-concept implementation of Taylor arithmetic in
Octave. It is not meant to be complete or bug free.

It is intended to work together with the interval package, but again
this is not perfect.

## Short about Taylor arithmetic

Taylor arithmetic is a method for automatically computing high-order
derivatives of functions.

## Implemented functions

### Functions on Taylor expansions

* taylor (ceofs, order)
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

To create a Taylor expansion you use the class constructor `taylor ()`
which allows for several different kind of input. To create a variable
with value `v` of order `n` you can use

```
x = taylor (v, n, 'var')
```

or to create a constant with the same value

```
c = taylor (v, n, 'const')
```
