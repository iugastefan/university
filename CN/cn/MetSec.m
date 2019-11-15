function [xaprox] = MetSec(f, a, b, x0, x1, eps)

    while abs(x1 - x0)/abs(x0) >= eps
        x2 = (x0 * f(x1) - x1 * f(x0)) / (f(x1) - f(x0));
        
        if x2 < a || x2 > b
            fprintf("Introduceti alte valori pt x0, x1\n");
            return;
        end
        
        x0 = x1;
        x1 = x2;
    end
    
    xaprox = x2;

end

