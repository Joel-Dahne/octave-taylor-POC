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
## @defmethod {@@taylor} derivs (@var{X}, @var{N})
##
## Get the @var{N}-th derivative of the Tayor expansion @var{X}.
## @var{N} can be a vector and it then gets the derivative for every
## element in the vector.  If @var{N} is not given, get all
## derivatives.
##
## @example
## @group
## derivs (taylor ([1; 2]), 1)
##   @result{} ans = 2
## @end group
## @end example
## @seealso{@@taylor/order, @@taylor/coefs}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function result = derivs (x, n)

  if (nargin != 1 && nargin != 2)
    print_usage ();
    return
  endif


  if (nargin == 1)
    d = coefs (x);
    n = (0 : size (d, 1) - 1)';
  elseif (nargin == 2)
    d = coefs (x, n);
    n = n(:);
  endif

  if (isa (d, "infsupdec"))
    n = infsupdec (n);
  elseif (isa (d, "infsup"))
    n = infsup (n);
  endif

  result = d .* factorial (n);
endfunction

%!test
%! x = taylor (ones (5, 1));
%! assert (derivs (x), [1; 1; 2; 6; 24]);
%! assert (derivs (x, 0), 1)
%! assert (derivs (x, 1), 1)
%! assert (derivs (x, 2), 2)
%! assert (derivs (x, 3), 6)
%! assert (derivs (x, 4), 24)
%!test
%! x = taylor (magic (3), 2);
%! assert (derivs (x, 0), reshape (magic (3), [1 3 3]));
%! assert (derivs (x, 1), ones (1, 3, 3));
%! assert (derivs (x, 2), zeros (1, 3, 3));
%! assert (derivs (x, [1 1 2]), cat (1, ones (1, 3, 3), ones (1, 3, 3), zeros (1, 3, 3)));
