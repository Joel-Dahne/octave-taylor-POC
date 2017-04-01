## Copyright 2014-2016 Joel Dahne
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
## @defmethod {@@taylor} get_derivative (@var{X})
## 
## Get the n-th derivative for the Tayor series
##
## @example
## @group
## get_derivative (taylor ([1, 2]), 1)
##   @result{} ans = 2
## @end group
## @end example
## @seealso{@@taylor/get_order}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function d = get_derivative (x, n)

  if (nargin ~= 2)
    print_usage ();
    return
  endif

  d = x.coefs(n + 1);

  if (isa (d, "infsup"))
    d = d .* factorial (infsup (n));
  else
    d = d .* factorial (n);
  endif

  return
endfunction
