numbers_2 = dlmread('task-3.txt');

fprintf('\nИндекс\tЗначение 2 способ\n');

for i = 1:length(numbers_2)
    fprintf('%d\t%.3f\n', i, numbers_2(i));
end

non_zero_elements = numbers_2(numbers_2 ~= 0);
comp_2 = prod(non_zero_elements);
fprintf('\n%.8f', comp_2);

