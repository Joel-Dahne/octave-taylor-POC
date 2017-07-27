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
## @defmethod {@@taylor} rows (@var{A})
##
## Return the number of rows of @var{A}.
## @seealso{@@taylor/numel, @@taylor/size, @@taylor/length, @@taylor/columns, @@taylor/end}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-21

function result = rows (a)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = size (a.coefs, 2);

endfunction

%!assert (rows (taylor (infsupdec (zeros (3, 4)), 2)), 3);
