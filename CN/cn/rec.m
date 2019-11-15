A = [0, 1, 2; 1, 0, 1; 3, 2, 1];
b = [8; 4; 10];


GFP(A, b);
GPP(A, b);
GPT(A, b);

%[L, U, w] = LU(A);
%[L, U, w] = lu(A, 'vector');

tol = 10^(-10);
B = [4, -1, 5, 0; 1, 0, -3, 0; 0, 0, 0, 1; 3, -1, 8, 0];
Rang(B, tol);

A = [4, 2, 2; 2, 10, 4; 2, 4, 6];
b = [12; 30; 10];

[L, x] = Cho(A, b);


A = [3 1 1; 1 3 1; 1 1 3];
MetJacobi(A, 10^(-4));
eigs(A);

f = @(x) x.^3 - 7.*x.^2 + 14.*x - 6;
interval = linspace(0, 4, 100);
eps = 10 ^ (-3);

syms arg
df = matlabFunction(diff(f(arg)));


[xaprox] = MetBis(f, 0, 1, eps);

[xaprox] = MetNR(f, df, 0.5, eps);
[xaprox2] = MetNR(f, df, 2.2, eps);
[xaprox3] = MetNR(f, df, 9.9, eps);

[xaprox] = MetSec(f, -5, 5, 3, 5, eps);
[xaprox2] = MetSec(f, -5, 5, -4, -3, eps);
[xaprox3] = MetSec(f, -5, 5, -1, 1, eps);

f = @(x) x.^3 - 18.*x - 10;
interval = linspace(-5, 5, 100);
eps = 10 ^ (-5);

plot(interval, f(interval));
hold on;

[xaprox] = MetPF(f, -5, 5, eps);
[xaprox2] = MetPF(f, 3, 5, eps);
[xaprox3] = MetPF(f, -1, 1, eps);

plot(xaprox, f(xaprox), '*');
plot(xaprox2, f(xaprox2), 'o');
plot(xaprox3, f(xaprox3), 'x');
hold off;
