function [x] = SubsDesc(A, b)

    n = length(b);
    x = zeros(n, 1);
    
    x(n) = b(n)/A(n, n);
    
    k = n - 1;
    
    while k > 0
        s = A(k, k + 1 : n) * x(k + 1 : n);
        x(k) = (b(k) - s)/A(k, k);
        
        k = k - 1;
    end

end

