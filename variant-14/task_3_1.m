fid = fopen('task_3in.txt', 'r');

numbers = fscanf(fid, '%f');

fprintf('\nИндекс\tЗначение 1 способ\n');

for i = 1:length(numbers)
    fprintf('%d\t%.3f\n', i, numbers(i));
end

comp = 1;

for i = 1:length(numbers)
    if numbers(i) != 0
        comp = comp * numbers(i);
    end
end
fprintf('\n%.8f', comp);
