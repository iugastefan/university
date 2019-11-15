function [x] = GaussPivPart(A,b)
n = size(A,1);
A=[A b];
for k = 1: n-1
    indice = 0;
    max =0;
    for p = k:n
        if abs(A(p,k))>max
            max = abs(A(p,k));
            indice = p;
        end
    end
    if  max == 0
        disp('Sist inc sau nedet')
    end
    if indice ~= k
        L = A(indice,:);
        A(indice,:)=A(k,:);
        A(k,:) = L;
    end
    for l = k+1:n
        m(l,k) = A(l,k)/A(k,k);
        A(l,:)=A(l,:)-m(l,k)*A(k,:);
    end
end
if A(n,n) ==0
    disp('Sist inc sau nedet');
end
x=SubsDesc(A(1:n,1:n),A(1:n,n+1));
end