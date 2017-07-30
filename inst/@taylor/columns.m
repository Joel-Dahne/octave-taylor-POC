## Copyrifght 2017 Joel Dahne
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
## @defmethod {@@taylor} columns (@var{A})
##
## Return the number of columns of @var{A}.
## @seealso{@@taylor/numel, @@taylor/size, @@taylor/length, @@taylor/rows, @@taylor/end}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-21

function result = columns (a)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = size (a.coefs, 3);

endfunction

%!assert (columns (taylor (infsupdec (zeros (3, 4)), 2)), 4);
%!assert (columns (taylor (infsupdec (zeros (0, 4)), 2)), 4);
%!assert (columns (taylor (infsupdec (zeros (3, 0)), 2)), 0);
%!assert (columns (taylor (infsupdec (zeros (3, 1)), 2)), 1);
