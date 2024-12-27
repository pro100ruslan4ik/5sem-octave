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
## @deftypefn {} {@var{retval} =} task_8 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-22

function task_8 

    x_start = 0;      
    x_end = 2;  

    y0 = 0;    
    y1 = 0;   


    f = @(x, y) [y(2); y(1) + 2 .* exp(x) - x.^2];
    options = odeset('RelTol', 1e-20);
    [t_num, y_num] = ode23(f, [x_start, x_end], [y0, y1], options);


    pkg load symbolic;  
    syms y(x)
    Dy = diff(y, x);    
    D2y = diff(y, x, 2); 


    ode = D2y - y == 2 * exp(x) - x^2;


    conds = [y(0) == y0, subs(Dy, x, 0) == y1];
    y_sym = dsolve(ode, conds);


    hold on;
    fplot(matlabFunction(y_sym), [x_start, x_end], 'r-', 'LineWidth', 1.5); 
    plot(t_num, y_num(:, 1), 'b--', 'LineWidth', 1.5);
    legend('Символьное решение', 'Численное решение');
    xlabel('x');
    ylabel('y');
    title('Сравнение решений задачи Коши');
    grid on;

endfunction
