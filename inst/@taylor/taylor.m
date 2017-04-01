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
## @deftypeop Constructor {@@taylor} @var{X} = taylor ()
## @deftypeopx Constructor {@@taylor} @var{X} = taylor (@var{V})
## @deftypeopx Constructor {@@taylor} @var{X} = taylor (@var{C}, @var{dim})
## @deftypeopx Constructor {@@taylor} @var{X} = taylor (@var{C}, @var{dim}, @var{type})
##
## Create a Taylor series. 

## Author: Joel Dahne
## Keywords: taylor arithmetic
## Created: 2017-03-05

function x = taylor (value, order, type)

  
  switch nargin
    case 0
      ## order 1 variable
      x = class (struct ("coefs", [0; 1]), "taylor");
      return
      
    case 1
      if (isa (value, "taylor"))
        ## Already a taylor expansion
        x = value;
        return
      endif

      if (isvector (value))
        ## Create the taylor expansion with coefficients from input
        x = class (struct ("coefs", vec (value)), "taylor");
        return
      endif

      print_usage ()
      return
    case 2
      if (isa (value, "taylor"))
        if (isindex (order + 1))
          ## Change the order of the expansion
          value.coefs = resize (value.coefs, order + 1, 1);
          x = value;
          return
        endif
      endif

      if (isscalar (value))
        ## Create a constant with the given order
        value = resize (value, order + 1, 1);
        x = class (struct ("coefs", value), "taylor");
        return
      endif
    case 3
      if (isscalar (value))
        if (strcmp (type, "var"))
          coefs = resize (value, order + 1, 1);
          coefs(2) = 1;
          x = class (struct ("coefs", coefs), "taylor");
          return
        elseif (strcmp(type, "const"))
          coefs = resize (value, order + 1, 1);
          x = class (struct ("coefs", coefs), "taylor");
          return
        endif
      endif
  endswitch
  
endfunction

%!# Empty constructor
%!

%!# Vector
%!

%!# Taylor
%!

%!# Taylor + dim

%!# Constant + dim

%!# Create variable

%!# Create constant
