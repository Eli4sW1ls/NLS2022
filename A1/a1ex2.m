r = -3;
% Equations of the system
f = @(t,x) [ 2/(1+x(2)^r)-x(1);...
             2/(1+x(1)^r)-x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = 0; xmax = 5; 
ymin = 0; ymax = 5;

% Points where to start the simulations from
simulationpoints = [];
               
% Estimation of the fixed points
fixedpointestimates = [1 1;...
                       2 0.1;...
                       0.1 2];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure; clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', false, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)
ylabel("y")
xlabel("x")
title("0<r<2   (r=1.2)")


%%

figure
plot([0 2], [1 1], 'k', 'LineWidth', 2)
hold on
plot([2 5], [1, 1], 'k--', 'LineWidth', 2)
plot(2:0.01:5, sqrt([2:0.01:5]-2)+1, 'k', 'LineWidth', 2)
plot(2:0.01:5, -sqrt([2:0.01:5]-2)+1, 'k', 'LineWidth', 2)

xticks([0 2])
yticks(1)
title("Supercritical pitchfork bifurcation")

ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$r$','interpreter', 'latex') ;
ylabel('$x$  $|$  $y$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend() ;
set(leg,'visible','off')

