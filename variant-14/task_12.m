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
## @deftypefn {} {@var{retval} =} task_12 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-16

%Задание №12.
%14)
%Описать и реализовать алгоритм разложения матрицы SVD
%Реализовать вручную и сравнить со встроенным разложением, по времени работы на больших и маленьких матрицах.

function task_12 
    disp('Матрица A:');
    A = [4, 3, 2; 2, 1, 4; 6, 2, 3]

    [U, S, V] = svd_decompose(A);
    disp('Матрица U:');
    U
    disp('Матрица S:');
    S
    disp('Матрица V:');
    V

    U * S * V'

    compare

endfunction

function compare_2 
    n_values = [10, 100, 500, 1000];
    manual_times = [];
    builtin_times = [];

    for n = n_values
        A = rand(n, 10); 

        
        tic;
        [U, S, V] = svd_decompose(A);
        manual_times(end+1) = toc;

        
        tic;
        [U_builtin, S_builtin, V_builtin] = svd(A);
        builtin_times(end+1) = toc;
    end

    
    fprintf('Размер матрицы | Ручное SVD (с) | Встроенное SVD (с)\n');
    fprintf('---------------|----------------|------------------\n');
    for i = 1:length(n_values)
        fprintf('%14d | %14.6f | %14.6f\n', n_values(i), manual_times(i), builtin_times(i));
    end

    
    figure;
    plot(n_values, manual_times, '-o', 'LineWidth', 2);
    hold on;
    plot(n_values, builtin_times, '-x', 'LineWidth', 2);
    grid on;
    legend('Ручное SVD', 'Встроенное SVD');
    xlabel('Размер матрицы');
    ylabel('Время (с)');
    title('Сравнение времени работы SVD-разложения');

endfunction
function compare 
    n_values = [10, 100, 500, 1000];
    manual_times = [];
    builtin_times = [];

    for n = n_values
        A = rand(n, n); 

        
        tic;
        [U, S, V] = svd_decompose(A);
        manual_times(end+1) = toc;

        
        tic;
        [U_builtin, S_builtin, V_builtin] = svd(A);
        builtin_times(end+1) = toc;
    end

    
    fprintf('Размер матрицы | Ручное SVD (с) | Встроенное SVD (с)\n');
    fprintf('---------------|----------------|------------------\n');
    for i = 1:length(n_values)
        fprintf('%14d | %14.6f | %14.6f\n', n_values(i), manual_times(i), builtin_times(i));
    end

    
    figure;
    plot(n_values, manual_times, '-o', 'LineWidth', 2);
    hold on;
    plot(n_values, builtin_times, '-x', 'LineWidth', 2);
    grid on;
    legend('Ручное SVD', 'Встроенное SVD');
    xlabel('Размер матрицы');
    ylabel('Время (с)');
    title('Сравнение времени работы SVD-разложения');

endfunction

function [U, S, V] = svd_decompose(A)
    % Вычисление собственных значений и векторов для A' * A
    [V, D] = eig(A' * A);
    [sigma, idx] = sort(sqrt(diag(D)), 'descend');
    V = V(:, idx); % Сортируем собственные вектора

    % Вычисление матрицы U
    U = zeros(size(A, 1), size(A, 1));
    for i = 1:length(sigma)
        if sigma(i) > 1e-10 
            U(:, i) = A * V(:, i) / sigma(i);
        end
    end

    % Формирование диагональной матрицы S
    S = diag(sigma);
    if size(A, 1) > size(A, 2)
        S = [S; zeros(size(A, 1) - size(A, 2), size(A, 2))];
    elseif size(A, 2) > size(A, 1)
        S = [S, zeros(size(A, 1), size(A, 2) - size(A, 1))];
    end
end
