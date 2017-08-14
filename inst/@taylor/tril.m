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
## @defmethod {@@taylor} tril (@var{A})
## @defmethodx {@@taylor} tril (@var{A}, @var{K})
## @defmethodx {@@taylor} tril (@var{A}, @var{K}, "pack")
##
## Return a new matrix formed by extracting the lower triangular part of the
## matrix @var{A}, and setting all other elements to zero.
##
## The second argument is optional, and specifies how many diagonals above or
## below the main diagonal should also be set to zero.
##
## If the option @option{pack} is given as third argument, the extracted
## elements are not inserted into a matrix, but rather stacked column-wise one
## above other.
##
## @seealso{@@taylor/triu, @@taylor/diag}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-10

function a = tril (a, k, s)

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
  if (k == max (size (a)))
    k = k - 1;
  endif

  if (nargin == 3 && strcmp (s, "pack"))
    idx = tril (reshape (1:numel (a), size (a)), k, "pack");
    a.coefs = a.coefs(:,idx);
  else
    idx = triu (reshape (1:numel (a), size (a)), k + 1, "pack");
    a.coefs(:, idx) = 0;
  endif

endfunction

%!shared m, x
%! m = infsupdec (magic (3));
%! x = taylor (m, 2, "const");
%!assert (isequal (tril (x), taylor (tril (m), 2, "const")))
%!assert (isequal (tril (x, 1), taylor (tril (m, 1), 2, "const")))
%!assert (isequal (tril (x, 2), taylor (tril (m, 2), 2, "const")))
%!assert (isequal (tril (x, 3), taylor (tril (m, 3), 2, "const")))
%!assert (isequal (tril (x, -1), taylor (tril (m, -1), 2, "const")))
%!assert (isequal (tril (x, -2), taylor (tril (m, -2), 2, "const")))
%!assert (isequal (tril (x, -3), taylor (tril (m, -3), 2, "const")))
%!assert (isequal (tril (x, 0, "pack"), taylor (tril (m, 0, "pack"), 2, "const")))
%!assert (isequal (tril (x, 1, "pack"), taylor (tril (m, 1, "pack"), 2, "const")))
%!assert (isequal (tril (x, 2, "pack"), taylor (tril (m, 2, "pack"), 2, "const")))
%!assert (isequal (tril (x, 3, "pack"), taylor (tril (m, 3, "pack"), 2, "const")))
%!assert (isequal (tril (x, -1, "pack"), taylor (tril (m, -1, "pack"), 2, "const")))
%!assert (isequal (tril (x, -2, "pack"), taylor (tril (m, -2, "pack"), 2, "const")))
%!assert (isequal (tril (x, -3, "pack"), taylor (tril (m, -3, "pack"), 2, "const")))
