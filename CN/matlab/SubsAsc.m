function [x] = SubsAsc(A,b)
x(1)=1/A(1,1)*b(1);
n = size(A,1);

for k=2:n
    suma =0;
    for j=1:k-1
        suma=suma+A(k,j)*x(j);
    end
    x(k) = 1/A(k,k)*(b(k)-suma);
end
end