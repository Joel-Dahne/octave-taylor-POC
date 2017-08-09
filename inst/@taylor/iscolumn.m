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
## @defmethod {@@taylor} iscolumn (@var{A})
##
## Returns true if @var{A} is a Taylor column vector.
##
## @seealso{@@taylor/isrow, @@taylor/isscalar, @@taylor/isvector, @@taylor/ismatrix}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-30

function result = iscolumn (a)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = (ndims (a) == 2) & (size (a, 2) == 1);

endfunction

%!assert (iscolumn (taylor (infsupdec (ones (1, 1)), 2)));
%!assert (iscolumn (taylor (infsupdec (ones (4, 1)), 2)));
%!assert (iscolumn (taylor (infsupdec (ones (0, 1)), 2)));
%!assert (!iscolumn (taylor (infsupdec (ones (2, 2)), 2)));
%!assert (!iscolumn (taylor (infsupdec (ones (2, 1, 2)), 2)));
