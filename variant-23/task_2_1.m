## Copyright (C) 2024
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} task_2_1 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-09

function task_2_1 


n = input("Какое n?\n")
x = input("Какое x?\n")

a_i = sqrt(2 * x / pi);
s = a_i;

for i=2:2:n
  multiplier = -1 * x * x * (2 * i + 1) / (i * (i-1) * (2*i + 5))  ;

  a_i = a_i * multiplier;
  s = s + a_i;

end
s

endfunction

