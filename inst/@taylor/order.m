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
## Get the order of the taylor expansion @var{X}.
##
## @example
## @group
## order (taylor (infsupdec ([1; 2]), 2))
##   @result{} ans = 2
## @end group
## @end example
## @seealso{@@taylor/coefs, @@taylor/derivs}
## @end deftypeop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-24

function result = order (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  result = rows (x.coefs) - 1;

endfunction

%!# from the documentation string
%!assert (order (taylor (infsupdec ([1; 2]), 2)), 2)

%!assert (order (taylor ()), 1)
%!assert (order (taylor (infsupdec (1), 2)), 2)
%!assert (order (taylor (infsupdec ([1; 2; 3; 4]))), 3)
%!assert (order (taylor (infsupdec ([1, 2; 3, 4]), 5, "const")), 5)
