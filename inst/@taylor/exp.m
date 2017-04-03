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
## @documentencoding UTF-8
## @defmethod {@@taylor} exp (@var{X})
## 
## Compute the exponential function.
##
## @example
## @group
## exp (taylor ([2, 1]))
##   @result{} ans = []
## @end group
## @end example
## @seealso{@@taylor/log, @@taylor/pow}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function x = exp (x)

  if (nargin ~= 1)
    print_usage ();
    return
  endif

  order = get_order (x);

  exp_coefs = exp (x.coefs (1));
  exp_coefs = resize (exp_coefs, order+1, 1);
  
  for k = [1:order]
    exp_coefs (k+1) = dot ((1:k)'.*x.coefs(2:k+1), exp_coefs(k:-1:1)) ./ k;
  endfor

  x.coefs = exp_coefs;
  
endfunction
