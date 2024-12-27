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
## Created: 2024-12-21

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
    f = y^2 * cos(x*y);

    inner_integral = int(f, y, x, sqrt(pi));

    integral = int(inner_integral, x, 0, sqrt(pi));
    integral = simplify(integral)

    printf("\n");
    value_of_integral = double(integral);

endfunction


function value_of_integral = numeric_integration
    f = @(x, y)  y.^2 .* cos(x .* y);

    value_of_integral = integral2(f, 0, sqrt(pi), @(x) x, sqrt(pi));

endfunction


function plot_integration_area()
  x = linspace(0, sqrt(pi), 100);
  y1 = x;
  y2 = sqrt(pi) * ones(1,100);
  fill([x, fliplr(x)], [y1, fliplr(y2)], 'y');
  xlabel('x');
  ylabel('y');
  title('Область интегрирования');
  axis equal;
  grid on;
end
