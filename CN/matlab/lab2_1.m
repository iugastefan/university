function lab2_1()
f = @(x) x.^3 - 7*x.^2 + 14*x - 6;
X=linspace(0,4,100);
Y = f(X);
plot(X,Y);
eps = 1e-3;
syms x
f = x^3 - 7*x^2 + 14*x - 6;
df = diff(f,x,1);
[xaprox1] = MetNR(f,df,0.5,eps);
[xaprox2] = MetNR(f,df,2.75,eps);
[xaprox3] = MetNR(f,df,3.72,eps);
grid on
hold on
xL = xlim;
yL= ylim;
line(xL,[0 0],'Color','k')
line([0 0],yL,'Color','k')
hold off
end