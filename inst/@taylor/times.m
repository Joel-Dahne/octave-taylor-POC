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
## @defop Method {@@taylor} times (@var{X}, @var{Y})
## @defopx Operator {@@taylor} {@var{X} .* @var{Y}}
##
## Multiply the taylor expansion @var{X} with @var{Y}.
##
## @example
## @group
##   x = taylor (infsupdec (2), 2);
##   y = taylor (infsupdec (3), 2);
##   x .* y
##   @result{} ans = [6]_com + [5]_com X + [1]_com X^2
## @end group
## @end example
## @seealso{@@times/rdivide}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-14

function result = times (x, y)

  if (nargin != 2)
    print_usage ();
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

  result = taylor (postpad (subsref (x.coefs, idx).*subsref (y.coefs, idx), ...
                            order (x) + 1, 0, 1));


  ## FIXME: This could be improved if there were a function for
  ## calculating the lower part of a convolution between x and y.
  idxx  = idx;
  idxy = idx;

  for k = 1:order (x)
    idx.subs(1) = k + 1;
    idxx.subs(1) = 1:k+1;
    idxy.subs(1) = k+1:-1:1;
    result.coefs = subsasgn (result.coefs, idx, ...
                             dot (subsref (x.coefs, idxx), ...
                                  subsref (y.coefs, idxy), 1));
  endfor

endfunction

%!test
%! x = taylor (infsupdec ([3; 2; 1]));
%! y = x;
%! z = taylor (infsupdec ([9; 12; 10]));
%! assert (isequal (x .* y, z));
%!test
%! x = taylor (infsupdec ([1, 2; 3, 4; 5, 6]));
%! y = taylor (infsupdec ([2, 3; 4, 5; 6, 7]));
%! z = taylor (infsupdec ([2, 6; 10, 22; 28, 52]));
%! assert (isequal (x .* y, z));
%!test
%! x = taylor (infsupdec (ones (3, 3, 3)), 2);
%! y = x;
%! m = infsupdec (ones (3, 3, 3, 3));
%! m(2, :) = 2;
%! z = taylor (m);
%! assert (isequal (x .* y, z));
