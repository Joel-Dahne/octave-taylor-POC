## Copyright 2017 Joel Dahne
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @documentencoding UTF-8
## @deftypeop Constructor {@@taylor} @var{X} = taylor ()
## @deftypeopx Constructor {@@taylor} @var{X} = taylor (@var{V})
## @deftypeopx Constructor {@@taylor} @var{X} = taylor (@var{V}, @var{order})
## @deftypeopx Constructor {@@taylor} @var{X} = taylor (@var{V}, @var{order}, @var{type})
##
## Create a Taylor expansion.
##
## The syntax withour parameters creates a Taylor expansion of order 1
## with a value of 0 and derivative of 1.  The syntax with a single
## parameter @code{taylor (@var{V})} creates a Taylor expansion with
## the coefficients taken from the column vector @var{V}.  With two
## parameters it creates a Taylor expansions with the order
## @var{order}, value @var{V} and derivative @code{1}.  Alternatively
## if @var{V} already is a Taylor expansion it adjust the order to
## @var{order}. The third parameter can be either @code{"const"} or
## @code{"var"}, in the first case it creates a constant, that is the
## derivative is @code{0}, and in the second case a variable,
## derivative is @code{1}.
##
## The type of @var{V} can in principle be any type that supports
## arrays and standard numerical functions.  It is primary intended to
## be used with decorated intervals (@code{infsupdec}), most tests and
## examples are done with decorated intervals.  It should also work
## well with bare intervals (@code(infsup)) and doubles.  In most
## cases complex values should also work, the algoritms are the same,
## but there might be some problems.
##
## For the creation of Taylor arrays @var{V} can be given as an array.
##
## @example
## @group
## taylor ()
##   @result{} ans = [0]_com + [1]_com X
## taylor (infsupdec ([1; 2; 3], [4; 5; 6]))
##   @result{} ans = [1, 4]_com + [2, 5]_com X + [3, 6]_com X^2
## taylor (infsupdec (5), 4)
##   @result{} ans = [5]_com + [1]_com X + [0]_com X^2 + [0]_com X^3 + [0]_com X^4
## x = taylor (); taylor (x, 3)
##   @result{} ans = [0]_com + [1]_com X + [0]_com X^2 + [0]_com X^3
## taylor (infsupdec (5), 4, "const")
##   @result{} ans = [5]_com + [0]_com X + [0]_com X^2 + [0]_com X^3 + [0]_com X^4
## taylor (infsupdec (5), 4, "var")
##   @result{} ans = [5]_com + [1]_com X + [0]_com X^2 + [0]_com X^3 + [0]_com X^4
## taylor (1 + i, 2)
##   @result{} ans = 1+1i + 1X + 0X^2
## taylor (infsupdec (magic (3)))
##   @result{} ans = 3×1 Taylor vector of order 2
##      [8]_com + [3]_com X + [4]_com X^2
##      [1]_com + [5]_com X + [9]_com X^2
##      [6]_com + [7]_com X + [2]_com X^2
## taylor (infsupdec ([1, 2, 3]), 2)
##   @result{} ans = 1×3 Taylor matrix of order 2
##
##      ans(:,1) = [1]_com + [1]_com X + [0]_com X^2
##      ans(:,2) = [2]_com + [1]_com X + [0]_com X^2
##      ans(:,3) = [3]_com + [1]_com X + [0]_com X^2
##
## @end group
## @end example
## @seealso{@@infsupdec/infsupdec}
## @end deftypeop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-03-05

function x = taylor (value, order, type)


  switch nargin
    case 0
      ## order 1 variable
      x = class (struct ("coefs", infsupdec ([0; 1])), "taylor");
      return
    case 1
      if (isa (value, "taylor"))
        ## Already a Taylor expansion
        x = value;
        return
      elseif (isa (value, "infsup") || isnumeric (value))
        ## Create the Taylor expansion with coefficients from input
        x = class (struct ("coefs", value), "taylor");
        return
      endif
    case 2
      if (isa (value, "taylor") && isindex (order + 1))
        ## Change the order of the expansion
        s = size (value.coefs);
        s(1) = order + 1;
        value.coefs = resize (value.coefs, s);
        x = value;
        return
      elseif (isa (value, "infsup") || isnumeric (value))
        ## Create a Taylor variable with the given order
        s = size (value);
        coefs = postpad (reshape (value, [1 s]), order + 1, 0, 1);
        coefs(2, :) = 1;
        x = class (struct ("coefs", coefs), "taylor");
        return
      endif
    case 3
      if (isa (value, "infsup") || isnumeric (value))
        s = size (value);
        coefs = postpad (reshape (value, [1 s]), order + 1, 0, 1);
        if (!(strcmp (type, "const") || strcmp (type, "c")))
          coefs(2, :) = 1;
        endif
        x = class (struct ("coefs", coefs), "taylor");
        return
      endif
  endswitch

  print_usage ();
endfunction

%!# Empty constructor
%!test
%! x = taylor ();
%! assert (isequal (coefs (x), infsupdec ([0; 1])));

%!# Vector
%!test
%! x = taylor (infsupdec (magic (3)));
%! assert (isequal (coefs (x), infsupdec (magic (3))));

%!# Taylor
%!test
%! x = taylor (infsupdec (magic (3)));
%! y = taylor (x);
%! assert (isequal (coefs (y), infsupdec (magic (3))));

%!# Taylor + dim
%!test
%! x = taylor (infsupdec (magic (3)));
%! y = taylor (x, 5);
%! assert (isequal (coefs (y), postpad (infsupdec (magic (3)), 6, 0, 1)));

%!# Vector + dim
%!test
%! x = taylor (infsupdec ([1; 2]), 3);
%! assert (isequal (coefs (x), infsupdec ([1, 2; 1, 1; 0, 0; 0, 0])));

%!# Create variable
%!test
%! x = taylor (infsupdec ([1; 2]), 3, "var");
%! assert (isequal (coefs (x), infsupdec ([1, 2; 1, 1; 0, 0; 0, 0])));

%!# Create constant
%!test
%! x = taylor (infsupdec ([1; 2]), 3, "const");
%! assert (isequal (coefs (x), infsupdec ([1, 2; 0, 0; 0, 0; 0, 0])));
