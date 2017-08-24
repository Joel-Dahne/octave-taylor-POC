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
## @defmethod {@@taylor} sin (@var{X})
##
## Compute the sine function in radians
##
## @example
## @group
## sin (taylor (infsupdec (0), 3))
##   @result{} ans = [0]_com + [1]_com X + [0]_com X^2 + [-0.16667, -0.16666]_com X^3
## @end group
## @end example
## @seealso{@@taylor/cos}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-24

function result_sin = sin (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result_sin = x;
  result_cos = x;

  result_sin.coefs(1, :) = sin (x.coefs(1, :));
  result_cos.coefs(1, :) = cos (x.coefs(1, :));
  for k = 1:order (x)
    result_sin.coefs(k+1, :) = dot ((1:k)'.*x.coefs(2:k+1, :),
                                    result_cos.coefs(k:-1:1, :), 1)./k;
    result_cos.coefs(k+1, :) = -dot ((1:k)'.*x.coefs(2:k+1, :),
                                     result_sin.coefs(k:-1:1, :), 1)./k;
  endfor

endfunction

%!assert (isequal (sin (taylor (infsupdec (0), 4)), taylor (infsupdec ("0; 1; 0; -1/6; 0"))));
%!assert (isequal (sin (taylor (infsupdec ([0; 1; 1; 0]))), taylor (infsupdec ("0; 1; 1; -1/6"))));

%!test
%! x = taylor (infsupdec ([0, 0; 1, 1; 0, 1; 0, 0; 0, 0]));
%! y = taylor (infsupdec ("0, 0; 1, 1; 0, 1; -1/6, -1/6; 0, -1/2"));
%! assert (isequal (sin (x), y));
