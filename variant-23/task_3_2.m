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
## @deftypefn {} {@var{retval} =} task_3_2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-09

function task_3_2 

numbers_2 = dlmread('task_3.txt');

fprintf('\n2 part\n\nIndex\tValue\n');

for i = 1:length(numbers_2)
    fprintf('%d\t%.3f\n', i, numbers_2(i));
end

fprintf('\ncount = %d\n', length(numbers_2(numbers_2 == 3 | numbers_2 == 5)));

endfunction
