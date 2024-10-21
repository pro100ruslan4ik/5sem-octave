function adjustable_plot()
    % Создаем фигуру и оси
    f = figure('Position', [100, 100, 600, 400]);
    ax = axes('Parent', f, 'Position', [0.1, 0.3, 0.85, 0.65]);

    % Инициализация диапазона по умолчанию
    minX = -10;
    maxX = 10;

    % Построение графика с начальными значениями диапазона
    plot_graph(minX, maxX, ax);

    % Ползунок для минимального значения X
    uicontrol('Style', 'text', 'Position', [100, 40, 100, 20], 'String', 'Min X');
    min_slider = uicontrol('Style', 'slider', 'Min', -20, 'Max', 0, 'Value', minX, ...
        'Position', [100, 20, 100, 20], 'Callback', @(src, event) update_plot(src, max_slider, ax));

    % Ползунок для максимального значения X
    uicontrol('Style', 'text', 'Position', [400, 40, 100, 20], 'String', 'Max X');
    max_slider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 20, 'Value', maxX, ...
        'Position', [400, 20, 100, 20], 'Callback', @(src, event) update_plot(min_slider, src, ax));
end

function update_plot(min_slider, max_slider, ax)
    % Получение новых значений с ползунков
    minX = get(min_slider, 'Value');
    maxX = get(max_slider, 'Value');

    % Обновление графика
    plot_graph(minX, maxX, ax);
end

function plot_graph(minX, maxX, ax)
    % Диапазон значений X
    x = minX:0.01:maxX;

    % Вычисление значений Y в зависимости от X
    y = zeros(size(x));
    y(x <= 0) = 3*x(x <= 0) + sqrt(1 + x(x <= 0).^2);  % Первое уравнение
    y(x > 0) = 2*cos(x(x > 0)) .* exp(-2*x(x > 0));     % Второе уравнение

    % Построение графика
    plot(ax, x, y, 'LineWidth', 2);
    title(ax, sprintf('График функции для диапазона [%0.2f, %0.2f]', minX, maxX));
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');
end

