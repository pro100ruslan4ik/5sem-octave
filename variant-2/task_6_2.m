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
## @deftypefn {} {@var{retval} =} task_6_2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-28

function [summary, product] = task_6_2(array) 

    global count_global
    persistent count_2

    if isempty(count_global)
        count_global = 0;
    endif
    
    count_global++;

    if isempty(count_2)
        count_2 = 0;
    endif

    count_2++;
    
    disp(["\n\nВызвана функция: ", mfilename]);
    printf("Всего вызовов двух функций: %d\nВызовов второй функции: %d\n", count_global, count_2);
    

    last_zero_index = find(array == 0, 1, 'last');
    if isempty(last_zero_index)
        disp("Нет нулевых элементов")
        summary = sum(array);
        product = 0;
    else
    
        summary = sum(array(1:last_zero_index));
        product = prod(array(last_zero_index+1:end));
    endif
    
endfunction
