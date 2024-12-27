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
## @deftypefn {} {@var{retval} =} task_6_1 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-21

function task_6_1 
    global array1
    global array2
    global matrix

    global count_global
    persistent count_1

    if isempty(count_global)
        count_global = 0;
    endif
    
    count_global++;

    if isempty(count_1)
        count_1 = 0;
    endif

    count_1++;
    
    disp(["\n\nВызвана функция: ", mfilename]);
    printf("Всего вызовов двух функций: %d\nВызовов первой функции: %d\n", count_global, count_1);
    

    if (length(array1) != length(array2))
        printf("Размерности массивов не совпадают\n");
        return
    endif

    if (!isvector(array1) || !isvector(array2))
        printf("array1 и array2 не объявлены или не являются векторами\n");
        return
    endif

    n = length(array1);
    
    matrix = repmat(array1, n, 1);
    
    for j = 1:n
        matrix(j, :) += array2(j);
    endfor

endfunction
