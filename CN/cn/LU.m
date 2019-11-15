function [L, U, w] = LU(A)

    n = length(A);
    
    L = eye(n);
    w = 1:n;
    
    for k = 1 : n - 1
        [val, p] = max(A(k:n, k));
        p = p + k - 1;
        
        if A(p, k) == 0
            fprintf("A nu admite factorizarea LU");
            return;
        end
        
        if p ~= k
            A([p, k], :) = A([k, p], :);
            w([p, k]) = w([k, p]);
            
            if k > 1
                L([p k], 1:k-1) = L([k p], 1:k-1);
            end
        end
        
        for l = k + 1:n
            L(l, k) = A(l, k)/A(k, k);
            A(l, :) = A(l, :) - L(l, k) * A(k, :);
        end
        
        if A(n, n) == 0
            fprintf("A nu admite factorizarea LU");
            return;
        end
        
        U = A;

end

