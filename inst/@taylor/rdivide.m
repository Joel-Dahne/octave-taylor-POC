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
## @defop Method {@@taylor} rdivide (@var{X}, @var{Y})
## @defopx Operator {@@taylor} {@var{X} ./ @var{Y}}
## 
## Divide the Taylor series @var{X} by @var{Y}.
##
## @example
## @group
## x = taylor ([3, 1]);
## y = taylor ([1, 2]);
## x ./ y
##   @result{} ans = []
## @end group
## @end example
## @seealso{@@taylor/times}
## @end defop

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function result = rdivide (x, y)

  if (nargin ~= 2)
    print_usage();
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
            inputname(2));
    return
  endif

  order = length (x.coefs);

  #if (isa (x.coefs, "infsup"))
  #  div_coefs = infsup([]);
  #else
  #  div_coefs = [];
  #endif

  div_coefs = x.coefs (1) ./ y.coefs;
  div_coefs (order) = 0;
  
  for k = [2:order]
    div_coefs (k) = (x.coefs (k) - dot (div_coefs (1:k-1),
                                        y.coefs (k:-1:2))) ...
                    ./ (y.coefs (1));
  endfor

  result = taylor(div_coefs);
  
endfunction
