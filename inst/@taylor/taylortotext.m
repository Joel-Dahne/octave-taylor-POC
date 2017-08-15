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
## @deftypemethod {@@taylor} {@var{S} =} taylortotext (@var{X})
## @deftypemethodx {@@taylor} {@var{S} =} taylortotext (@var{X}, @var{FORMAT})
##
## Build a representation of the Taylor expansion @var{X}.
##
## Output @var{S} is a simple string for scalar Taylor expansions, and
## a cell array of strings for Taylor expansions arrays.
##
## For interval valued Taylor expansions the interval boundaries for
## the coefficients are stored in binary floating point format and are
## converted to decimal or hexadecimal format with possible precision
## loss.  If output is not exact, the boundaries are rounded
## accordingly (e. g. the upper boundary is rounded towards infinite
## for output representation).
##
## The exact decimal format may produce a lot of digits.
##
## Possible values for @var{FORMAT} are: @code{decimal} (default),
## @code{exact decimal}, @code{exact hexadecimal}, @code{auto}.
##
## For non-interval valued Taylor expansions specifying a format is
## not supported.
##
## @example
## @group
## x = taylor (infsupdec (1 + eps), 1);
## taylortotext (x)
##   @result{} [1.0000000000000002, 1.000000000000001]_com + [1]_com X
## @end group
## @end example
## @example
## @group
## z = taylor ();
## taylortotext (z)
##   @result{} [0]_com + [1]_com X
## @end group
## @end example
## @seealso{@@infsup/intervaltotext}
## @end deftypemethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-25

function [s, isexact] = taylortotext (x, format)

  if (nargin > 2 || nargin == 0)
    print_usage ();
    return
  endif

  isexact = false ();

  if (nargin < 2)
    format = "decimal";
  endif

  s = cell (size (x));
  if (isa (x.coefs, "infsup"))
    [intervals, isexact] = intervaltotext (x.coefs, format);
    if (not (iscell (intervals)))
      intervals = {intervals};
    endif
  endif


  parts = prod (size (x.coefs) (2:end));
  partorder = order (x);

  for part = 1:parts
    buffer = "";
    if (isa (x.coefs, "infsup"))
      for i = 0:partorder
        if (i == 0)
          buffer = strcat (buffer, sprintf ("%s", intervals{1, part}));
        elseif (i == 1)
          buffer = strcat (buffer, sprintf (" + %s X", intervals{2, part}));
        else
          buffer = strcat (buffer, sprintf (" + %s X^%d",
                                            intervals{i + 1, part},
                                            i));
        endif
      endfor
    else
      for i = 0:partorder
        if (i == 0)
          buffer = strcat (buffer, num2str (x.coefs (1, part)));
        elseif (i == 1)
          buffer = strcat (buffer, sprintf (" + %sX",
                                            num2str (x.coefs (2, part))));
        else
          buffer = strcat (buffer, sprintf (" + %sX^%d",
                                            num2str (x.coefs (i + 1, part)),
                                            i));
        endif
      endfor
    endif
    s(part) = buffer;
  endfor

  if (isscalar (s))
    s = s{1};
  endif

endfunction

%!# from the documentation string
%!assert (taylortotext (taylor (infsupdec (1 + eps), 1)), "[1.0000000000000002, 1.000000000000001]_com + [1]_com X");
%!assert (taylortotext (taylor ()), "[0]_com + [1]_com X");

%!assert (taylortotext (taylor (infsupdec (1 + eps), 1), "exact decimal"), "[1.0000000000000002220446049250313080847263336181640625]_com + [1]_com X");
%!assert (taylortotext (taylor (infsupdec (1 + eps), 1), "exact hexadecimal"), "[0x1.0000000000001p+0]_com + [0x1.0000000000000p+0]_com X");
%!test
%! output_precision (3, 'local');
%! assert (taylortotext (taylor (infsupdec (pi), 1), "auto"), "[3.14, 3.15]_com + [1]_com X");
%! output_precision (4, 'local');
%! assert (taylortotext (taylor (infsupdec (pi), 1), "auto"), "[3.141, 3.142]_com + [1]_com X");
%!assert (taylortotext (taylor (infsupdec ([1; 2; 3; 4; 5; 6]))), "[1]_com + [2]_com X + [3]_com X^2 + [4]_com X^3 + [5]_com X^4 + [6]_com X^5")
%!assert (reshape (taylortotext (taylor (infsupdec (reshape (1:120, 2, 3, 4, 5)), 2)), 1, 120), taylortotext (taylor (infsupdec (1:120), 2)));
