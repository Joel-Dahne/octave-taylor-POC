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
## @defop Method {@@taylor} plus (@var{X}, @var{Y})
## @defopx Operator {@@taylor} @var{X} + @var{Y}
##
## Add the Taylor expansion @var{X} to @var{Y}.
##
## @example
## @group
##   x = taylor (infsupdec (3), 2);
##   y = taylor (infsupdec (4), 2);
##   x + y
##   @result{} ans = [7]_com + [2]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/minus, @@taylor/uplus}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-14

function x = plus (x, y)

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

  x.coefs = x.coefs + y.coefs;

endfunction

%!test
%! x = taylor (infsupdec ([5; 1]));
%! y = taylor (infsupdec ([6; 1]));
%! z = taylor (infsupdec ([11; 2]));
%! assert (isequal (x + y, z))
%!test
%! x = taylor (infsupdec (2), 2);
%! y = infsupdec (3);
%! z = taylor (infsupdec ([5; 1; 0]));
%! assert (isequal (x + y, z))
%!test
%! x = taylor (infsupdec (2), 2);
%! y = 3;
%! z = taylor (infsupdec ([5; 1; 0]));
%! assert (isequal (x + y, z))
