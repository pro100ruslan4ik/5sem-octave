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
## @deftypefn {} {@var{retval} =} task_9 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-11-24

%Задание №9. 
%1. Постройте график заданной функции. (Проведите полное исследование функции с помощью средств Matlab).
%2. Разложите функцию в ряд Тейлора в окрестности точки x = 0.
%3. Найдите пределы lim f(x) x -> +oo, lim f(x) x -> -oo. (Если функция определена не на всей числовой
% прямой, то вычислите пределы (может быть односторонние) в точках на концах области определения)

% тейлор в х = 1; производная, нули, нули производной, вторая производная 
% через cos(2x) и +, -

%№14. 
% f(x) = 0.3 * (cos(x))^2 - ln x + 2

function task_9 
    pkg load symbolic;

    syms x

    f_sym = 3 * (1 + cos(2 * x)) / 20 - log(x) + 2;
    disp('Функция:');
    f_sym
    printf('\n');

    f = @(x) 3 * cos(x).^2 / 10 - log(x) + 2;
    disp('Нули функции:');
    f_zeros = func_zeros(f, [1 11]);
    print_zeros(f, f_zeros);
    printf('\n');

    df_sym = diff(f_sym, x);
    disp('Производная функции:');
    df_sym
    printf('\n');

    df = matlabFunction(df_sym);
    disp('Нули производной на отрезке [1 11] - экстремальные точки:');
    df_zeros = func_zeros(df, [1 11]);
    print_zeros(df, df_zeros);
    printf('\n');

    d2f_sym = diff(df_sym, x);
    disp('Вторая производная функции:');
    d2f_sym
    printf('\n');

    d2f = matlabFunction(d2f_sym);
    disp('Нули второй производной на отрезке [1 11] - точки перегиба:');
    d2f_zeros = func_zeros(d2f, [1 11]);
    print_zeros(d2f, d2f_zeros);
    printf('\n');
    
    order = 6;
    taylor_series = taylor(f_sym, x, 'ExpansionPoint', 1, 'Order', order + 1);
    printf('Ряд Тейлора функции в точке x = 1 порядка %d:\n', order);
    taylor_series
    printf('\n');

    limit_0 = limit(f_sym, x, 0, 'right');
    disp('Предел при x -> +0 :');
    disp(limit_0);
    printf('\n');

    limit_inf = limit(f_sym, x, inf);
    disp('Предел при x -> +∞ :');
    disp(limit_inf);
    printf('\n');

    nth_derivative_sym(6);

    function_graphic(df_zeros, d2f_zeros);

endfunction

function return_axes = function_graphic(df_zeros, d2f_zeros)

    f = figure('Position', [100, 100, 600, 400]);
    ax = axes('Parent', f, 'Position', [0.1, 0.3, 0.85, 0.65]);

    maxX = 100;
    maxY = 25;

    plot_graph(maxX, maxY, ax, df_zeros, d2f_zeros);

    uicontrol('Style', 'text', 'Position', [100, 60, 100, 20], 'String', 'Max X');
    max_x_edit = uicontrol('Style', 'edit', 'Position', [100, 40, 100, 20], ...
        'String', num2str(maxX));

    uicontrol('Style', 'text', 'Position', [400, 60, 100, 20], 'String', 'Max Y');
    max_y_edit = uicontrol('Style', 'edit', 'Position', [400, 40, 100, 20], ...
        'String', num2str(maxY));

    uicontrol('Style', 'pushbutton', 'String', 'Отобразить', ...
        'Position', [250, 20, 100, 30], ...
        'Callback', @(src, event) update_plot(max_x_edit, max_y_edit, ax, df_zeros, d2f_zeros));

    return_axes = ax;

endfunction

function update_plot(max_x_edit, max_y_edit, ax, df_zeros, d2f_zeros)

    maxX = str2double(get(max_x_edit, 'String'));
    maxY = str2double(get(max_y_edit, 'String'));

    if isnan(maxY) || isnan(maxX) || maxX < 11 || maxY < 3
        errordlg('Введите корректные числовые значения!');
        return;
    end

    cla(ax);
    plot_graph(maxX, maxY, ax, df_zeros, d2f_zeros);
endfunction


function plot_graph(maxX, maxY, ax, df_zeros, d2f_zeros)
    f = @(x) 0.3 * (cos(x)).^2 - log(x) + 2;

    X1 = 1:0.25:maxX+0.25;
    Y1 = f(X1);

    Y2 = f(1):0.5:maxY+0.5;
    X2 = arrayfun(@(y) fsolve(@(x) f(x) - y, 0.5), Y2);

    hold(ax, 'on');
    plot(ax, X1, Y1, 'b', 'LineWidth', 1.5);
    plot(ax, X2, Y2, 'b', 'LineWidth', 1.5);
    plot(ax, df_zeros, f(df_zeros), 'b*');
    plot(ax, d2f_zeros, f(d2f_zeros), 'r*');

    xlabel(ax, 'x');
    ylabel(ax, 'f(x)');
    title(ax, 'График функции f(x) = 0.3 * (cos(x))^2 - ln(x) + 2');
    grid(ax, 'on');

endfunction

function roots = func_zeros(func, range)
    x_range = linspace(range(1), range(2), 1000);
    roots = [];
    
    for i = 1:length(x_range) - 1
        if func(x_range(i)) * func(x_range(i + 1)) < 0
            try
                root = fzero(func, [x_range(i), x_range(i + 1)]);
                
                if isempty(roots) || all(abs(roots - root) > 1e-5)
                    roots(end + 1) = root;
                end
            catch
            end
        end
    end
endfunction

function print_zeros(func, roots)
    roots = sort(roots);
    
    output = "";
    
    x_left = roots(1) - 1e-3; 
    sign_left = func(x_left);
    if sign_left > 0
        output = strcat(output, "  +");
    else
        output = strcat(output, "  -");
    end
    
    for i = 1:length(roots)
        output = strcat(output, sprintf("  %.5f  ", roots(i))); 
        if i < length(roots)
            mid_point = (roots(i) + roots(i + 1)) / 2;
            sign_mid = func(mid_point);
            if sign_mid > 0
                output = strcat(output, "  +");
            else
                output = strcat(output, "  -");
            end
        end
    end
    
    x_right = roots(end) + 1e-3; 
    sign_right = func(x_right);
    if sign_right > 0
        output = strcat(output, "  +");
    else
        output = strcat(output, "  -");
    end
    
    disp(output);
endfunction

function df = nth_derivative(order)
    if order > 0 && mod(order,1) == 0 
        df =  @(x) 0.3 * 2^(order-1) * cos(2*x + pi * order / 2) + factorial(order - 1) / x^order * (-1)^order
    else
        disp('expect n >= 1');
    endif
endfunction

function df_sym = nth_derivative_sym(order)
    if order > 0 && mod(order,1) == 0
        syms x pi; 
        derivative = 3 * 2^(order-1) * cos(2*x + pi * order / 2) / 10 + factorial(order - 1) / x^order * (-1)^order
        df_sym = diff(derivative, x, order); 
    else
        disp('expect n >= 1');
    endif
endfunction
