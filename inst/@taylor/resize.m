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
## @defmethod {@@taylor} resize (@var{X}, @var{M})
## @defmethodx {@@taylor} resize (@var{X}, @var{M}, @var{N}, @var{...})
## @defmethodx {@@taylor} resize (@var{X}, [@var{M}, @var{N}, @var{...}])
##
## Resize Taylor array @var{X} cutting off elements as necessary.
##
## In the result, element with certain indices is equal to the corresponding
## element of @var{X} if the indices are within the bounds of @var{X};
## otherwise, the element is set to zero.
##
## If only @var{M} is supplied, and it is a scalar, the dimension of the result
## is @var{M}-by-@var{M}.  If @var{M}, @var{N}, ... are all scalars, then the
## dimensions of the result are @var{M}-by-@var{N}-by-....  If given a vector as
## input, then the dimensions of the result are given by the elements of that
## vector.
##
## An object can be resized to more dimensions than it has; in such
## case the missing dimensions are assumed to be 1.  Resizing an
## object to fewer dimensions is not possible.
##
## @example
## @group
##  resize (taylor (), 2)
##   @result{} ans = 2×2 Taylor matrix of order 1
##
##      ans(:,1) =
##
##      [0]_com + [1]_com X
##      [0]_com + [0]_com X
##
##      ans(:,2) =
##
##      [0]_com + [0]_com X
##      [0]_com + [0]_com X
##
## @end group
## @end example
## @seealso{@@taylor/reshape, @@taylor/postpad, @@taylor/prepad, @@taylor/cat}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-10

function x = resize (x, varargin)

  if (nargin < 2)
    print_usage ();
    return
  elseif (nargin == 2)
    if (length (varargin{1}) == 1)
      varargin{1} = [varargin{1}, varargin{1}];
    endif
    varargin{1} = [size(x.coefs, 1), varargin{1}];
  else
    varargin = horzcat ({size(x.coefs, 1)}, varargin);
  endif

  x.coefs = resize (x.coefs, varargin{:});

endfunction

%!shared x, m
%! m = infsupdec (magic (3));
%! x = taylor (m, 2, "const");
%!assert (isequal (resize (x, 2), taylor (resize (m, 2), 2, "const")));
%!assert (isequal (resize (x, 2, 3), taylor (resize (m, 2, 3), 2, "const")));
%!assert (isequal (resize (x, 2, 3, 4), taylor (resize (m, 2, 3, 4), 2, "const")));
%!assert (isequal (resize (x, [2, 3]), taylor (resize (m, [2, 3]), 2, "const")));
%!assert (isequal (resize (x, [2, 3, 4]), taylor (resize (m, [2, 3, 4]), 2, "const")));
