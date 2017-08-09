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
## @defmethod {@@taylor} cat (@var{DIM}, @var{ARRAY1}, @var{ARRAY2}, @dots{})
##
## Return the concatenaton of N-D Taylor arrays @var{ARRAY1},
## @var{ARRAY2}, … along dimension @var{DIM}.
##
## @example
## @group
## cat (2, taylor (infsupdec (1), 2), taylor (infsupdec (2), 2))
##   @result{} ans = 1×2 Taylor matrix of order 2
##
##      ans(:,1) = [1]_com + [1]_com X + [0]_com X^2
##      ans(:,2) = [2]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/horzcat, @@taylor/vertcat}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-08-09

function result = cat (dim, varargin)

  if (nargin < 2)
    print_usage ();
    return
  endif

  if (isa (dim, "taylor"))
    print_usage ();
    return
  endif

  if (dim < 1)
    print_usage ();
    return
  endif

  ## Convert non-Taylor parameters to Taylor expansions
  taylor_idx = cellfun ("isclass", varargin, "taylor");
  to_convert_idx = not (taylor_idx);
  varargin(to_convert_idx) = cellfun (@taylor, varargin(to_convert_idx), ...
                                      "UniformOutput", false);

  s = cellfun ("struct", varargin);
  result = taylor ();
  result.coefs = cat (dim + 1, s.coefs);

endfunction

%!assert (isequal (cat (1, taylor (), taylor ()), taylor (infsupdec ([0 0; 1 1]))));
%!test
%! m = infsupdec (magic (3));
%! x = taylor (m, 2);
%! assert (isequal (cat (1, x, x), taylor ([m; m], 2)))
%! assert (isequal (cat (2, x, x), taylor ([m, m], 2)))
%! assert (isequal (cat (3, x, x), taylor (cat (3, m, m), 2)))
