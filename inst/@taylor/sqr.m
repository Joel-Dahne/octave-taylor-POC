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
## @defmethod {@@taylor} sqr (@var{X})
##
## Compute the square of @var{X}.
##
## @example
## @group
## sqr (taylor (infsupdec (2), 3))
##   @result{} ans = [4]_com + [4]_com X + [1]_com X^2 + [0]_com X^3
## @end group
## @end example
## @seealso{}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-09-16

function result = sqr (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = x;

  result.coefs(1, :) = x.coefs(1, :).^2;
  for k = 1:order (x)
    m = floor ((k+1)/2);
    result.coefs(k+1, :) = 2.*dot (x.coefs(1:m, :), x.coefs(k + 2 - (1:m)), 1);
    if (mod (k, 2) == 0)
      result.coefs(k+1, :) += x.coefs(m + 1, :).^2;
    endif
  endfor

endfunction

%!test
%! x = taylor (infsupdec (2), 2);
%! y = taylor (infsupdec ([4; 4; 1]));
%! assert (isequal (sqr (x), y))
%!test
%! x = taylor (infsupdec ([0; 1; 1; 0; 0; 0]));
%! y = taylor (infsupdec ("0; 0; 1; 2; 1; 0"));
%! assert (isequal (sqr (x), y))
%!test
%! x = taylor (infsupdec (-2, 2), 3);
%! y = taylor (infsupdec ([0; -4; 1; 0], [4; 4; 1; 0]));
%! assert (isequal (sqr (x), y))
%!test
%! x = taylor (infsupdec ([1;2]), 2);
%! y = taylor (infsupdec ([1, 4; 2, 4; 1, 1]));
%! assert (isequal (sqr (x), y))
%!test
%! x = taylor (infsupdec ([1; -1; -1; 1; 1]));
%! y = taylor (infsupdec ([1; -2; -1; 4; 1]));
%! assert (isequal (sqr (x), y))
