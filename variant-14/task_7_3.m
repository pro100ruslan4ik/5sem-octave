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
## @deftypefn {} {@var{retval} =} task_7_3 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-11-12

%Пункт 6. Вычислить тройной интеграл. Построить область интегрирования. 

%f(x,y,z) = (x^2 + y^2 + z^2)^3 
%Q - нижняя половина шара x^2 + y^2 + z^2 ≤ 1

function task_7_3 
    s = symbolic_integration();
    n = numeric_integration();

    plot_integration_volume();

    printf('Тройной интеграл символьными вычислениями: %.8f\n', s);
    printf('Тройной интеграл численными вычислениями:  %.8f\n', n);
    printf('Разница: %.45f\n\n', s-n);
    printf('####################################################################\n');
endfunction

function value_of_integral = symbolic_integration
    pkg load symbolic
    
    syms x y z rho theta phi pi
    f_cartesian = (x^2 + y^2 + z^2 + 1)^3;

    x_spherical = rho * sin(theta) * cos(phi);
    y_spherical = rho * sin(theta) * sin(phi);
    z_spherical = rho * cos(theta);
    
    J = jacobian([x_spherical, y_spherical, z_spherical], [rho, theta, phi]);
    J_det = det(J);

    f_spherical = subs(f_cartesian, {x, y, z}, {x_spherical, y_spherical, z_spherical}) * J_det;

    inner_rho = int(f_spherical, rho, 0, 1);
    middle_theta = int(inner_rho, theta, pi/2, pi);
    integral = int(middle_theta, phi, 0, 2*pi)
    value_of_integral = double(integral);

endfunction


function value_of_integral = numeric_integration
    f = @(rho, theta, phi) (rho.^2 .* (sin(theta).^2) + rho.^2 .* (cos(theta).^2) + 1).^3 .* rho.^2 .* sin(theta);

    value_of_integral = integral3(@(rho, theta, phi) f(rho, theta, phi), 0, 1, pi/2, pi, 0, 2*pi);
endfunction


function plot_integration_volume

    [phi, theta] = meshgrid(linspace(0, 2*pi, 100), linspace(pi/2, pi, 100));
    
    rho = 1;  
    x = rho * sin(theta) .* cos(phi);
    y = rho * sin(theta) .* sin(phi);
    z = rho * cos(theta);

    figure;
    surf(x, y, z, 'EdgeColor', 'none');
    hold on;
    
    theta_base = linspace(0, 2*pi, 100);
    x_base = cos(theta_base);
    y_base = sin(theta_base);
    z_base = zeros(size(x_base));  
    fill(x_base, y_base, 'y');  

    axis equal;
    title('Область интегрирования');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

endfunction
