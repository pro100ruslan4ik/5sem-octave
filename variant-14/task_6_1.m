%3адание №6
%1. Создать два варианта функции для решения задачи. В первом варианте предусмотреть передачу входной и выходной информации через
% глобальные переменные, а во втором - через формальные и фактические параметры.
%2. В командном окне задать исходные данные и вызвать функцию, передав ей входные и получив выходные значения.
%3. Использовав статическую переменную для подсчета количества вызовов каждой из функции и одну и ту же глобальную переменную для
% подсчета общего количества вызовов любой из двух функции. Вывести из функции имена вызываемых функции и значения этих переменных.

function task_6_1()
    global vector
    global count_global
    persistent count_1

    if isempty(count_global)
        count_global = 0;
    endif
    
    count_global++;

    if isempty(count_1)
        count_1 = 0;
    endif

    count_1++;
    
    printf("Всего вызовов двух функций: %d\nВызовов первой функции %d\n", count_global, count_1);
    
    vector = vector(vector < 0);
    vector = vector(end - min(length(vector) - 1, 4) : end)
    printf("task_6_1\n");
endfunction
