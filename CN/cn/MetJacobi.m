function [lambda] = MetJacobi(A, eps)

    n = length(A);
    
    AA = A - diag(diag(A));
    
    while sqrt(sumsqr(AA)) >= eps
        maxVal = max(abs(AA(:)));
        [p, q] = find(abs(AA) == maxVal, 1, 'first');
        
        if A(p, p) == A(q, q)
            teta = pi/4;
        else
            teta = atan(2 * A(p, q)/(A(q,q) - A(p,p)))/2;
        end
        
        c = cos(teta);
        s = sin(teta);
        
        for j = 1 : n
            if j ~= p && j ~= q
                u = A(p,j) * c - A(q,j) * s;
                v = A(p,j) * s + A(q,j) * c;
                A(p,j) = u;
                A(q,j) = v;
                A(j,p) = u;
                A(j,q) = v;
            end
        end
        u = c*c*A(p,p) - 2*c*s*A(p,q) + s*s*A(q,q);
        v = s*s*A(p,p) + 2*c*s*A(p,q) + c*c*A(q,q);
        A(p,p) = u;
        A(q,q) = v;
        A(p,q) = 0;
        A(q,p) = 0;
        
        AA = A - diag(diag(A));
    end
    lambda = diag(A);
                

end

