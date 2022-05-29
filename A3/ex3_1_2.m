clear 
close all
a = 0.2; b = 0.5;

%% c = 0

c = 0;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -3.5; xmax = 2; 
ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure; clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)
%% 0<c<a

c = a/2;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -3.5; xmax = 2; 
ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure(1); clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)

%% c=a

c = a;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -3.5; xmax = 2; 
ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure(1); clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)

%% c = (1+a)/2

c = 0.7;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = 0.2; xmax = 1.4; 
ymin = -0.2; ymax = 1;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5;
                    0.54, 0.64
                    0.6, 0.36];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [c-0.15, (c-a)*(1-c)/b] ;

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

%% a<c<0.241

c = 0.215;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -3.5; xmax = 2; 
ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure(1); clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)

%% c=0.241<c<(1+a)/2

c = 0.34;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -3.5; xmax = 2; 
ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure(1); clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)

%% c=0.241<c<(1+a)/2

c = 0.94;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -3.5; xmax = 2; 
ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure(1); clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)

%% c=0.241<c<(1+a)/2

c = 0.75;

% Equations of the system
f = @(t,x) [ x(1)*(x(1)-a)*(1-x(1))-b*x(1)*x(2);...
             x(1)*x(2) - c*x(2) ];

% Time span for the execution of the simulations
tspan = [0,200];
                
% Plot range
xmin = -3.5; xmax = 2; 
ymin = -5; ymax = 4;

% Points where to start the simulations from
simulationpoints = [-3, -4;
                    a/2, 1;
                    0.6, 0.2;
                    0.6, -0.2;
                    2, -0.2;
                    2, 0.2;
                    c-1, (c-a)*(1-c)/b+1.5];
               
% Estimation of the fixed points
fixedpointestimates = [0,0;
                       a, 0;
                       1,0;
                       c, (c-a)*(1-c)/b];
                   
% Estimation of points of orbits
orbitsestimates = [] ;

% Execute the PPLANE alternative
% We recommend you play around with different options
figure; clf;
pplane_alternative( f,tspan,xmin,xmax,ymin,ymax,...
                 'fixedpoints',fixedpointestimates,...
                 'simulations',simulationpoints,...
                 'direction','both', ...
                 'reportplot', true, ...
                 'nullclines', true, ...
                 'manifolds', true, ...
                 'orbits', orbitsestimates, ...
                 'verbose', true, ...
                 'ntst', 40,...
                 'interactive', true)