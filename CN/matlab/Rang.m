function [rang] = Rang(A,tol)
h = 1;
k = 1;
rang = 0;
n = size(A,2);
m = size(A,1);
while h<=m & k<=n
    max = 0;
    p = 0;
    for j = h:m
        if abs(A(j,k))>max
            max = abs(A(j,k));
            p = j;
        end
    end
    if max<tol
        k=k+1;
        continue;
    end
    if p~=h
        L = A(p,:);
        A(p,:)=A(h,:);
        A(h,:) = L;
    end
    for l=h+1:m
        m1(l,k) = A(l,k)/A(h,k);
        A(l,:)=A(l,:)-m1(l,k)*A(h,:);
    end
    h=h+1;
    k=k+1;
    rang=rang+1;
end
end