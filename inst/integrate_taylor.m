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
## @defmethod integrate_taylor (@var{F}, @var{X}, @var{order}, @var{tol})
## 
## Compute the integral of @var{F} over the domain @var{X}, given as
## an interval, using a Taylor expansion of order @var{order} and
## tolerance @var{tol}.
##
## @example
## @group
## integrate_taylor (@(x) sin (x), infsup(-1, 8))
##   @result{} ans \subset [0.6858, 0.68581]
## @end group
## @end example
## @seealso{@@taylor/cos}
## @end defmethod

## Author: Joel Dahne
## Keyworders: taylor arithmetic
## Created: 2017-03-05

function integral = integrate_taylor (F, X, order, tol)

  if (nargin ~= 2 && nargin ~= 3 && nargin ~= 4)
    print_usage ();
    return
  endif

  if (nargin < 3)
    order = 6;
  endif
  if (nargin ~= 4)
    ## Same default as for quad
    tol = sqrt (eps);
  endif

  intervals = [X];
  tols = [tol];
  integral = 0;
  
  while size (intervals, 1) ~= 0
    integrals = infsup (zeros (size (intervals)));
    
    for i = 1:size (intervals, 1)
      integrals(i) = enclose_integral (F, intervals(i), order, tol);
    endfor
    index = wid (integrals) <= tol;
  
    if sum (index) > 0
      integral += sum (integrals(index));
    endif
    
    intervals = intervals(!index);
    intervals = [infsup(inf(intervals), mid(intervals))
                 infsup(mid(intervals), sup(intervals))];

    tol /= 2;

    if (size (intervals, 1) > 1000)
      disp ("To many iterations!");
      integral += integrals(!index);
      return
    endif
  endwhile
                           
endfunction
  
function sum = enclose_integral (F, X, order, tol)
  ## FIXME We would need an enclosure of the mid point and radius
  [m, r] = rad (X);
  m = infsup (m);
  r = infsup (r);
  
  Fx = F (taylor (X, order, "var"));
  
  fx = F (taylor (m, order, "var"));

  sum = dot (get_coef (fx, 0:2:order), r.^(1:2:order+1)'./(1:2:order+1)');

  eps = sup (abs (get_coef (Fx, order) - get_coef (fx, order)));
  sum += infsup (-eps, eps).*r.^(order + 1)./(order + 1);
  sum *= 2;
endfunction
