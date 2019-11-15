function [x] = GFP(A, b)

    n = length(b);
    A = [A b];
    
    for k = 1 : n - 1
        p = find(A(k:n, k), 1, 'first');
        
        if isempty(p)
            fprintf("Sis incomp sau sist comp nedet");
            return;
        else
            p = p + k - 1;
        end
        
        if p ~= k
            A([p k], :) = A([k p], :);
        end
        
        for l = k + 1 : n
            mlk = A(l, k)/A(k, k);
            A(l, :) = A(l, :) - mlk * A(k, :);
        end
    end
    
    if A(n, n) == 0
        fprintf("Sistem incomp sau sist comp nedet");
        return;
    end
    
    x = SubsDesc(A(:, 1:n), A(:, n + 1));

end

