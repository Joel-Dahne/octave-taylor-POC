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
## @defop {@@taylor} ctranspose (@var{X})
## @defopx Operator {@@taylor} {@var{X}'}
##
## Complex conjugation is in general not a differentiable function and
## the complex conajugation of a Taylor expansion is in general not
## a Taylor expansion.
##
## For convinience this function performs the standard transpose
## function on the input.  For real input this is equivalent.
##
## @example
## @group
## taylor (infsupdec ([1, 2, 3]), 2)'
##   @result ans = 3×1 Taylor vector of order 2
##
##      [1]_com + [1]_com X + [0]_com X^2
##      [2]_com + [1]_com X + [0]_com X^2
##      [3]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/transpose}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-09

function x = ctranspose (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  if (ndims (x) != 2)
    error ("tranpose not defined for N-D arrays")
  endif

  if (iscomplex (x.coefs))
    warning ("conjugation is not defined on complex Taylor expansions, \
performs standard transpose function");
  endif

  x = transpose (x);

endfunction

%!test
%! m = infsupdec (magic (3));
%! assert (isequal (ctranspose (taylor (m, 2)), taylor (ctranspose (m), 2)));
%!test
%! v = infsupdec (1:3);
%! assert (isequal (ctranspose (taylor (v, 2)), taylor (ctranspose (v), 2)));
%! assert (isequal (ctranspose (taylor (ctranspose (v), 2)), taylor (v, 2)));
