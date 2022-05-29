function dxdt = prtest(x)
    a = 0.2; b = 0.5;
    d = -0.01;
    c = -0.3;

    dxdt = [x(1)*(x(1) - a)*(1 - x(1)) - b*x(1)*x(2);
            x(1)*x(2) - c*x(2)- d];
end