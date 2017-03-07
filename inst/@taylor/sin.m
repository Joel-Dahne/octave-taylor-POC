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
## @defmethod {@@taylor} sin (@var{X})
## 
## Compute the sine in radians.
##
## @example
## @group
## sin (taylor ([1, 2]))
##   @result{} ans = 
## @end group
## @end example
## @seealso{@@taylor/asin, @@taylor/csc, @@taylor/sinh}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function x = sin (x)

  if (nargin ~= 1)
    print_usage ();
    return
  endif

  order = length (x.coefs);
  ## Need to compute taylor series for both sin and cos
  sin_coefs = sin (x.coefs (1));
  cos_coefs = cos (x.coefs (1));
  sin_coefs (2:order) = 0;
  cos_coefs (2:order) = 0;
  
  for k = [2:order]
    for i = [2:k]
      sin_coefs (k) += (i - 1) .* x.coefs (i) .* cos_coefs (k - i + 1);
      cos_coefs (k) += (i - 1) .* x.coefs (i) .* sin_coefs (k - i + 1);
    endfor
    sin_coefs (k) = sin_coefs (k) ./ (k - 1);
    cos_coefs (k) = -cos_coefs (k) ./ (k - 1);
  endfor

  x.coefs = sin_coefs;
endfunction
