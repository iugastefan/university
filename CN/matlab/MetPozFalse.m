function [xaprox] = MetPozFalse(f,A,B,eps)
syms x
a(1)=A;
b(1)=B;
k=1;
y(1)=(a(1)*subs(f,x,b(1))-b(1)*subs(f,x,a(1)))/(subs(f,x,b(1))-subs(f,x,a(1)));
cond = 1;
while cond==1
    k=k+1;
    if subs(f,x,y(k-1))==0
        y(k)=y(k-1);
        return
    elseif subs(f,x,a(k-1))*subs(f,x,y(k-1))< 0
        a(k)=a(k-1);
        b(k)=y(k-1);
        y(k)= (a(k)*subs(f,x,b(k))-b(k)*subs(f,x,a(k)))/(subs(f,x,b(k))-subs(f,x,a(k)));
    elseif subs(f,x,a(k-1))* subs(f,x,y(k-1))>0
        a(k)=y(k-1);
        b(k)=b(k-1);
        
        y(k)= (a(k)*subs(f,x,b(k))-b(k)*subs(f,x,a(k)))/(subs(f,x,b(k))-subs(f,x,a(k)));
    end
    if abs(y(k)-y(k-1))/abs(y(k-1))<eps
        cond = 0;
    end
end
xaprox = y(k);
end