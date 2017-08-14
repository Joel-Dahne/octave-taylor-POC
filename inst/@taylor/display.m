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
## @defmethod {@@taylor} display (@var{X})
##
## Display the variable name and value of Taylor expansion @var{X}.
##
## If @var{X} is a variable, the Taylor expansion is display together
## with its variable name.
##
## For non-scalar Taylor expansions the size and classification
## (Taylor vector, matrix or array together with order) is displayed
## before the content.
##
## @example
## @group
## display (taylor (infsupdec (2), 2));
##   @result{} [2]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @example
## @group
## x = taylor (infsupdec (2), 2); display (x);
##   @result{} x = [2]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @example
## @group
## y = taylor (infsupdec (eps), 2); display (y);
##   @result{} y = [2.2204e-16, 2.2205e-16]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @example
## @group
## z = taylor (infsupdec (pascal (2)), 2); display (z);
##   @result{} z = 2×2 Taylor matrix of order 2
##
##      ans(:,1) =
##
##      [1]_com + [1]_com X + [0]_com X^2
##      [1]_com + [1]_com X + [0]_com X^2
##
##      ans(:,2) =
##
##      [1]_com + [1]_com X + [0]_com X^2
##      [2]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/disp, @@taylor/taylortotext}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-26

function display (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  ## FIXME: Does not handle current_print_indent_level in any way

  label = inputname (1);

  global current_print_indent_level;
  save_current_print_indent_level = current_print_indent_level;
  unwind_protect
    if (isempty (label) && regexp(argn, '^\[\d+,\d+\]$'))
      ## During output of cell array contents
      label = argn;
      ## FIXME: Need access to octave_value::current_print_indent_level
      ## for correctly formatted nested cell array output
      current_print_indent_level = 2;
    else
      current_print_indent_level = 0;
    endif

    line_prefix = " "(ones (1, current_print_indent_level));

    s = disp (x);

    printf (line_prefix);
    if (not (isempty (label)))
      printf (label);
      printf (" = ");
    endif

    if (ndims (x.coefs) == 2 && size (x) == [1 1])
      ## Scalar Taylor expansion
      printf (s);
      if (isempty (label))
        printf ("\n");
      endif
      return
    endif

    printf ("%d", size (x, 1))
    if (ispc ())
      printf ("x%d", size (x)(2:end))
    else
      ## The Microsoft Windows console does not support multibyte characters.
      printf ("×%d", size (x)(2:end))
    endif

    if (ndims (x.coefs) == 2)
      printf (" Taylor vector");
    elseif (ndims (x.coefs) == 3)
      printf (" Taylor matrix");
    else
      printf (" Taylor array")
    endif
    printf (" of order %d", order (x));
    printf ("\n\n");

    if (not (isempty (s)))
      if (current_print_indent_level > 0)
        s = strrep (s, "\n", cstrcat ("\n", line_prefix));
        s(end - current_print_indent_level + 1 : end) = "";
      endif
      printf (s)
    endif
  unwind_protect_cleanup
    current_print_indent_level = save_current_print_indent_level;
  end_unwind_protect

endfunction

%!# Can't test the display function. Would have to capture console output.
%!# However, this is largely done with the help of the doctest package.
%!assert (1);
