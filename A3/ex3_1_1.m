clear
close all

%%

a = 0.2; b = 0.5; d = 0;
f = @(t,x) x*(x - a)*(1 - x);

tspan = [0 40];
x0 = 0;

figure
hold on
for step = 0:0.01:1.5
    x0 = step;
    [t, y] = ode45(f, tspan, x0);
    plot(t,y)
end 
hold off

ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$t$','interpreter', 'latex') ;
ylabel('$x$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend() ;
set(leg,'visible','off')