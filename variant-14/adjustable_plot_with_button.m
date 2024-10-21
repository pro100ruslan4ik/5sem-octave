function adjustable_plot_with_button()
    % Создаем фигуру и оси
    f = figure('Position', [100, 100, 600, 400]);
    ax = axes('Parent', f, 'Position', [0.1, 0.3, 0.85, 0.65]);

    % Инициализация диапазона по умолчанию
    minX = -10;
    maxX = 10;

    % Построение графика с начальными значениями диапазона
    plot_graph(minX, maxX, ax);

    % Текстовое поле для минимального значения X
    uicontrol('Style', 'text', 'Position', [100, 60, 100, 20], 'String', 'Min X');
    min_edit = uicontrol('Style', 'edit', 'Position', [100, 40, 100, 20], ...
        'String', num2str(minX));

    % Текстовое поле для максимального значения X
    uicontrol('Style', 'text', 'Position', [400, 60, 100, 20], 'String', 'Max X');
    max_edit = uicontrol('Style', 'edit', 'Position', [400, 40, 100, 20], ...
        'String', num2str(maxX));

    % Кнопка для обновления графика
    uicontrol('Style', 'pushbutton', 'String', 'Обновить график', ...
        'Position', [250, 20, 100, 30], ...
        'Callback', @(src, event) update_plot(min_edit, max_edit, ax));
end

function update_plot(min_edit, max_edit, ax)
    % Получение новых значений из текстовых полей
    minX = str2double(get(min_edit, 'String'));
    maxX = str2double(get(max_edit, 'String'));

    % Проверка корректности введенных значений
    if isnan(minX) || isnan(maxX) || minX >= maxX
        errordlg('Введите корректные числовые значения для диапазона X. Min X должно быть меньше Max X.');
        return;
    end

    % Очистка оси перед новым построением
    cla(ax);

    % Обновление графика
    plot_graph(minX, maxX, ax);
end

function plot_graph(minX, maxX, ax)
    % Диапазон значений X
    x = minX:0.01:maxX;

    % Проверка, что диапазон корректен
    if isempty(x)
        return;
    end

    % Разделяем диапазоны x <= 0 и x > 0
    x_neg = x(x <= 0);
    x_pos = x(x > 0);

    % Вычисление значений Y для каждого диапазона
    y_neg = 3*x_neg + sqrt(1 + x_neg.^2);  % Первое уравнение для x <= 0
    y_pos = 2*cos(x_pos) .* exp(-2*x_pos);  % Второе уравнение для x > 0

    % Построение графика для x <= 0
    if ~isempty(x_neg)
        plot(ax, x_neg, y_neg, 'b', 'LineWidth', 2);
        hold(ax, 'on');  % Сохраняем текущий график
    end

    % Построение графика для x > 0, начиная с 0
    if ~isempty(x_pos)
        plot(ax, [0 x_pos], [0 y_pos], 'r', 'LineWidth', 2);
        plot(ax, 0, 2*cos(0) * exp(-2*0), 'ro', 'MarkerFaceColor', 'w', 'MarkerSize', 10); % Выколотая точка
    end

    % Разрыв между графиками
    if ~isempty(x_neg) && ~isempty(x_pos)
        plot(ax, [x_neg(end), x_pos(1)], [y_neg(end), NaN], 'w'); % Показ разрыва
    end

    title(ax, sprintf('График функции для диапазона [%0.2f, %0.2f]', minX, maxX));
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');
    hold(ax, 'off');  % Освобождаем график
end

