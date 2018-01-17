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
## @defmethod {@@taylor} log (@var{X})
##
## Compute the natural logarithm.
##
## For intervals this function is only defined where @var{X} is positive.
## Otherwise it is defined for all non-zero numbers.
##
## @example
## @group
## log (taylor (infsupdec (1), 3))
##   @result{} ans = [0]_com + [1]_com X + [-0.5]_com X^2 + [0.33333, 0.33334]_com X^3
## @end group
## @end example
## @seealso{@@taylor/exp, @@taylor/pow}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-16

function result = log (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  if (not (isa (x.coefs, "infsup")) && any (x.coefs (1, :) == 0))
    error ("log only defined for non-zero values")
  endif

  result = recursionmethod (x, x, @(x) log(x));

endfunction

%!assert (isequal (log (taylor (infsupdec (1), 3)), taylor (infsupdec ("0; 1; -1/2; 1/3"))));
%!assert (isequal (log (taylor (infsupdec ([1; 1; 1; 0]))), taylor (infsupdec ("0; 1; 1/2; -2/3"))));
%!test
%! x = taylor (infsupdec (2), 3);
%! y = taylor ([log(infsupdec(2)); infsupdec("1/2; -1/8; 1/24")]);
%! assert (isequal (log (x), y));

%!test
%! x = taylor (infsupdec ([1, 1; 1, 1; 1, 0; 0, 0]));
%! y = taylor (infsupdec ("0, 0; 1, 1; 1/2, -1/2; -2/3, 1/3"));
%! assert (isequal (log (x), y));
