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
## @defop Method {@@taylor} horzcat (@var{ARRAY1}, @var{ARRAY1}, @dots{})
## @defopx Operator {@@taylor} {[@var{ARRAY1}, @var{ARRAY2}, @dots{}]}
##
## Return the horizontal concatenation of Taylor array objects along
## dimension 2.
##
## @example
## @group
## x = taylor (infsupdec (5), 2)
## [x, x, x]
##   @result{} ans = 1×3 Taylor matrix of order 2
##
##      ans(:,1) = [5]_com + [1]_com X + [0]_com X^2
##      ans(:,2) = [5]_com + [1]_com X + [0]_com X^2
##      ans(:,3) = [5]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/vertcat, @@taylor/cat}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-09

function result = horzcat (varargin)

  result = cat (2, varargin{:});

endfunction

%!test
%! x = infsupdec (5);
%! y = infsupdec (6);
%! assert (isequal (horzcat (taylor (x, 2), taylor (y, 2)), taylor (horzcat (x, y), 2)));
