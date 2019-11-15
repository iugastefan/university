function [L, x] = Cho(A, b)

    n = length(b);
    
    alpha = A(1, 1);
    
    if alpha <= 0
        fprintf("A nu este pozitiv definita");
        return;
    end
    
    L(1,1) = sqrt(A(1, 1));
    
    for i = 2 : n
        L(i, 1) = A(i, 1)/L(1, 1);
    end
    
    for k = 2 : n
        alpha = A(k, k) - sumsqr(L(k, 1:k-1));
        
        if alpha <= 0
            fprintf("A nu este pozitiv definita");
            return;
        end
        
        L(k, k) = sqrt(alpha);
        
        for i = k + 1 : n
            s = L(i, 1:k-1) * L(k, 1:k-1);
            L(i, k) = (A(i, k) - s)/L(k,k);
        end
    end
    
    y = SubsAsc(L, b);
    x = SubsDesc(L', y);

end

