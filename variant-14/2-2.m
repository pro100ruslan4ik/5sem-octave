% степени через x * x, 1 способ задать количество членов ряда, второй - как в задании с точностью до 10^-5

x = input("Какое x?\n")
eps = input("Какая точность?\n")

% cos(x)^n / n!

cos_x = cos(x)

s = 1;
a_i = 1


while abs(a_i) >= eps

  a_i = a_i * cos_x / i
  s = s + a_i;


end
s
