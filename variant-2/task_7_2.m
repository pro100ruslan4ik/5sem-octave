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
## @deftypefn {} {@var{retval} =} task_7_2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-28

function task_7_2 
    printf("Двойной интеграл\n");
    s = symbolic_integration();
    n = numeric_integration();

    plot_integration_area

    printf('Двойной интеграл символьными вычислениями: %.8f\n', s);
    printf('Двойной интеграл численными вычислениями:  %.8f\n', n);
    printf('Разница: %.25f\n\n', s-n);
    printf('\n\n\n');

endfunction

function value_of_integral = symbolic_integration
    pkg load symbolic
    
    syms x y pi
    f = 12 * x^2 * y^2 + 16 * x^3 * y^3

    inner_integral = int(f, y, -sqrt(x), x^2);

    integral = int(inner_integral, x, 0, 1);
    integral = simplify(integral)
    printf("\n");
    value_of_integral = double(integral);

endfunction


function value_of_integral = numeric_integration
    f = @(x, y)  12 * x.^2 .* y.^2 + 16 * x.^3 .* y.^3;

    value_of_integral = integral2(f, 0, 1, @(x) -sqrt(x), @(x) x.^2);

endfunction


function plot_integration_area()
    figure;
    x = linspace(0, 1, 100);
    y1 = -sqrt(x);
    y2 = x.^2;
    fill([x, fliplr(x)], [y1, fliplr(y2)], 'cyan');
    xlabel('x');
    ylabel('y');
    title('Область интегрирования');
    axis equal;
    grid on;

endfunction

