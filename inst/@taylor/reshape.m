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
## @defmethod {@@taylor} reshape (@var{A}, @var{M}, @var{N}, @var{...})
## @defmethodx {@@taylor} reshape (@var{A}, [@var{M}, @var{N}, @var{...}])
## @defmethodx {@@taylor} reshape (@var{A}, @var{...}, @var{[]}, @var{...})
##
## Return an Taylor matrix with the specified dimensions (@var{M},
## @var{N}, ...) whose elements are taken from the interval matrix
## @var{A}.  The elements of the matrix are accessed in column-major
## order (like Fortran arrays are stored).
##
## Note that the total number of elements in the original matrix
## (@code{prod (size (@var{A}))}) must match the total number of
## elements in the new matrix (@code{prod ([@var{M} @var{N}
## @var{...}])}).
##
## A single dimension of the return matrix may be left unspecified and
## Octave will determine its size automatically.  An empty matrix ([])
## is used to flag the unspecified dimension.
##
## @example
## @group
##  reshape (taylor (infsupdec (1:6), 2), 3, 2)
##   @result{} ans = 3×2 Taylor matrix of order 2
##
##      ans(:,1) =
##
##      [1]_com + [1]_com X + [0]_com X^2
##      [2]_com + [1]_com X + [0]_com X^2
##      [3]_com + [1]_com X + [0]_com X^2
##
##      ans(:,2) =
##
##      [4]_com + [1]_com X + [0]_com X^2
##      [5]_com + [1]_com X + [0]_com X^2
##      [6]_com + [1]_com X + [0]_com X^2
##
## @end group
## @end example
## @seealso{@@taylor/resize, @@taylor/cat, @@taylor/postpad, @@taylor/prepad}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-11

function a = reshape (a, varargin)

  ## FIXME: Improve error message for invalid sizes. It now uses the
  ## size of a.coefs in the error message which could be confusing.

  if (nargin < 2)
    print_usage ();
    return
  elseif (nargin == 2)
    if (length (varargin{1}) == 1)
      error ("must specify 2 or more dimensions");
    endif
    varargin{1} = [size(a.coefs, 1), varargin{1}];
  else
    varargin = horzcat ({size(a.coefs, 1)}, varargin);
  endif

  a.coefs = reshape (a.coefs, varargin{:});

endfunction

%!shared x, m
%! m = infsupdec (1:12);
%! x = taylor (m, 2);
%!assert (isequal (reshape (x, 1, 12), taylor (reshape (m, 1, 12), 2)));
%!assert (isequal (reshape (x, 12, 1), taylor (reshape (m, 12, 1), 2)));
%!assert (isequal (reshape (x, 3, 4), taylor (reshape (m, 3, 4), 2)));
%!assert (isequal (reshape (x, 2, 2, 3), taylor (reshape (m, 2, 2, 3), 2)));
%!assert (isequal (reshape (x, 2, 2, 1, 3), taylor (reshape (m, 2, 2, 1, 3), 2)));
%!assert (isequal (reshape (x, 2, []), taylor (reshape (m, 2, []), 2)));
%!assert (isequal (reshape (x, [], 2), taylor (reshape (m, [], 2), 2)));
%!assert (isequal (reshape (x, 2, [], 2), taylor (reshape (m, 2, [], 2), 2)));
%!assert (isequal (reshape (x, [2 6]), taylor (reshape (m, [2 6]), 2)));
%!assert (isequal (reshape (x, [2 2 3]), taylor (reshape (m, [2 2 3]), 2)));
