## Copyright 2018 Joel Dahne
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
## @defmethod {@@taylor} recursionmethod (@var{g}, @var{x}, @var{fun})
##
## This function is used for computing the Taylor series of functions
## which use a certain kind of recursion.
##
## These are @var(log).
##
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2018-01-17

function f = recursionmethod (g, x, fun)

  if (nargin != 3)
    print_usage ();
    return
  endif

  if (not (isa (g, "taylor")) && not (isa (x, "taylor")))
    g = taylor (g, 1, "const");
    x = taylor (x, 1, "const");
  elseif (not (isa (g, "taylor")))
    g = taylor (g, order (x), "const");
  elseif (not (isa (x, "taylor")))
    x = taylor (x, order (g), "const");
  elseif (order (g) != order (x))
    error ("Taylor expansions of different orders");
  endif

  f = g;

  f.coefs(1, :) = fun (x.coefs(1, :));

  for k = 1:order (f)
    f.coefs(k+1, :) = (x.coefs(k+1, :) - ...
                            dot ((1:k-1)'.*f.coefs(2:k, :), ...
                                 g.coefs(k:-1:2, :), 1)./k)./g.coefs(1, :);
  endfor

endfunction

## This is indirectly tested in the functions that uses it.
