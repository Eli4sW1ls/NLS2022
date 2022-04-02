clear
close all

%%

a = 0.2; b = 0.5; d = 0;
f = @(t,x) x*(x - a)*(1 - x);

tspan = [0 40];
x0 = 0;

figure
hold on
for step = 0:0.01:1.45
    x0 = step;
    [t, y] = ode45(f, tspan, x0);
    plot(t,y)
end 
hold off