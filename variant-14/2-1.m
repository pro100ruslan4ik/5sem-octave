% степени через x * x, 1 способ задать количество членов ряда, второй - как в задании с точностью до 10^-5

n = input("Какое n?\n")
x = input("Какое x?\n")

% cos(x)^n / n!

cos_x = cos(x)

s = 1;
a_i = 1

for i=1:n
  a_i = a_i * cos_x / i
  s = s + a_i;

end
s
