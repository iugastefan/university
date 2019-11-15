function [xaprox] = MetNR(f,df,val,eps)
syms x
k = 2;
a(1) = val;
a(2) = a(1)-subs(f,x,a(1))/subs(df,x,a(1));
while abs(a(k)-a(k-1))/abs(a(k-1))>eps
    k = k+1;
    a(k) = a(k-1) - subs(f,x,a(k-1))/subs(df,x,a(k-1));
end
xaprox = a(k);
end
