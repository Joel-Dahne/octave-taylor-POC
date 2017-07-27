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
## @defmethod {@@taylor} end (@var{A}, @var{k}, @var{n})
##
## The magic index @code{end} refers to the last valid entry in an indexing
## operation.
##
## For @var{n} = 1 the output of the indexing operation is a column vector and a
## single index is used to address all entries in column-first order.  For
## @var{n} > 1 the @var{k}'th dimension is addressed separately.
##
## @example
## @group
## x = taylor (infsupdec ([1, 2, 3; 4, 5, 6]), 2);
## A(1, end)
##    @result{} [3]_com + [1]_com X + [0]_com X^2
## A(end, 1)
##    @result{} [4]_com + [1]_com X + [0]_com X^2
## A(end)
##    @result{} [6]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/size, @@taylor/length, @@taylor/numel, @@taylor/rows, @@taylor/columns}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-21

function result = end (a, k, n)

  if (n == k)
    result = prod (size (a.coefs)(n+1:ndims (a.coefs)));
  else
    result = size (a.coefs, k+1);
  endif

endfunction

%!assert (isequal (taylor (infsupdec (magic (3)), 2)(end), taylor (infsupdec (2), 2)));
%!assert (isequal (taylor (infsupdec (magic (3)), 2)(end, 2), taylor (infsupdec (9), 2)));
%!assert (isequal (taylor (infsupdec (magic (3)), 2)(2, end), taylor (infsupdec (7), 2)));
%!assert (isequal (taylor (infsupdec ([1 2; 3 4; 5 6]), 2)(end:-1:1, :), taylor (infsupdec ([5 6; 3 4; 1 2]), 2)));
