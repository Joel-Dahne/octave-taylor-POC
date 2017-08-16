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
## @defmethod {@@taylor} exp (@var{X})
##
## Compute the exponential function.
##
## @example
## @group
## exp (taylor (infsupdec (0), 3))
##   @result{} ans = [1]_com + [1]_com X + [0.5]_com X^2 + [0.16666, 0.16667]_com X^3
## @end group
## @end example
## @seealso{@@taylor/log, @@taylor/pow}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-16

function result = exp (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = x;

  result.coefs(1, :) = exp (x.coefs (1, :));
  for k = 1:order (x)
    result.coefs(k+1, :) = dot ((1:k)'.*x.coefs(2:k+1, :), result.coefs(k:-1:1, :), 1)./k;
  endfor

endfunction

%!assert (isequal (exp (taylor (infsupdec (0), 2)), taylor (infsupdec ([1; 1; 0.5]))))
%!assert (isequal (exp (taylor (infsupdec ([0; 1; 1; 0]))), taylor (infsupdec ("1; 1; 3/2; 7/6"))))
%!assert (isequal (exp (taylor (infsupdec ([0; 0; 2; 0; 0]))), taylor (infsupdec ([1; 0; 2; 0; 2]))))
%!test
%! x = taylor (infsupdec (1), 3);
%! y = taylor (infsupdec ("e")./infsupdec ("1; 1; 2; 6"));
%! assert (isequal (exp (x), y));
