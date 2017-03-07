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
## @defop Method {@@taylor} power (@var{X}, @var{Y})
## @defopx Operator {@@taylor} {@var{X} .^ @var{Y}}
## 
## Computes the general power function.
##
## The function is only defined where @var{X} is positive.
##
## @example
## @group
## power (taylor ([2, 1]))
##   @result{} ans = []
## @end group
## @end example
## @seealso{@@taylor/exp, @@taylor/log}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function x = power (x, y)

  if (nargin ~= 2)
    print_usage ();
    return
  endif
  
  if (not (isa (x, "taylor")))
    x = taylor (x, length (y.coefs) - 1);
  endif
  if (not (isa (y, "taylor")))
    y = taylor (y, length (x.coefs) - 1);
  endif

  x = exp (y .* log (x));
  
endfunction
