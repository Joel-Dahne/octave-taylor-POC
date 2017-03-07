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

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function x = taylor (coefs, order)

  x = class (struct ("coefs", [1]), "taylor");
  
  switch nargin
    case 0
      ## order 1 constant
      return
      
    case 1
      if (isa (coefs, "taylor"))
        ## already a taylor expansion
        x = coefs;
        return
      endif

      if (isvector (coefs))
        ## create the taylor expansion with coefficients from input
        x = class (struct ("coefs", coefs), "taylor");
        return
      endif

      print_usage ()
      return
    case 2
      if (isa (coefs, "taylor"))
        if (isindex (order + 1))
          ## Change the order of the expansion
          if (order + 1 > length (coefs.coefs))
            coefs.coefs(order + 1) = 0;
            x = coefs;
            return
          else
            coefs.coefs = coefs.coefs(1:order + 1);
            x = coefs;
            return
          endif
        endif
      endif

      if (isscalar (coefs))
        ## create a constant with the given order
        coefs = resize (coefs, 1, order + 1);
        x = class (struct ("coefs", coefs), "taylor");
      endif
  endswitch
  
endfunction
