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
## @defop Method {@@taylor} eq (@var{X}, @var{Y})
## @defopx Operator {@@taylor} @var{X} == @var{Y}
##
## Compare Taylor expansions @var{X} and @var{Y} for inequality.
##
## True if @var{X} and @var{Y} are either of different order or have
## different coefficients.
##
## @example
## @group
##   x = taylor (infsupdec (3), 2);
##   y = taylor (infsupdec (4), 2);
##   x != y
##   @result{} ans = 1
## @end group
## @end example
## @seealso{@@taylor/ne}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-09-03

function result = ne (x, y)

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
    result = logical (zeros (size (x)) .* zeros (size (y)));
    return
  endif

  result = not (all (x.coefs == y.coefs, 1));
  result = reshape (result, [size(result)(2:end), 1]);

endfunction

%!assert (!ne (taylor (), taylor ()))
%!assert (ne (taylor (), taylor (infsupdec (1), 1)))
%!assert (!ne (taylor (infsupdec (2), 3), taylor (infsupdec (2), 3)))

%!assert (!ne (taylor (infsupdec (magic (3))), taylor (infsupdec (magic (3)))))
%!test
%! x = taylor (infsupdec (magic (3)), 3);
%! y = x;
%! y(1) = taylor (infsupdec (10), 3);
%! assert (ne (x, y), not (logical ([0 1 1; 1 1 1; 1 1 1])));
