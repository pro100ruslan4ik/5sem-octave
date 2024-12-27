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
## @deftypefn {} {@var{retval} =} task_4_1 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-23

function task_4_1 
    printf("Первый способ\n");

    f = figure('Position', [100, 100, 600, 400]);
    ax = axes('Parent', f, 'Position', [0.1, 0.3, 0.85, 0.65]);

    minX = -10;
    maxX = 10;

    plot_graph(minX, maxX, ax);

    uicontrol('Style', 'text', 'Position', [100, 60, 100, 20], 'String', 'Min X');
    min_edit = uicontrol('Style', 'edit', 'Position', [100, 40, 100, 20], ...
        'String', num2str(minX));

    uicontrol('Style', 'text', 'Position', [400, 60, 100, 20], 'String', 'Max X');
    max_edit = uicontrol('Style', 'edit', 'Position', [400, 40, 100, 20], ...
        'String', num2str(maxX));

    uicontrol('Style', 'pushbutton', 'String', 'Отобразить', ...
        'Position', [250, 20, 100, 30], ...
        'Callback', @(src, event) update_plot(min_edit, max_edit, ax));
end


function update_plot(min_edit, max_edit, ax)

    minX = str2double(get(min_edit, 'String'));
    maxX = str2double(get(max_edit, 'String'));

    if isnan(minX) || isnan(maxX) || minX >= maxX
        errordlg('Введите корректные числовые значения для диапазона X. Min X должно быть меньше Max X.');
        return;
    end

    cla(ax);
    plot_graph(minX, maxX, ax);
end


function plot_graph(minX, maxX, ax)

    x = minX:0.01:maxX;

    if isempty(x)
        return;
    end

    x_neg = x(x <= 0);
    x_pos = x(x >= 0);

    for i = 1:length(x_neg)
        y_neg(i) = 3*sin(x_neg(i)) - cos(x_neg(i))^2;
    end

    for i = 1:length(x_pos)
        y_pos(i) = 3 * sqrt(1+x_pos(i)^2) / log(x_pos(i) + 5);
    end

    hold(ax, 'on');

    if ~isempty(x_neg)
        plot(ax,0,3*sin(0) - cos(0)^2, 'g', 'MarkerFaceColor', 'w','MarkerSize', 30);
        plot(ax,x_neg, y_neg,'g', 'LineWidth', 2);

    end

    if ~isempty(x_pos)
        plot(ax, x_pos, y_pos, 'g', 'LineWidth', 2);
        plot(ax, 0, 3*sqrt(1 + 0^2) / log(0 + 5), 'go', 'MarkerFaceColor', 'w', 'MarkerSize', 10);
    end


    title(ax, sprintf('График функции для диапазона [%0.2f, %0.2f]', minX, maxX));
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');
    hold(ax, 'off');
end
