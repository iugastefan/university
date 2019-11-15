function [x] = GPP(A, b)

    n = length(b);
    A = [A b];
    
    for k = 1 : n - 1
        [~, p] = max(A(k:n, k));
        if isempty(p)
            return;
        else
            p = p + k - 1;
        end
        
        if A(p, k) == 0
            fprintf("Sis incomp sau comp nedet");
            return;
        end
        
        if p ~= k
            A([p, k], :) = A([k, p], :);
        end
        
        for l = k + 1 : n
            mlk = A(l, k)/A(k, k);
            A(l, :) = A(l, :) - mlk * A(k, :);
        end
    end
    
    if A(n, n) == 0
        fprintf("Sist incomp sau comp nedet");
        return;
    end
    
    x = SubsDesc(A(:, 1:n), A(:, n + 1));
end

