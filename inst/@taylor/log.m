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
## @defmethod {@@taylor} log (@var{X})
## 
## Compute the natural logarithm.
##
## The function is only defined where @var{X} is positive.
##
## @example
## @group
## log (taylor ([2, 1]))
##   @result{} ans = []
## @end group
## @end example
## @seealso{@@taylor/exp, @@taylor/pow}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function x = log (x)

  if (nargin ~= 1)
    print_usage ();
    return
  endif

  order = length (x.coefs);

  log_coefs = log (x.coefs (1));
  log_coefs (2:order) = 0;
  
  for k = [2:order]
    for i = [2:k - 1]
      log_coefs (k) -= (i - 1) .* log_coefs (i) .* x.coefs (k - i + 1);
    endfor
    log_coefs (k) = log_coefs (k) ./ (k - 1);
    log_coefs (k) += x.coefs (k);
  endfor

  log_coefs(2:order) = log_coefs (2:order) ./ x.coefs (1);
  
  x.coefs = log_coefs;
  
endfunction
