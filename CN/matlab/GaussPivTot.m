function [x] = GaussPivTot(A,b)
n= size(A,1);
A =[A b];
for i =1:n
    index(i) = i;
end
for k=1:n-1
    indicelinie = 0;
    indicecoloana = 0;
    max = 0;
    for p=k:n
        for m=k:n
            if abs(A(p,m)) >max
                max = abs(A(p,m));
                indicelinie=p;
                indicecoloana=m;
            end
        end
    end
    if max == 0
        disp('Sist inc sau nedet');
    end
    if indicelinie~=k
        L=A(indicelinie,:);
        A(indicelinie,:)=A(k,:);
        A(k,:)=L;
    end
    if indicecoloana ~= k
        C= A(:,indicecoloana);
        A(:,indicecoloana)=A(:,k);
        A(:,k)=C;
        aux = index(m);
        index(m)=index(k);
        index(k)=aux;
    end
    for l=k+1:n
        m(l,k) =A(l,k)/A(k,k);
        A(l,:)=A(l,:) - m(l,k)*A(k,:);
    end
end
if A(n,n) == 0
    disp('Sist inc sau nedet');
end
y = SubsDesc(A(1:n,1:n),A(1:n,n+1));
for i=1:n
    x(index(i))=y(i);
end
end