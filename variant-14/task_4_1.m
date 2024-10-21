%3адание №4
%Создать 2 варианта сценария для построения, оформления и вывода графика:
%1. Один вариант должен использовать стандартный для обычных языков программирования подход с использованием операторов цикла и условных операторов для поэлементной обработки массивов.
%2. Другой вариант должен использовать операцию формирования диапазона значений и расширенные возможности операций и функций Matlab по групповой обработке массивов.
%3. Подобрать такие параметры вывода, которые позволяют лучше рассмотреть ход кривой графика

%y = 3x + sqrt(1+x^2) при x <= 0 и
%y = 2cosx * exp(-2x), при x > 0

function task_4_1()
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
        y_neg(i) = 3*x_neg(i) + sqrt(1 + x_neg(i)^2);
    end

    for i = 1:length(x_pos)
        y_pos(i)= 2*cos(x_pos(i)) * exp(-2*x_pos(i));
    end

    if ~isempty(x_neg)
        plot(ax, x_neg, y_neg, 'b', 'LineWidth', 2);
        hold(ax, 'on');
    end

    if ~isempty(x_pos)
        plot(ax, x_pos, y_pos, 'r', 'LineWidth', 2);
        plot(ax, 0, 2*cos(0) * exp(-2*0), 'ro', 'MarkerFaceColor', 'w', 'MarkerSize', 10);
    end


    title(ax, sprintf('График функции для диапазона [%0.2f, %0.2f]', minX, maxX));
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');
    hold(ax, 'off');
end

