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
## @defop Method {@@taylor} subsasgn (@var{A}, @var{IDX}, @var{RHS})
## @defopx Operator {@@taylor} {@var{A}(@var{SUBS}) = @var{RHS}}
##
## Perform the subscripted assignment operation according to the subscript
## specified by @var{IDX}.
##
## The subscript @var{IDX} is expected to be a structure array with fields
## @code{type} and @code{subs}.  Only valid value for @var{type} is
## @code{"()"}.  The @code{subs} field may be either @code{":"} or a cell array
## of index values.
## @seealso{@@taylor/subsref, @@taylor/end}
## @end defop

## Author: Joel Dahne
## Keywords: taylor
## Created: 2017-07-24

function A = subsasgn (A, S, B)

  if (nargin ~= 3)
    print_usage ();
    return
  endif
  if (not (isa (A, "taylor")) && not (isa (A, "taylor")))
    A = taylor (A, 1);
    B = taylor (B, 1);
  elseif (not (isa (A, "taylor")))
    A = taylor (A, order (B));
  elseif (not (isa (B, "taylor")))
    B = taylor (B, order (A));
  endif

  if (not (strcmp (S.type, "()")))
    error ("only subscripts with parenthesis allowed");
  endif
  if (not (order (A) == order (B)))
    error ("Taylor expansions of different order not allowed")
  endif

  S.subs = prepad (S.subs, columns (S.subs) + 1, ":");

  ## FIXME: Does not work for multiple assignments at a time
  A.coefs = subsasgn (A.coefs, S, B.coefs);
endfunction

%!test
%! A = taylor (infsupdec (magic (3)), 2, "const");
%! A(4, 4) = taylor (42, 2, "const");
%! assert (isequal (A, taylor (infsupdec ([magic(3),[0;0;0];0,0,0,42]), 2, "const")));
%!test
%! A = taylor (infsupdec ([1 2]), 2);
%! A(2) = taylor (3, 2);
%! assert (isequal (A, taylor (infsupdec ([1 3]), 2)));
%!error
%! A = taylor (infsupdec (1), 2);
%! A(2) = taylor (2, 3);
%!xtest
%! A = taylor (infsupdec (magic (3)), 4, "const");
%! A([1 2], 1) = taylor (42, 4, "const");
%! assert (isequal (A, taylor (infsupdec ([42, 1, 6; 42, 5, 7; 4, 9, 2]), 4, "const")));
