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
## @deftypefn {} {@var{retval} =} task_5_2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-20

function task_5_2 
    numbers = dlmread('task_5in.txt')

    file_out = fopen('task_5_2out.txt', 'w');

    fprintf(file_out, 'ИСХОДНАЯ МАТРИЦА:\n');
    dlmwrite(file_out, numbers, '\t\t');

    fprintf(file_out, '\n\n');
    fprintf(file_out, 'ПРЕОБРАЗОВАННАЯ МАТРИЦА:\n');

    first_column = prod(numbers(:, 1:2:end), 2);
    numbers(:, 1) = first_column

endfunction
