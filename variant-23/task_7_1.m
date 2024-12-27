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
## @deftypefn {} {@var{retval} =} task_7_1 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-21

function task_7_1
    printf('\n\n\n');
    printf('Одиночный интеграл\n');
    s = symbolic_integration(0,1.8);
    n = numeric_integration(0,1.8);
    
    printf('Определенный интеграл символьными вычислениями: %.8f\n', s);
    printf('Определенный интеграл численными вычислениями:  %.8f\n', n);
    printf('Разница: %.25f\n\n', s-n);
    printf('\n');
    
endfunction

function definite_integral = symbolic_integration (a, b)
    pkg load symbolic

    a = vpa(a);
    b = vpa(b);
    
    syms x
    f = sqrt(1 + x^2)

    I = int(f,x)
    check = diff(I, x);
    check = simplify(check)

    definite_integral = double(int(f, x, a, b));

endfunction

function definite_integral = numeric_integration (a, b)
    f = @(x)  sqrt(1 + x.^2);

    definite_integral = integral(f, a, b, 'AbsTol', 1e-6);

endfunction
