x = 0.48;
b = -0.31;
c = 1.72;
a = 2.01;
k = 3;

y = nthroot(abs(a * x^2 - b^3), 5) + log(k*x) - (exp(k*x) + c^2)/sin(k*x) - 10^(-3) * sqrt(2157)
fprintf('%.10f\n', y);
