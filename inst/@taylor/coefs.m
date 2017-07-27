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
## @deftypeop {@@taylor} coefs (@var{X})
## @deftypeopx {@@taylor} coefs (@var{X}, @var{N})
## @comment DO NOT SYNCHRONIZE DOCUMENTATION STRING
##
## Get the coefficients of degree @{N} of the taylor expansion
## @var{X}.  @var{N} can be a vector and it then gets the coefficient
## for every element in the vector.  If @var{N} is not given, get all
## coefficients.
##
## @example
## @group
## coefs (taylor (infsupdec ([1; 2]), 2))
##   @result{} ans = [1]_com  [2]_com
##                   [0]_com  [0]_com
##                   [0]_com  [0]_com
## @end group
## @end example
## @seealso{@@taylor/order, @@taylor/derivs}
## @end deftypeop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-21

function result = coefs (x, n)

  if (nargin != 1 && nargin != 2)
    print_usage ();
    return
  endif

  if (nargin == 1)
    result = x.coefs;
  else
    s = size (x.coefs);
    s(1) = length (n);
    result = x.coefs(n + 1, :);
    result = reshape (result, s);
  endif

endfunction

%!# from the documentation string
%!assert (isequal (coefs (taylor (infsupdec ([1; 2]), 2)), infsupdec ([1, 2; 1, 1; 0, 0])))

%!test
%! x = taylor (infsupdec (magic (3)), 2);
%! assert (isequal (coefs (x, 0), reshape (infsupdec (magic (3)), [1 3 3])));
%! assert (isequal (coefs (x, 1), reshape (infsupdec (ones (3)), [1 3 3])));
%! assert (isequal (coefs (x, 2), reshape (infsupdec (zeros (3)), [1 3 3])));
%! assert (isequal (coefs (x, [1 1 2]), cat (1, infsupdec (ones (1, 3, 3)), ones (1, 3, 3), zeros (1, 3, 3))));
