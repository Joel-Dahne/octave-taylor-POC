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
## @defop Method {@@taylor} rdivide (@var{X}, @var{Y})
## @defopx Operator {@@taylor} {@var{X} ./ @var{Y}}
##
## Divide the Taylor expansion @var{X} by @var{Y}.
##
## @example
## @group
##   x = taylor (infsupdec (6), 2);
##   y = taylor (infsupdec (2), 2);
##   x ./ y
##   @result{} ans = [3]_com + [-1]_com X + [0.5]_com X^2
## @end group
## @end example
## @seealso{@@taylor/ldivide, @@taylor/times}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-15

function result = rdivide (x, y)

  if (nargin != 2)
    print_usage();
    return
  endif

  if (not (isa (x, "taylor")) && not (isa (y, "taylor")))
    x = taylor (x, 1, "const");
    y = taylor (y, 1, "const");
  elseif (not (isa (x, "taylor")))
    x = taylor (x, order (y), "const");
  elseif (not (isa (y, "taylor")))
    y = taylor (y, order (x), "const");
  elseif (order (x) != order (y))
    error ("Taylor expansions of different orders");
  endif

  idx.type = "()";
  idx.subs(1:order (x) + 2) = {":"};
  idx.subs(1) = 1;

  result = taylor (postpad (subsref (x.coefs, idx)./subsref (y.coefs, idx), ...
                            order (x) + 1, 0, 1));

  idxx  = idx;
  idxy1 = idx;
  idxy2 = idx;
  for k = 1:order (x)
    idx.subs(1) = k + 1;
    idxx.subs(1) = 1:k;
    idxy1.subs(1) = k+1:-1:2;
    result.coefs = subsasgn (result.coefs, idx, ...
                             (subsref (x.coefs, idx) - ...
                              dot (subsref (result.coefs, idxx), subsref (y.coefs, idxy1), 1)) ...
                             ./subsref (y.coefs, idxy2));
  endfor

endfunction

%!test
%! x = taylor (infsupdec ([3; 2; 1]));
%! y = x;
%! z = taylor (infsupdec ([1; 0; 0]));
%! assert (isequal (x ./ y, z));
%!test
%! x = taylor (infsupdec ([2, 6; 6, 4; 10, 7]));
%! y = taylor (infsupdec ([2, 3; 4, 5; 6, 7]));
%! z = taylor (infsupdec ([1, 2; 1, -2; 0, 1]));
%! assert (isequal (x ./ y, z));
%!test
%! x = taylor (infsupdec (ones (3, 3, 3)), 2);
%! y = x;
%! m = infsupdec (ones (3, 3, 3));
%! z = taylor (m, 2, "const");
%! assert (isequal (x ./ y, z));
