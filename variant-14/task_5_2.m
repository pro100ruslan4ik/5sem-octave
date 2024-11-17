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

file_out = fopen('task_5_2out.txt', 'w');

fprintf(file_out, 'ИСХОДНАЯ МАТРИЦА:\n');
dlmwrite(file_out, numbers, '\t\t');

fprintf(file_out, '\n\n');

fprintf(file_out, 'ПРЕОБРАЗОВАННАЯ МАТРИЦА:\n');

numbers_size = size(numbers)
if numbers_size(1) == 1
    numbers(numbers == min(numbers,[],1)) = 0
else
    numbers(numbers == min(numbers)) = 0
endif
%if isvector(numbers)
%    numbers = zeros(1,numbers_size(2))
%else 
%    numbers(numbers == min(numbers)) = 0
%endif 

%if isvector(numbers)
%    if isrow(numbers)
%        numbers(numbers == min(reshape(numbers, 1, []))) = 0 
%    else
%        numbers(numbers == min(reshape(numbers, [], 1))) = 0
%    end
%else
%    numbers(numbers == min(numbers)) = 0
%endif

dlmwrite(file_out,numbers, '\t\t');
fclose(file_out);

