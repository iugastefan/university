function [x] = GPT(A, b)

    n = length(b);
    A = [A b];
    
    index = 1:n;
    
    for k = 1 : n - 1
        M = A(k:n, k:n);
        valMax = max(M(:));
        [p, m] = find(M == valMax);
        
        if isempty(p) || isempty(m)
            return;
        else
            p = p + (k - 1);
            m = m + (k - 1);
        end
        
        if A(p, m) == 0
            fprintf("Sist incomp sau comp nedet");
            return;
        end
        
        if p ~= k
            A([p k], :) = A([k p], :);
        end
        
        if m ~= k
            A(:, [m k]) = A(:, [k m]);
            aux = index(m);
            index(m) = index(k);
            index(k) = aux;
        end
        
        for l = k + 1 : n
            mlk = A(l, k)/A(k, k);
            A(l, :) = A(l, :) - mlk * A(k, :);
        end
    end
    
    if A(n, n) == 0
        fprintf("SI sau SCN");
        return;
    end
    
    y = SubsDesc(A(:, 1:n), A(:, n + 1));
    
    x(index) = y;

end

