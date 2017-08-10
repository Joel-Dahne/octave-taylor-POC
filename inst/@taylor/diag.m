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
## @deftypemethod {@@taylor} {M =} diag (@var{V})
## @deftypemethodx {@@taylor} {M =} diag (@var{V}, @var{K})
## @deftypemethodx {@@taylor} {M =} diag (@var{V}, @var{M}, @var{N})
## @deftypemethodx {@@taylor} {V =} diag (@var{M})
## @deftypemethodx {@@taylor} {V =} diag (@var{M}, @var{K})
##
## Return a diagonal matrix with vector @var{V} on diagonal @var{K}.
##
## The second argument is optional.  If it is positive, the vector is
## placed on the @var{K}-th superdiagonal.  If it is negative, it is
## placed on the -@var{K}-th subdiagonal.  The default value of
## @var{K} is 0, and the vector is placed on the main diagonal.
##
## The 3-input form returns a diagonal matrix with vector V on the
## main diagonal and the resulting matrix being of size @var{M} rows ×
## @var{N} columns.
##
## Given a matrix argument, instead of a vector, @code{diag} extracts the
## @var{K}-th diagonal of the matrix.
##
## @example
## @group
## diag (taylor (infsupdec (1:2), 2))
##   @result{} ans = 2×2 Taylor matrix of order 2
##
##      ans(:,1) =
##
##      [1]_com + [1]_com X + [0]_com X^2
##      [0]_com + [0]_com X + [0]_com X^2
##
##      ans(:,2) =
##
##      [0]_com + [0]_com X + [0]_com X^2
##      [2]_com + [1]_com X + [0]_com X^2
##
## diag (taylor (infsupdec (magic (3)), 2))
##   @result{} ans = 3×1 Taylor vector of order 2
##
##      [8]_com + [1]_com X + [0]_com X^2
##      [5]_com + [1]_com X + [0]_com X^2
##      [2]_com + [1]_com X + [0]_com X^2
##
## @end group
## @end example
## @seealso{@@taylor/tril, @@taylor/triu}
## @end deftypemethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-10

function y = diag (x, k, l)

  if (nargin > 3)
    print_usage ();
    return
  endif

  if (nargin == 1)
    k = 0;
  endif

  if (nargin == 3 && not (isvector (x)))
    error ("V must be a vector");
  endif

  if (isvector (x))
    ## Create a matrix with x as diagonal
    y = x;
    y.coefs(:) = 0;
    y.coefs = resize (y.coefs, order (x) + 1, length (x), length (x));
    diagonal = 1:length (x) + 1:length (x).^2;
    y.coefs(:, diagonal) = x.coefs;

    if (nargin < 3)
      if (k > 0)
        y.coefs = postpad (y.coefs, length (x) + abs (k), 0, 2);
        y.coefs = prepad (y.coefs, length (x) + abs (k), 0, 3);
      elseif (k < 0)
        y.coefs = prepad (y.coefs, length (x) + abs (k), 0, 2);
        y.coefs = postpad (y.coefs, length (x) + abs (k), 0, 3);
      endif
    else
      y.coefs = resize (y.coefs, order (x) + 1, k, l);
    endif
  elseif (ismatrix (x))
    ## Extract the k-th diagonal
    k_diagonal = diag (reshape (1:numel (x), size (x)), k);
    y = x;
    y.coefs = x.coefs(:, k_diagonal);
  else
    error ("Matrix must be 2-dimensional");
  endif

endfunction

%!# diag (V, K)
%!assert (isequal (diag (taylor ()), taylor ()));
%!assert (isequal (diag (taylor (infsupdec (1:3), 2, "const")), taylor (diag (infsupdec (1:3)), 2, "const")))
%!test
%! m = infsupdec (magic (3));
%! assert (isequal (diag (taylor (m, 2)), taylor (diag (m), 2)));
%! assert (isequal (diag (taylor (m, 2), 1), taylor (diag (m, 1), 2)));
%! assert (isequal (diag (taylor (m, 2), 2), taylor (diag (m, 2), 2)));
%! assert (isequal (diag (taylor (m, 2), -1), taylor (diag (m, -1), 2)));
%! assert (isequal (diag (taylor (m, 2), -2), taylor (diag (m, -2), 2)));

%!# diag (V, M, N)
%!test
%! c = infsupdec (zeros (2, 2, 3));
%! c(2, 1, 1) = 1;
%! assert (isequal (diag (taylor (), 2, 3), taylor (c)));

%!# diag (M, K)
%!test
%! m = infsupdec (magic (3));
%! assert (isequal (diag (taylor (m, 2)), taylor (diag (m), 2)))
%! assert (isequal (diag (taylor (m, 2), 1), taylor (diag (m, 1), 2)))
%! assert (isequal (diag (taylor (m, 2), 2), taylor (diag (m, 2), 2)))
%! assert (isequal (diag (taylor (m, 2), -1), taylor (diag (m, -1), 2)))
%! assert (isequal (diag (taylor (m, 2), -2), taylor (diag (m, -2), 2)))
