function [xaprox] = MetSecantei(f,A,B,x0,x1,eps)
syms x
a(1) = x0; a(2) = x1;
k=2;
while abs(a(k)-a(k-1))/abs(a(k-1))<eps
    k=k+1;
    a(k) = (a(k-2)*subs(f,x,a(k-1))-a(k-1)*subs(f,x,a(k-2)))/(subs(f,x,a(k-1))-subs(f,x,a(k-2)));
    if a(k) <A || a(k)>B
        disp('Introduceti alte valori pentru x0 si x1');
        break
    end
    
end
xaprox=a(k);
end