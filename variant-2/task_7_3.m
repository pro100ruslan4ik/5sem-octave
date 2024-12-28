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
## Created: 2024-12-28


function task_7_3 
    printf("Тройной интеграл\n");
    s = symbolic_integration();
    n = numeric_integration();

    plot_integration_volume();

    printf('Тройной интеграл символьными вычислениями: %.8f\n', s);
    printf('Тройной интеграл численными вычислениями:  %.8f\n', n);
    printf('Разница: %.25f\n\n', s-n);
    printf('\n\n\n');
endfunction

function value_of_integral = symbolic_integration
    pkg load symbolic

    syms x y z 
    syms rho theta
    syms pi

    f_cartesian = (x^2 + y^2 + z^2)

    x_cylindrical = x;
    y_cylindrical = rho * cos(theta);
    z_cylindrical = rho * sin(theta);
    
    J = jacobian([x_cylindrical, y_cylindrical, z_cylindrical], [rho, theta, x]);
    J_det = simplify(det(J))

    f_cylindrical = subs(f_cartesian, {x, y, z}, {x_cylindrical, y_cylindrical, z_cylindrical}) * J_det;

    inner_rho = int(f_cylindrical, rho, 0, 2);
    middle_theta = int(inner_rho, theta, 0, 2*pi);
    integral = int(middle_theta, x, 0, 2)
    value_of_integral = double(integral);

%    inner = int(f, x, 0, 2);
%    middle = int(inner, y, -sqrt(4-z^2), sqrt(4-z^2));
%    integral = int(middle, z, -2, 2);
%    value_of_integral = double(integral);

endfunction



function value_of_integral = numeric_integration()
    f = @(x, r, theta) (x.^2 + r.^2) .* r;

    value_of_integral = integral3(@(x, r, theta) f(x, r, theta), 0, 2, 0, 2, 0, 2*pi);

%    integrand_r = @(r, x, theta) f(x, r, theta);
%
%    int_theta = @(x, r) quad(@(theta) integrand_r(r, x, theta), 0, 2 * pi);
%
%    int_r = @(x) quad(@(r) int_theta(x, r), 0, 2);
%
%    value_of_integral = quad(@(x) int_r(x), 0, 2);

endfunction



function plot_integration_volume
    radius = 2;
    height = 2;

    [Y,Z,X] = cylinder(radius, 100);
    X = X * height;

    figure;
    hold on;
    surf(X,Y,Z, 'FaceColor', 'b', 'EdgeColor', 'none');

    theta_circle = linspace(0, 2*pi, 100);
    y_circle = radius * cos(theta_circle);
    z_circle = radius * sin(theta_circle);
    x_0_circle = zeros(size(theta_circle)); 

    x_2_circle = 2 * ones(size(theta_circle)); 

    fill3(x_0_circle, y_circle, z_circle, 'b'); 
    fill3(x_2_circle, y_circle, z_circle, 'b'); 

endfunction
