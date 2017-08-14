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
## @defmethod {@@taylor} disp (@var{X})
##
## Display the value of Taylor expansion @var{X}.
##
## Note that the output from @code{disp} always ends with a newline.
##
## If an output value is requested, @code{disp} prints nothing and returns the
## formatted output in a string.
##
## @example
## @group
## format long
## disp (taylor (infsupdec ("pi"), 1))
##   @result{} [3.14159265358979, 3.1415926535898]_com + [1]_com X
## format short
## disp (taylor (infsupdec ("pi"), 1))
##   @result{} [3.1415, 3.1416]_com + [1]_com X
## disp (taylor (infsupdec (1 : 5), 2))
##   @result{}    ans(:,1) = [1]_com + [1]_com X + [0]_com X^2
##  ans(:,2) = [2]_com + [1]_com X + [0]_com X^2
##  ans(:,3) = [3]_com + [1]_com X + [0]_com X^2
##  ans(:,4) = [4]_com + [1]_com X + [0]_com X^2
##  ans(:,5) = [5]_com + [1]_com X + [0]_com X^2
## s = disp (taylor (infsupdec (0), 2))
##   @result{} s = [0]_com + [1]_com X + [0]_com X^2
## @end group
## @end example
## @seealso{@@taylor/display, @@taylor/taylortotext}
## @end defmethod

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-25

function varargout = disp (x)

  if (nargin != 1)
    print_usage ();
    return
  endif

  ## With format="auto" the output precision can be set with the format command
  s = taylortotext (x, "auto");

  if (not (iscell (s)))
    ## Scalar Taylor expansion
    if (nargout == 0)
      disp (s);
    else
      varargout{1} = strcat (s, "\n");
    endif
    return
  endif

  if (numel (s) == 0)
    ## No output
    if (nargout != 0)
      varargout{1} = "";
    endif
    return
  endif

  buffer = "";
  numberofvectorparts = prod (size (x)(2:end));
  vectorsize = rows (x);
  dims = ndims (x.coefs);

  for vectorpart = 1:numberofvectorparts
    if (dims > 2)
      ## Print the index for the current vector in the array
      buffer = strcat (buffer, "ans(:");
      vectorpartsubscript = cell (1, dims - 2);

      [vectorpartsubscript{:}] = ind2sub (size (x)(2:end), vectorpart);
      buffer = strcat (buffer, ...
                       sprintf(",%d", ...
                               vectorpartsubscript{1:dims - 2}));
      buffer = strcat (buffer, ") =");
      if (vectorsize > 1)
        buffer = strcat (buffer, "\n\n");
      endif
    endif

    ## FIXME: Add handling of Taylor expansions that are to long for
    ## the terminal
    subvector = "";
    if (vectorsize > 1)
      ## Loop over all Taylor expansions in the subvector
      for i = 1:vectorsize
        ## Print current Taylor expansion
        subvector = cstrcat (subvector, "   ", s{i, vectorpart}, "\n");
      endfor
      subvector = strcat (subvector, "\n");
    else
      ## Only one Taylor expansion in the subvector
      subvector = cstrcat (subvector, " ", s{1, vectorpart}, "\n");
    endif
    buffer = strcat (buffer, subvector);

    if (nargout == 0)
      printf (buffer);
      buffer = "";
    endif
  endfor

  if (nargout > 0)
    varargout{1} = buffer;
  endif
endfunction

%!assert (disp (taylor (infsupdec ([]))), "");
%!assert (disp (taylor (infsupdec(0), 2)), "[0]_com + [1]_com X + [0]_com X^2\n");
%!assert (disp (taylor (infsupdec(0, 1), 2)), "[0, 1]_com + [1]_com X + [0]_com X^2\n");
%!assert (disp (taylor (infsupdec([0 0]), 2)), "ans(:,1) = [0]_com + [1]_com X + [0]_com X^2\nans(:,2) = [0]_com + [1]_com X + [0]_com X^2\n");
%!assert (disp (taylor (infsupdec([0 0; 0 0]), 2)), "ans(:,1) =\n\n   [0]_com + [1]_com X + [0]_com X^2\n   [0]_com + [1]_com X + [0]_com X^2\n\nans(:,2) =\n\n   [0]_com + [1]_com X + [0]_com X^2\n   [0]_com + [1]_com X + [0]_com X^2\n\n");
%!assert (disp (taylor (infsupdec([0; 0]), 2)), "   [0]_com + [1]_com X + [0]_com X^2\n   [0]_com + [1]_com X + [0]_com X^2\n\n");
%!assert (disp (taylor (infsupdec (zeros (1, 1, 1, 0)), 2)), "");
%!assert (disp (taylor (infsupdec(ones(2, 2, 2)), 2)), "ans(:,1,1) =\n\n   [1]_com + [1]_com X + [0]_com X^2\n   [1]_com + [1]_com X + [0]_com X^2\n\nans(:,2,1) =\n\n   [1]_com + [1]_com X + [0]_com X^2\n   [1]_com + [1]_com X + [0]_com X^2\n\nans(:,1,2) =\n\n   [1]_com + [1]_com X + [0]_com X^2\n   [1]_com + [1]_com X + [0]_com X^2\n\nans(:,2,2) =\n\n   [1]_com + [1]_com X + [0]_com X^2\n   [1]_com + [1]_com X + [0]_com X^2\n\n")
%!test
%! x = taylor (infsupdec (reshape (1:24, 2, 3, 4)), 2);
%! x(1, 1, 2) = taylor (entire (), 2);
%! x(1, 1, 3) = taylor (empty (), 2);
%! x(1, 1, 4) = taylor (nai (), 2);
%! assert (disp (x(1,1,:)), "ans(:,1,1) = [1]_com + [1]_com X + [0]_com X^2\nans(:,1,2) = [Entire]_dac + [1]_com X + [0]_com X^2\nans(:,1,3) = [Empty]_trv + [1]_com X + [0]_com X^2\nans(:,1,4) = [NaI] + [1]_com X + [0]_com X^2\n")
