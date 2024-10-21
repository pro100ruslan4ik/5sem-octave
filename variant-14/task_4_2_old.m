fprintf("Второй способ")

x = -10:0.01:10;

y = zeros(size(x));
y(x <= 0) = 3*x(x <= 0) + sqrt(1 + x(x <= 0).^2);
y(x > 0) = 2*cos(x(x > 0)) .* exp(-2*x(x > 0));

plot(x, y);
title('График функции y = f(x)');
xlabel('x');
ylabel('y');
grid on;

