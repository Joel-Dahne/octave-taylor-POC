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
## @defop Method {@@taylor} subsref (@var{A}, @var{IDX})
## @defopx Operator {@@taylor} {@var{A}(@var{I})}
## @defopx Operator {@@taylor} {@var{A}(@var{I1}, @var{I2}, @var{...})}
## @defopx Operator {@@taylor} {@var{A}.@var{P}}
##
## Select property @var{P} or elements @var{I} from Taylor array @var{A}.
##
## The index @var{I} may be either @code{:} or an index array.
## @comment DO NOT SYNCHRONIZE DOCUMENTATION STRING
## The property @var{P} may correspond to any unary method of the interval's
## class, but usually is either @code{inf} or @code{sup}.
##
## @example
## @group
## x = infsup (magic (3), magic (3) + 1);
## x (1)
##   @result{} ans = [8, 9]
## x (:, 2)
##   @result{} ans = 3×1 interval vector
##       [1, 2]
##       [5, 6]
##      [9, 10]
## x.inf
##   @result{} ans =
##      8   1   6
##      3   5   7
##      4   9   2
## @end group
## @end example
## @seealso{@@taylor/subsasgn, @@taylor/end}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-21

function A = subsref (A, S)

  if (nargin ~= 2)
    print_usage ();
    return
  endif

  switch S(1).type
    case "()"
      S(1).subs = prepad (S(1).subs, length (S(1).subs) + 1, ":");
      A.coefs = subsref (A.coefs, S(1));
    case "{}"
      error ("Taylor expansions cannot be indexed with {}")
    case "."
      error ("Taylor expansions cannot be indexed with .")
    otherwise
      error ("invalid subscript type")
  endswitch

  if (numel (S) > 1)
    A = subsref (A, S(2 : end));
  endif
endfunction

%!test
%! x = taylor (magic (3), 3);
%! assert (isequal (x(1), taylor ([8; 1; 0; 0])));
%! assert (isequal (x(2), taylor ([3; 1; 0; 0])));
%! assert (isequal (x(3), taylor ([4; 1; 0; 0])));
%! assert (isequal (x(2, 2), taylor ([5; 1; 0; 0])));
