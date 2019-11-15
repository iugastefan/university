function lab2_2()
syms x
f = @(x) (x-1.5).^2.*(x-4);
df = diff(f,x,1);
mu = f/df;
simplify(mu);
dmu = diff(mu,x,1);
[xaprox] = MetNR(mu,dmu,1.4,10^(-5));
X=linspace(1,2,100);
y=f(X);
plot(X,y);
hold on
mu = @(x) (2.*x.^2 - 11.*x + 12)/(6.*x - 19);
z= mu(X);
plot(X,z);
plot(xaprox,mu(xaprox),'o','MarkerSize',10);
hold off
end
