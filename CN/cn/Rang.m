function [rang] = Rang(A, tol)

    [m, n] = size(A);
    
    h = 1;
    k = 1;
    rang = 0;
    
    while h <= m && k <= n
        [maxVal, p] = max(A(h:m, k));
        
        p = p + h - 1;
        
        if maxVal < tol
            k = k + 1;
            continue;
        end
        
        if p ~= h
            A([p h], :) = A([h p], :);
        end
        
        for l = h + 1 : m
            mlk = A(l, k)/A(h, k);
            A(l,:) = A(l, :) - mlk*A(h, :);
        end
        
        h = h + 1;
        k = k + 1;
        rang = rang + 1;
    end

end

