function dxdt = prpr(x ,c)
    a = 0.2; b = 0.5;
    d = 0;

    dxdt = [x(1)*(x(1) - a)*(1 - x(1)) - b*x(1)*x(2);
            x(1)*x(2) - c*x(2)-d];
end

