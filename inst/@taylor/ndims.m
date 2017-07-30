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
## @defmethod {@@taylor} ndims (@var{A})
##
## Returns the number of dimensions of A.
##
## For any array, the result will always be larger than or equal to 2.
## Trailing singleton dimensions are not counted.
##
## @seealso{@@taylor/size}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-30

function result = ndims (a)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = max (ndims (a.coefs) - 1, 2);

endfunction

%!assert (ndims (taylor ()), 2);
%!assert (ndims (taylor (infsupdec (zeros (2, 2, 2)), 2)), 3);
%!assert (ndims (taylor (infsupdec (magic (3)), 2)), 2);
%!assert (ndims (taylor (infsupdec (zeros (3, 1, 3, 1, 3, 1)), 2)), 5);
