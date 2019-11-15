function [xaprox] = MetNR(f, df, x0, eps)

    x1 = x0 - f(x0)/df(x0);
    
    while abs(x1 - x0)/abs(x0) >= eps
        x0 = x1;
        x1 = x0 - f(x0)/df(x0);
    end
    
    xaprox = x1;

end

