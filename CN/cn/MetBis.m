function [xaprox] = MetBis(f, a, b, eps)

    a0 = a;
    b0 = b;
    x0 = (a0 + b0)/2;
    
    N = floor(log2((b - a)/eps) - 1) + 1;
    
    for k = 1:N
        if f(x0) == 0
            xk = x0;
            break;
        elseif f(a0) * f(x0) < 0
            ak = a0;
            bk = x0;
            xk = (ak + bk)/2;
        elseif f(a0) * f(x0) > 0
            ak = x0;
            bk = b0;
            xk = (ak + bk)/2;
        end
        x0 = xk;
        a0 = ak;
        b0 = bk;
    end
    
    xaprox = xk;

end

