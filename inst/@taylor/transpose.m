## Copyright 2017 Joel Dahne
## Copyright 2015-2016 Oliver Heimlich
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
## @defop {@@taylor} transpose (@var{X})
## @defopx Operator {@@taylor} {@var{X}.'}
##
## Return the transpose of Taylor matrix or vector @var{X}.
##
## @example
## @group
## taylor (infsupdec ([1, 2, 3]), 2).'
##   @result ans = 3×1 Taylor vector of order 2
##
##      [1]_com + [1]_com X + [0]_com X^2
##      [2]_com + [1]_com X + [0]_com X^2
##      [3]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/ctranspose}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-09

function x = transpose (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  if (ndims (x) != 2)
    error ("tranpose not defined for N-D arrays")
  endif

  ## FIXME: This can most likely be improved
  r = rows (x);
  new_coefs = [];
  for i = 1:size (x.coefs, 1)
    reshaped_part = reshape (transpose (reshape (coefs (x)(i, :, :), ...
                                                 r, [])), ...
                             1, [], r);
    new_coefs = cat (1, new_coefs, reshaped_part);
  endfor
  x.coefs = new_coefs;

endfunction

%!test
%! m = infsupdec (magic (3));
%! assert (isequal (transpose (taylor (m, 2)), taylor (transpose (m), 2)));
%!test
%! v = infsupdec (1:3);
%! assert (isequal (transpose (taylor (v, 2)), taylor (transpose (v), 2)));
%! assert (isequal (transpose (taylor (transpose (v), 2)), taylor (v, 2)));
