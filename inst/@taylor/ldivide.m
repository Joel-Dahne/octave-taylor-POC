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
## @defop Method {@@taylor} ldivide (@var{X}, @var{Y})
## @defopx Operator {@@taylor} {@var{X} .\ @var{Y}}
##
## Divide the Taylor expansion @var{Y} by @var{X}.
##
## @example
## @group
##   x = taylor (infsupdec (6), 2);
##   y = taylor (infsupdec (2), 2);
##   x .\ y
##   @result{} ans = [0.33333, 0.33334]_com + [0.11111, 0.11112]_com X + [-0.018519, -0.018518]_com X^2
## @end group
## @end example
## @seealso{@@taylor/rdivide, @@taylor/times}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-15

function result = ldivide (x, y)

  if (nargin != 2)
    print_usage();
    return
  endif

  result = rdivide (y, x);

endfunction
