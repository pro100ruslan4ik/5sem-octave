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
## @deftypefn {} {@var{retval} =} task_11 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-14

%Задание №11.
%14)
%Описать и реализовать алгоритм разложения матрицы LU
%Реализовать вручную и сравнить со встроенным разложением, по времени работы на больших и маленьких матрицах.


function task_11 
    disp('Матрица A:');
    A = [4, 3, 2; 2, 1, 4; 6, 2, 3]

    [L, U] = lu_second(A);
    disp('Матрица L:');
    L
    disp('Матрица U:');
    U
    L*U

    compare

endfunction



function compare 
    n_values = [10, 100, 500, 1000];
    manual_times = [];
    builtin_times = [];

    for n = n_values
        A = rand(n, n); 

        
        tic;
        [L, U, P] = lu_decompose(A);
        %[L, U] = lu_second(A);
        manual_times(end+1) = toc;

        
        tic;
        [L_builtin, U_builtin, P_builtin] = lu(A);
        builtin_times(end+1) = toc;
    end

    
    fprintf('Размер матрицы | Ручное LU (с)  | Встроенное LU (с)\n');
    fprintf('---------------|----------------|-----------------\n');
    for i = 1:length(n_values)
        fprintf('%14d | %14.6f | %14.6f\n', n_values(i), manual_times(i), builtin_times(i));
    end

    
    figure;
    plot(n_values, manual_times, '-o', 'LineWidth', 2);
    hold on;
    plot(n_values, builtin_times, '-x', 'LineWidth', 2);
    grid on;
    legend('Ручное LU', 'Встроенное LU');
    xlabel('Размер матрицы');
    ylabel('Время (с)');
    title('Сравнение времени работы LU-разложения');

endfunction

function [L, U, P] = lu_decompose(A)
    [n, m] = size(A);
    if n ~= m
        error('Матрица должна быть квадратной');
    end

    P = eye(n); 
    L = eye(n); 
    U = A;      

    for i = 1:n-1
        
        [~, pivot] = max(abs(U(i:n, i)));
        pivot = pivot + i - 1;

        
        if pivot ~= i
            U([i, pivot], :) = U([pivot, i], :);
            P([i, pivot], :) = P([pivot, i], :);
            if i > 1
                L([i, pivot], 1:i-1) = L([pivot, i], 1:i-1);
            end
        end

        
        for j = i+1:n
            L(j, i) = U(j, i) / U(i, i);
            U(j, i:n) = U(j, i:n) - L(j, i) * U(i, i:n);
        end
    end

endfunction

function [L, U] = lu_second(A)
    [n, m] = size(A);

    if n ~= m
        error('Матрица должна быть квадратной');
    end

    L = eye(n); 
    U = zeros(n);      

    for i = 1:n
        for j = 1:n
            if i <= j
                U(i,j) = A(i,j) - sum(L(i, 1:i-1) .* U(1:i-1, j)');
            else
                L(i,j) = (A(i,j) - sum(L(i, 1:j-1) .* U(1:j-1, j)')) / U(j,j);
            endif
        endfor
    endfor

endfunction
