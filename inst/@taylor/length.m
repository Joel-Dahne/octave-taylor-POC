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
## @defmethod {@@taylor} length (@var{A})
##
## Return the length of Taylor object @var{A}.
##
## The length is 0 for empty objects, 1 for scalars, and the number of
## elements for vectors.  For matrix or N-dimensional objects, the
## length is the number of elements along the largest dimension.
## @seealso{@@taylor/numel, @@taylor/size, @@taylor/rows, @@taylor/columns, @@taylor/end}
## @end defmethod

## Author: Oliver Heimlich
## Keywords: interval
## Created: 2014-10-29

function result = length (a)

  if (nargin != 1)
    print_usage ();
    return
  endif

  s = size (a.coefs)(2:end);
  if (all (s))
    result = max (s);
  else
    result = 0;
  endif

endfunction

%!assert (length (taylor ([], 2)), 0);
%!assert (length (taylor (0, 2)), 1);
%!assert (length (taylor (zeros (3, 1), 2)), 3);
%!assert (length (taylor (zeros (1, 4), 2)), 4);
%!assert (length (taylor (zeros (3, 4), 2)), 4);
%!assert (length (taylor (zeros (3, 0, 4), 2)), 0);
