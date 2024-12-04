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
## @deftypefn {} {@var{retval} =} task_10 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-11-26

%Задание №10.
%Для заданной системы линейных уравнений Ax = b
%1. Решить систему с помощью средств встроенных в Matlab (численно и символьно).
%2. Написать функцию, реализующую метод Крамера для произвольной системы уравнений.
% С помощью нее решить заданную систему и сравнить полученный результат с результатом из п. 1.
%3. Найти собственные значения, собственный векторы и ранг матрицы A.

%№14
%   2.988 x1 + 0.209 x2 + 0.315 x3 + 0.281 x4 = 0.108
%   0.163 x1 + 3.237 x2 + 0.226 x3 + 0.307 x4 = 0.426
%   0.416 x1 + 0.175 x2 + 3.239 x3 + 0.159 x4 = 0.310
%   0.287 x1 + 0.196 x2 + 0.325 x3 + 4.062 x4 = 0.084


function task_10 
    pkg load symbolic;

    A = [2.988, 0.209, 0.315, 0.281; 
         0.163, 3.237, 0.226, 0.307; 
         0.416, 0.175, 3.239, 0.159; 
         0.287, 0.196, 0.325, 4.062];

    b = [0.108; 0.426; 0.310; 0.084];

    An = A
    bn = b

    Aug = [A b];

    rank_A = rank(A)        
    rank_Aug = rank(Aug)    
    printf('\n');

    if rank_A < rank_Aug
        error('Система несовместна');
    end

    x_numeric = A \ b;


    As = vpa(A);

    bs = vpa(b);

    syms x1 x2 x3 x4
    X = [x1; x2; x3; x4];
    eqns = As * X == bs;
    x_symbolic = solve(eqns, [x1, x2, x3, x4]);
    x_symbolic = [x_symbolic.x1; x_symbolic.x2; x_symbolic.x3; x_symbolic.x4];


    disp('Численное решение:');
    disp(x_numeric);
    printf('\n');

    disp('Символьное решение:');
    disp(x_symbolic);
    printf('\n');

    x_cramer = cramer_method(A, b)

    disp('Разница с численным решением:');
    disp(x_numeric - x_cramer);
    printf('\n');

    disp('Разница с символьным решением:');
    disp(double(x_symbolic) - x_cramer);
    printf('\n');

    [eigenvectors, eigenvalues_matrix] = eig(A);

    eigenvalues = diag(eigenvalues_matrix)
    eigenvectors

    cramer_method([1 2; 1 2], [3; 4]);

endfunction

function x = cramer_method(A, b)
    Aug = [A b];

    rank_A = rank(A);        
    rank_Aug = rank(Aug);    
    printf('\n');

    if rank_A < rank_Aug
        disp('Решения нет, система несовместна');
        return;
    end
    n = size(A, 1); 
    det_A = det(A); 
    if det_A == 0
        disp('Определитель матрицы A равен нулю, система не имеет уникального решения');
        return;
    end
    x = zeros(n, 1); 
    for i = 1:n
        A_temp = A; 
        A_temp(:, i) = b; 
        x(i) = det(A_temp) / det_A; 
    end
end


