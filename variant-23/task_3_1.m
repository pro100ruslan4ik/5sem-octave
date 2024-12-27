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
## @deftypefn {} {@var{retval} =} task_3_1 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-09

function task_3_1 

fid = fopen('task_3.txt', 'r');

numbers = fscanf(fid, '%f');

fprintf('\n1 part\n\nIndex\tValue\n');

for i = 1:length(numbers)
    fprintf('%d\t%.3f\n', i, numbers(i));
end

count = 0;

for i = 1:length(numbers)
    if numbers(i) == 3 || numbers(i) == 5
        count++;
    end
end
fprintf('\ncount = %d\n', count);

endfunction
