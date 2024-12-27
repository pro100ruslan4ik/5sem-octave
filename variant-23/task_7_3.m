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
## Created: 2024-12-21

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
    syms rho theta phi
    syms pi
    f_cartesian = 1 / sqrt((x^2 + y^2 + z^2 + 1)^3)

    x_spherical = rho * sin(theta) * cos(phi);
    y_spherical = rho * sin(theta) * sin(phi);
    z_spherical = rho * cos(theta);
    
    J = jacobian([x_spherical, y_spherical, z_spherical], [rho, theta, phi]);
    J_det = simplify(det(J))

    f_spherical = simplify(subs(f_cartesian, {x, y, z}, {x_spherical, y_spherical, z_spherical}) * J_det)

    inner_phi = int(f_spherical, phi, pi/2, 3*pi/2);
    middle_theta = int(inner_phi, theta, 0, pi);
    integral = int(middle_theta, rho, 0, 2);
    value_of_integral = double(integral);

endfunction


function value_of_integral = numeric_integration
    f = @(rho, theta, phi) 1 ./ (sqrt(rho.^2 + 1)).^3 .* rho.^2 .* sin(theta);

    integrate_phi = @(rho, theta) quadgk(@(phi) f(rho, theta, phi), pi/2, 3 * pi/2);
    integrate_theta = @(rho) quadgk(@(theta) integrate_phi(rho, theta), 0, pi);
    value_of_integral = quadgk(@(rho) integrate_theta(rho), 0, 2);
endfunction


function plot_integration_volume

    r = 2; 
    theta = linspace(0, 2*pi, 100); 
    phi = linspace(0, pi, 50); 

    [Theta, Phi] = meshgrid(theta, phi);


    X = r * sin(Phi) .* cos(Theta);
    Y = r * sin(Phi) .* sin(Theta);
    Z = r * cos(Phi);


    X(X > 0) = NaN;


    theta_circle = linspace(0, 2*pi, 100);
    y_circle = r * cos(theta_circle);
    z_circle = r * sin(theta_circle);
    x_circle = zeros(size(theta_circle)); 

    
    uniform_color = [0.2, 0.6, 0.8]; 

    
    figure;
    hold on;
    grid on;

   
    surf(X, Y, Z, 'FaceColor', uniform_color, 'EdgeColor', 'none'); 

  
    fill3(x_circle, y_circle, z_circle, uniform_color); 

    axis equal;
    xlabel('X'); 
    ylabel('Y');
    zlabel('Z');
    title('Левая половина шара x^2 + y^2 + z^2 <= 4');
    hold off;

endfunction
