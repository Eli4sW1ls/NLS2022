%% EXAMPLE SCRIPT FOR THE PPLANE ALTERNATIVE

% Run the function help to display the options
help pplane_alternative

% Equations of the system
f = @(t,x) [ 2*x(1)-x(2)+3*(x(1)^2-x(2)^2)+2*x(1)*x(2);...
             x(1)-3*x(2)-3*(x(1)^2-x(2)^2)+3*x(1)*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -2; xmax = 4; 
ymin = -4; ymax = 2;

% Points where to start the simulations from
simulationpoints = [-0.8,1.1;
                    1,0.5;
                    1,-1;
                    3.2,-2.6;
                    0.05,-0.05];
               
% Estimation of the fixed points
fixedpointestimates = [0.5,0;
                       0.4,0.6;
                       -0.6,-0.4;
                       2,-2];
                   
% Estimation of points of orbits
orbitsestimates = [0.26, 0.005] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure(1); clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', false, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)
