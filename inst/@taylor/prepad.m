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
## @defmethod {@@taylor} prepad (@var{X}, @var{L})
## @defmethodx {@@taylor} prepad (@var{X}, @var{L}, @var{C})
## @defmethodx {@@taylor} prepad (@var{X}, @var{L}, @var{C}, @var{DIM})
##
## Prepend the scalar Taylor expansion @var{C} to the Taylor vector
## @var{X} until it is of length @var{L}.  If @var{C} is not given, a
## value of 0 is used.
##
## If @code{length (@var{X}) > L}, elements from the beginning of
## @var{X} are removed until a Taylor vector of length @var{L} is
## obtained.
##
## If @var{X} is a Taylor matrix, elements are prepended or removed
## from each row or column.
##
## If the optional argument DIM is given, operate along this
## dimension.
##
## If DIM is larger than the dimension of X, the result will have DIM
## dimensions.
##
## @example
## @group
##   prepad (taylor ([1; 2], 2), 4, taylor (5, 2))
##   @result{} ans = 4×1 Taylor vector of order 2
##
##      5 + 1X + 0X^2
##      5 + 1X + 0X^2
##      1 + 1X + 0X^2
##      2 + 1X + 0X^2
##
## @end group
## @end example
## @seealso{@@taylor/postpad, @@taylor/reshape, @@taylor/resize, @@taylor/cat}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-14

function x = prepad (x, len, c, dim)

  if (nargin < 2 || nargin > 4)
    print_usage ();
    return
  endif

  if (nargin < 3)
    c = 0;
  endif

  if (not (isa (x, "taylor")) && not (isa (c, "taylor")))
    x = taylor (x, 1, "const");
    c = taylor (c, 1, "const");
  elseif (not (isa (x, "taylor")))
    x = taylor (x, order (c), "const");
  elseif (not (isa (c, "taylor")))
    c = taylor (c, order (x), "const");
  elseif (order (x) != order (c))
    error ("Taylor expansions of different orders");
  endif

  if (nargin < 4)
    dim = find (size (x) != 1, 1);
    if (isempty (dim))
      dim = 1;
    endif
  endif

  idx.type = "()";
  idx.subs(1:max (ndims (x.coefs), dim)) = {":"};
  idx.subs(dim + 1) = 1:(len - size (x, dim));

  s = size (x.coefs);
  s(1) = 1;
  s(ndims(x.coefs) + 1:dim + 1) = 1;
  s(dim + 1) = max (len - size (x, dim), 0);
  c.coefs = repmat (c.coefs, s);

  x.coefs = prepad (x.coefs, len, 0, dim + 1);
  x.coefs = subsasgn (x.coefs, idx, c.coefs);

endfunction

%!shared m, x
%! m = infsupdec (magic (3));
%! x = taylor (m, 2);
%!assert (isequal (prepad (x, 4, taylor (0, 2)), taylor (prepad (m, 4), 2)));
%!assert (isequal (prepad (x, 2, taylor (0, 2)), taylor (prepad (m, 2), 2)));
%!assert (isequal (prepad (x, 4, taylor (0, 2), 2), taylor (prepad (m, 4, 0, 2), 2)));
%!assert (isequal (prepad (x, 2, taylor (0, 2), 2), taylor (prepad (m, 2, 0, 2), 2)));
%!assert (isequal (prepad (x, 4, taylor (0, 2), 3), taylor (prepad (m, 4, 0, 3), 2)));
%!assert (isequal (prepad (x, 2, taylor (0, 2), 3), taylor (prepad (m, 2, 0, 3), 2)));
%!error (prepad (x, 4, taylor (5, 3)));
