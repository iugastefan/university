function [L,U, w] = LU(A)
n=size(A,1);
L = eye(n);
w = 1:n;
for k=1:n-1
    max = 0;
    p = 0;
    for j = k:n
        if abs(A(j,k))>max
            max = abs(A(j,k));
            p = j;
        end
    end
    if max == 0
        disp('A nu admite factorizare LU')
        return
    end
    if p~=k
        L = A(p,:);
        A(p,:)=A(k,:);
        A(k,:) = L;
        
        y = w(p);
        w(p)=w(k);
        w(k)=y;
        if k>1
            L = A(p,1:k-1);
            A(p,1:k-1)=A(k,1:k-1);
            A(k,1:k-1) = L;
        end
    end
    for l =k+1:n
        m1(l,k) = A(l,k)/A(k,k);
        A(l,:)=A(l,:)-m1(l,k)*A(k,:);
    end
end
if A(n,n) == 0
    disp('A nu admite factorizare LU')
    return
end
U=A;

%y=SubsAsc(L,A(:,n));
%x=SubsDesc(U,y);
end