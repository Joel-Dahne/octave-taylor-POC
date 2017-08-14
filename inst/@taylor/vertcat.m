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
## @defop Method {@@taylor} vertcat (@var{ARRAY1}, @var{ARRAY1}, @dots{})
## @defopx Operator {@@taylor} {[@var{ARRAY1}; @var{ARRAY2}; @dots{}]}
##
## Return the vertical concatenation of Taylor array objects along
## dimension 2.
##
## @example
## @group
## x = taylor (infsupdec (5), 2);
## [x; x; x]
##   @result{} ans = 3×1 Taylor vector of order 2
##
##      [5]_com + [1]_com X + [0]_com X^2
##      [5]_com + [1]_com X + [0]_com X^2
##      [5]_com + [1]_com X + [0]_com X^2
##
## @end group
## @end example
## @seealso{@@taylor/horzcat, @@taylor/cat}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-09

function result = vertcat (varargin)

  result = cat (1, varargin{:});

endfunction

%!test
%! x = infsupdec (5);
%! y = infsupdec (6);
%! assert (isequal (vertcat (taylor (x, 2), taylor (y, 2)), taylor (vertcat (x, y), 2)));
