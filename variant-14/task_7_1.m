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
## @deftypefn {} {@var{retval} =} task_7 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-11-11

%Задание №7
%1. Найти значение неопределенного инеграла от заданной функции с помощью символьного интегрирования.
% Проверить найденный результат с помощью дифференцирования.
%2. Найти значение определенного интеграла от заданной функции с помощью символьного интегрирования.
%3. Найти значения определенного интеграла с помощью метода численного интегрирования на заданном 
% отрезке с точностью eps = 10^(-6)
%4. Сравнить полученные результаты.

%             -√x
%  f(x) =    ℯ

% В task_7_2.m и task_7_3.m
%5. Вычислить двойной интеграл. Построить область интегрирования. 
%6. Вычислить тройной интеграл. Построить область интегрирования. 

function task_7_1
    printf('####################################################################\n\n');
    s = symbolic_integration(1,4);
    n = numeric_integration(1,4);
    
    printf('Определенный интеграл символьными вычислениями: %.8f\n', s);
    printf('Определенный интеграл численными вычислениями:  %.8f\n', n);
    printf('Разница: %.45f\n\n', s-n);
    printf('####################################################################\n');
    
endfunction

function definite_integral = symbolic_integration (a, b)
    pkg load symbolic
    
    syms x
    f = e^(-sqrt(x))

    I = int(f,x)
    check = diff(I, x)

    definite_integral = double(int(f, x, a, b));

endfunction

function definite_integral = numeric_integration (a, b)
    f = @(x)  exp(-sqrt(x));

    definite_integral = integral(f, a, b, 'AbsTol', 1e-6);

endfunction
