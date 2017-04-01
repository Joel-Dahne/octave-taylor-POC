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
## @defmethod {@@taylor} get_order (@var{X})
## 
## Get the order of the Taylor series
##
## @example
## @group
## get_order (taylor ([1, 2]))
##   @result{} ans = 1
## @end group
## @end example
## @seealso{@@taylor/get_derivative}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function n = get_order (x)

  if (nargin ~= 1)
    print_usage ();
    return
  endif

  n = size (x.coefs, 1) - 1;

  return
endfunction
