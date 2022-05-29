function dxdt = prpr1(x, p)
    a = 0.2; b = 0.5;
%     d = 0;

    dxdt = [x(1)*(x(1) - a)*(1 - x(1)) - b*x(1)*x(2);
            x(1)*x(2) - p(1)*x(2)-p(2)];
end

