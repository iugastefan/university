function lab2_3()
f = @(x) x.^3 - 18*x - 10;
X = linspace(-5,5,1000);
Y = f(X);

plot(X,Y);
eps = 10^-5;
syms x
f = x.^3 - 18*x - 10;
[x1] = MetSecantei(f,-5,5,-5,-3,eps);
[x2] = MetSecantei(f,-5,5,-1,0,eps);
[x3] = MetSecantei(f,-5,5,4,5,eps);
[x4] = MetPozFalse(f,-5,-3,eps);
[x5] = MetPozFalse(f,-1,0,eps);
[x6] = MetPozFalse(f,4,5,eps);
hold on
grid on
f = @(x) x.^3 - 18*x - 10;
plot(x1,f(x1),'o','MarkerSize',10)
plot(x2,f(x2),'o','MarkerSize',10)
plot(x3,f(x3),'o','MarkerSize',10)
plot(x4,f(x4),'o','MarkerSize',10)
plot(x5,f(x5),'o','MarkerSize',10)
plot(x6,f(x6),'o','MarkerSize',10)
hold off
end