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
## -*- texinfo -*-
## @documentencoding UTF-8
## @defop Method {@@taylor} minus (@var{X}, @var{Y})
## @defopx Operator {@@taylor} {@var{X} - @var{Y}}
##
## Subract the taylor expansion @var{Y} to @var{X}
##
## @example
## @group
## x = taylor ([1, 0]);
## y = taylor ([1, 2]);
## x - y
##   @result{} ans = [0, -2]
## @end group
## @end example
## @seealso{@@taylor/plus}
## @end defop

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05
function x = minus (x, y)

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

  if (length (x.coefs) ~= length (y.coefs))
    printf ("%s and %s must be of the same degree", inputname (1),
            inputname(2))
    return
  endif

  x.coefs = x.coefs - y.coefs;

endfunction
