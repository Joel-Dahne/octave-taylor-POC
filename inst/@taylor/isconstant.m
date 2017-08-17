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
## @defmethod {@@taylor} isconstant (@var{A})
##
## Returns true if @var{A} is a constant Taylor expansion. That is,
## all coefficients but the first are zero.
##
## Warning: That this function returns true does not necesarilly mean
## that the function is constant. For a Taylor expansion of order
## @var{n} it might be that the first @var{n} derivatives are zero but
## not the derivative @code{n+1}. Numerically it should however give
## the exact same results as using a constant.
##
## @example
## @group
##   isscalar (taylor (infsupdec (1), 2, "const"))
##   @result{} ans = 1
## @end group
## @end example
## @seealso{@@taylor/isscalar}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-17

function result = isconstant (a)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = reshape (all (a.coefs(2:end, :) == 0, 1), size (a));

endfunction

%!assert (isconstant(taylor (infsupdec (1), 2, "const")));
%!assert (isconstant(taylor (infsupdec (0), 2, "const")));
%!assert (!isconstant(taylor (infsupdec (1), 2)));
%!assert (!isconstant(taylor (infsupdec (0), 2)));
%!assert (isconstant(taylor (infsupdec ([1; 1]), 2)) == logical ([0; 0]));
%!assert (isconstant(taylor (infsupdec ([1; 1]), 2, "const")) == logical ([1; 1]));
%!assert (isconstant(taylor (infsupdec ([1, 1; 1, 0; 0, 0]))) == logical ([0; 1]));
