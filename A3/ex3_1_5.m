clear
close all
a = 0.2; b = 0.5;

%% c = (1+a)/2

c = 0.52;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -0.05; xmax = 2; 
ymin = -0.1; ymax = 1;
% xmin = -3.5; xmax = 2; 
% ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
%                     0.54, 0.64;
                    0.94, 0.045];
%                     0.6, 0.36];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [c-0.15, (c-a)*(1-c)/b] ;
% orbitsestimates = [];

% Execute the PPLANE alternative
% We recommend you play around with different options
figure(1); clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints         ,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)


%%
tspan = [0 5000];
x0 = [0.94, 0.045];
periods = [];

for c = 0.54:0.0001:0.61
    [t, f] = ode45(@(t,x) prpr(x, c), tspan, x0);
    
    % figure
    % plot(t, f(:,1))
    % figure
    % plot(t, f(:,2))
    
    tot = f(:, 1) + f(:,2);
%     figure
    % plot(t, tot)
    
    TF = islocalmax(tot);
%     plot(t,tot,t(TF),tot(TF),'r*')
    
    intv = t(TF);
    intv = intv(100:end);
    period = mean(diff(intv));
    disp(['Period is: ', num2str(period)])
    periods = [periods period];
end

figure
plot(0.54:0.0001:0.61, periods, "LineWidth", 1.5)
% hold on
% plot(0.54:0.001:0.6, (-500*log(0.54:0.001:0.6)-200))

ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$c$','interpreter', 'latex') ;
ylabel('$T$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend() ;
set(leg,'visible','off')
%%
tspan = [0 300];
x0 = [0.93, 0.09];
[t, f] = ode45(@(t,x) prpr(x, 0.543), tspan, x0);

figure
plot(t, f(:,1), "LineWidth", 1.5)
hold on
plot(t, f(:,2), "LineWidth", 1.5)
ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$t$','interpreter', 'latex') ;
ylabel('$x(t)$ / $y(t)$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend('x(t)', 'y(t)') ;
set(leg,'visible','on')

tot = f(:, 1) + f(:,2);
figure
plot(t, tot, "LineWidth", 1.5)

ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$t$','interpreter', 'latex') ;
ylabel('$x(t)+y(t)$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend() ;
set(leg,'visible','off')

%%
tspan = [0 300];
x0 = [0.55, 0.25];
[t, f] = ode45(@(t,x) prpr(x, 0.6), tspan, x0);

figure
plot(t, f(:,1), "LineWidth", 1.5)
hold on
plot(t, f(:,2), "LineWidth", 1.5)
ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$t$','interpreter', 'latex') ;
ylabel('$x(t)$ / $y(t)$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend('x(t)', 'y(t)') ;
set(leg,'visible','on')

tot = f(:, 1) + f(:,2);
figure
plot(t, tot, "LineWidth", 1.5)

ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$t$','interpreter', 'latex') ;
ylabel('$x(t)+y(t)$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend() ;
set(leg,'visible','off')
%%

function f  = prpr( x, c )
    a = 0.2; b = 0.5;

    f = [x(1)*(x(1) - a)*(1 - x(1)) - b*x(1)*x(2);
        x(1)*x(2) - c*x(2)];

end

