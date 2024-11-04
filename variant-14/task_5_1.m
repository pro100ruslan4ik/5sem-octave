%Задание №5
%1. Создать текстовый файл, в котором содержится матрица чисел из произвольного числа строк и столбцов.
%2. Ввести матрицу из этого файла и вывести в другой файл построчно, предварительно напечатав строку: ИСХОДНАЯ МАТРИЦА:.
%3. Ввести в файл массив заново, предварительно напечатав строку: ПРЕОБРАЗОВАННАЯ МАТРИЦА:.
%4. Выполнить задачу, один вариант должен использовать стандартный для обычных языков программирования подход с использованием
% операторов цикла и условных операторов для поэлементной обработки массивов.
%5. Другой вариант должен использовать операцию формирования диапазона значений и расширенные возможности операций и функций
% в языке Matlab по групповой обработке массивов.

%№14. Минимальный элемент в каждом столбце матрицы заменить нулевым значением.

numbers = dlmread('task_5in.txt')

file_out = fopen('task_5_1out.txt', 'w');

fprintf(file_out, 'ИСХОДНАЯ МАТРИЦА:\n');
dlmwrite(file_out, numbers, '\t\t');

fprintf(file_out, '\n\n');
fprintf(file_out, 'ПРЕОБРАЗОВАННАЯ МАТРИЦА:\n');

numbers_size = size(numbers)
row_count = numbers_size(1)
column_count = numbers_size(2)

for k=1:row_count
    min_numbers(k) = numbers(1, k);
    for j=2:column_count
        if min_numbers(k) > numbers(j, k)
            min_numbers(k) = numbers(j, k);
        endif
    endfor
endfor

for k=1:row_count
    for j=1:column_count
        if numbers(j, k) == min_numbers(k)
            numbers(j, k) = 0;
        endif
    endfor
endfor

dlmwrite(file_out,numbers, '\t\t');
numbers
fclose(file_out);
