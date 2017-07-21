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
        ## Already a Taylor expansion
        x = value;
        return
      elseif (isa (value, "infsup") || isnumeric (value))
        ## Create the Taylor expansion with coefficients from input
        x = class (struct ("coefs", value), "taylor");
        return
      endif
    case 2
      if (isa (value, "taylor") && isindex (order + 1))
        ## Change the order of the expansion
        s = size (value.coefs);
        s(1) = order + 1;
        value.coefs = resize (value.coefs, s);
        x = value;
        return
      elseif (isa (value, "infsup") || isnumeric (value))
        ## Create a Taylor variable with the given order
        s = size (value);
        coefs = postpad (reshape (value, [1 s]), order + 1, 0, 1);
        coefs(2, :) = 1;
        x = class (struct ("coefs", coefs), "taylor");
        return
      endif
    case 3
      if (isa (value, "infsup") || isnumeric (value))
        s = size (value);
        coefs = postpad (reshape (value, [1 s]), order + 1, 0, 1);
        if (!(strcmp (type, "const") || strcmp (type, "c")))
          coefs(2, :) = 1;
        endif
        x = class (struct ("coefs", coefs), "taylor");
        return
      endif
  endswitch

  print_usage ();
endfunction

%!# Empty constructor
%!test
%! x = taylor ();
%! assert (coefs (x), [0; 1]);

%!# Vector
%!test
%! x = taylor (magic (3));
%! assert (coefs (x), magic (3));

%!# Taylor
%!test
%! x = taylor (magic (3));
%! y = taylor (x);
%! assert (coefs (y), magic (3));

%!# Taylor + dim
%!test
%! x = taylor (magic (3));
%! y = taylor (x, 5);
%! assert (coefs (y), postpad (magic (3), 6, 0, 1));

%!# Vector + dim
%!test
%! x = taylor ([1; 2], 3);
%! assert (coefs (x), [1, 2; 1, 1; 0, 0; 0, 0]);

%!# Create variable
%!test
%! x = taylor ([1; 2], 3, "var");
%! assert (coefs (x), [1, 2; 1, 1; 0, 0; 0, 0]);

%!# Create constant
%!test
%! x = taylor ([1; 2], 3, "const");
%! assert (coefs (x), [1, 2; 0, 0; 0, 0; 0, 0]);
