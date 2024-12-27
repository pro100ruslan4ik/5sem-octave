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
## @deftypefn {} {@var{retval} =} task_4_2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  <ruslan@archlinux>
## Created: 2024-12-09

function task_4_2()
  printf("Второй способ\n")

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
        errordlg('Введите корректные числовые значения');
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

    y_neg = (11 + x_neg.^2) ./ (1 + sqrt(abs(sin(x_neg))));
    y_pos= exp(-1 .* x_pos).*cos(3.*x_pos);

    hold(ax, 'on');

    if ~isempty(x_neg)
        plot(ax,0, (11 + 0.^2) / (1 + sqrt(abs(sin(0)))), 'b', 'MarkerFaceColor', 'w','MarkerSize', 30);
        plot(ax, x_neg, y_neg, 'b', 'LineWidth', 2);

    end

    if ~isempty(x_pos)
        plot(ax, 0,exp(-0)*cos(3*0) , 'bo', 'MarkerFaceColor', 'w', 'MarkerSize', 10);
        plot(ax, x_pos, y_pos, 'b', 'LineWidth', 2);
    end


    title(ax, sprintf('График функции для диапазона [%0.2f, %0.2f]', minX, maxX));
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');
    hold(ax, 'off');
end

