function [xaprox] = MetPF(f, a, b, eps)

    a0 = a;
    b0 = b;
    x0 = (a0 * f(b0) - b0 * f(a0))/(f(b0) - f(a0));
    
    if f(x0) == 0
        xaprox = x0;
        return;
    elseif f(a0)f(x0) < 0
        a1 = a0;
        b1 = x0;
        x1 = (a1 * f(b1) - b1 * f(a1))/(f(b1) - f(a1));
    elseif f(a0)*f(x0) > 0
        a1 = x0;
        b1 = b0;
        x1 = (a1 * f(b1) - b1 * f(a1))/(f(b1) - f(a1));
    end
    
    while abs(x1 - x0)/abs(x0) >= eps
        x0 = x1;
        a0 = a1;
        b0 = b1;
        
        if f(x0) == 0
        x1 = x0;
        break;
        elseif f(a0)f(x0) < 0
            a1 = a0;
            b1 = x0;
            x1 = (a1 * f(b1) - b1 * f(a1))/(f(b1) - f(a1));
        elseif f(a0)*f(x0) > 0
            a1 = x0;
            b1 = b0;
            x1 = (a1 * f(b1) - b1 * f(a1))/(f(b1) - f(a1));
        end
    end
    
    xaprox = x1;

end

