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
## @defmethod {@@taylor} triu (@var{A})
## @defmethodx {@@taylor} triu (@var{A}, @var{K})
## @defmethodx {@@taylor} triu (@var{A}, @var{K}, "pack")
##
## Return a new matrix formed by extracting the upper triangular part of the
## matrix @var{A}, and setting all other elements to zero.
##
## The second argument is optional, and specifies how many diagonals above or
## below the main diagonal should also be set to zero.
##
## If the option @option{pack} is given as third argument, the extracted
## elements are not inserted into a matrix, but rather stacked column-wise one
## above other.
##
## @seealso{@@taylor/tril, @@taylor/diag}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-10

function a = triu (a, k, s)

  if (nargin > 3 || nargin == 0)
    print_usage ();
    return
  endif

  if (nargin == 1)
    k = 0;
  endif

  if (abs (k) > max (size (a)))
    error ("requested diagonal out of range")
  endif
  if (k == -max (size (a)))
    k = k + 1;
  endif

  if (nargin == 3 && strcmp (s, "pack"))
    idx = triu (reshape (1:numel (a), size (a)), k, "pack");
    a.coefs = a.coefs(:,idx);
  else
    idx = tril (reshape (1:numel (a), size (a)), k - 1, "pack");
    a.coefs(:, idx) = 0;
  endif

endfunction

%!shared m, x
%! m = infsupdec (magic (3));
%! x = taylor (m, 2, "const");
%!assert (isequal (triu (x), taylor (triu (m), 2, "const")))
%!assert (isequal (triu (x, 1), taylor (triu (m, 1), 2, "const")))
%!assert (isequal (triu (x, 2), taylor (triu (m, 2), 2, "const")))
%!assert (isequal (triu (x, 3), taylor (triu (m, 3), 2, "const")))
%!assert (isequal (triu (x, -1), taylor (triu (m, -1), 2, "const")))
%!assert (isequal (triu (x, -2), taylor (triu (m, -2), 2, "const")))
%!assert (isequal (triu (x, -3), taylor (triu (m, -3), 2, "const")))
%!assert (isequal (triu (x, 0, "pack"), taylor (triu (m, 0, "pack"), 2, "const")))
%!assert (isequal (triu (x, 1, "pack"), taylor (triu (m, 1, "pack"), 2, "const")))
%!assert (isequal (triu (x, 2, "pack"), taylor (triu (m, 2, "pack"), 2, "const")))
%!assert (isequal (triu (x, 3, "pack"), taylor (triu (m, 3, "pack"), 2, "const")))
%!assert (isequal (triu (x, -1, "pack"), taylor (triu (m, -1, "pack"), 2, "const")))
%!assert (isequal (triu (x, -2, "pack"), taylor (triu (m, -2, "pack"), 2, "const")))
%!assert (isequal (triu (x, -3, "pack"), taylor (triu (m, -3, "pack"), 2, "const")))
