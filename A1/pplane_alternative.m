function [] = pplane_alternative(f,tspan,xmin,xmax,ymin,ymax,...
    varargin)
%PPLANE_ALTERNATIVE This function is an alternative to pplane8
%
% f describes the system of ODE's as a function of t and x
%
% tspan described the timespan used for the simulations
%
% xmin,... describe the window in which the arrows will be drawn
%
% several other parameters can be provided by providing their name,
% followed by their value, these include
%
% fixedpoints : estimates of fixed points
% simulations : starting points for simulations
% orbits      : starting points to search for stable periodic orbits
% manifolds   : boolean indicating whether to draw the stable manifolds
%               of the saddles (default false)
% manifoldstol: parameter to choose the distance between the initial
%               condition and the saddle when searching for a manifold.
%               Smaller values improve accuracy, but may increase the cost
%               (default 1.0e-2)
% direction   : the simulation direction, either 'forward', 'backward'
%               or 'both' (default 'both')
% nullclines  : boolean indicating whether to draw the nullclines
%               (default false)
% reportplot  : boolean indicating a special layout better suited for
%               reporting (default false)
% verbose     : boolean for verbose mode (default true)
% interactive : boolean indicating whether to use interactive mode,
%               allowing you draw the points on the plot. It also outputs
%               the selected points to the command line for later use.
%               (default false)
% odesolver   : function handle to an ode solver used for all the
%               simulations. The default is @ode15s, but @ode45 may work
%               better for nonstiff systems.
% ntst        : number of intervals for collocation (default 20)
% ncoll       : number of collocation points per interval (default 4)
%
%   Copyright: Thijs Steel & Henri De Plaen, KU LEUVEN
%   Date: March 2021

%% PRELIMINARIES
% Defaults
fixedpointestimates = [];   % empty list of fixed points by default
simulationpoints = [];      % empty simulation starting points by default
orbitestimates = [];        % empty list of orbits by default
showmanifolds = false;      % no computation of manifolds by default
esmall = 1.0e-2;            % eigenvector square norm fur plotting by default
direction = 'both';         % both directions by default
reportplot = false ;        % no special layout by default
nullclines = false ;        % no nullclines by default
nullfineness = 100 ;        % fineness used for the computation of the nullclines
verbose = true ;            % boolean for verbose mode tru by default
lw = 1.2 ;                  % linewidth used in the plots
interactive = false;        % by default, no interactivity
odesolver = @ode15s;        % by default, use ode15s
ncoll = 4;                 % number of collocation points for limit cycles
ntst = 20;                  % degree of the differentiation matrix for limit cycles

% Optionals
for ii = 1:2:nargin-6
    if strcmp('fixedpoints', varargin{ii})
        fixedpointestimates = varargin{ii+1};
    elseif strcmp('simulations', varargin{ii})
        simulationpoints = varargin{ii+1};
    elseif strcmp('orbits', varargin{ii})
        orbitestimates = varargin{ii+1};
    elseif strcmp('manifolds', varargin{ii})
        showmanifolds = varargin{ii+1};
    elseif strcmp('manifoldstol', varargin{ii})
        esmall = varargin{ii+1};
    elseif strcmp('direction', varargin{ii})
        direction = varargin{ii+1};
    elseif strcmp('reportplot', varargin{ii})
        reportplot = varargin{ii+1};
    elseif strcmp('nullclines', varargin{ii})
        nullclines = varargin{ii+1};
    elseif strcmp('verbose', varargin{ii})
        verbose = varargin{ii+1};
    elseif strcmp('interactive', varargin{ii})
        interactive = varargin{ii+1};
    elseif strcmp('odesolver', varargin{ii})
        odesolver = varargin{ii+1};
    elseif strcmp('ncoll', varargin{ii})
        ncoll = varargin{ii+1};
    elseif strcmp('ntst', varargin{ii})
        ntst = varargin{ii+1};
    end
end

if verbose ; fprintf("\nSTARTING PPLANE ALTERNATIVE\n") ; end


f_backward = @(t,x) -f(t,x);
warning('off','MATLAB:ode15s:IntegrationTolNotMet');

% Add the menu options
if(interactive)
  menuobj = uimenu('Text','&Pplane Options');

  mitem1 = uimenu(menuobj,'Text','&Add solution');
  mitem1.MenuSelectedFcn = @addsolution;

  mitem2 = uimenu(menuobj,'Text','&Add fixed point');
  mitem2.MenuSelectedFcn = @addfixedpoint;

  mitem3 = uimenu(menuobj,'Text','&Add closed orbit');
  mitem3.MenuSelectedFcn = @addclosedorbit;

  mitem3 = uimenu(menuobj,'Text','&Print parameters');
  mitem3.MenuSelectedFcn = @printparameters;
end

%% DRAW ARROWS
if verbose ; fprintf("Computing arrows...") ; end
[xx,yy] = meshgrid(linspace(xmin,xmax,21),linspace(ymin,ymax,21));
fxx = zeros(size(xx));
fyy = zeros(size(xx));
gamma = zeros(size(xx));

% Determine sizes of arrows for scaling
for i = 1:size(xx,1)
    for j = 1:size(xx,2)
        temp = f(0,[xx(i,j);yy(i,j)]);
        gamma(i,j) = norm(temp);
    end
end

gmax = max( gamma(:) );

for i = 1:size(xx,1)
    for j = 1:size(xx,2)
        temp = f(0,[xx(i,j);yy(i,j)]);
        % Do some scaling to avoid very small arrows
        gamma(i,j) = norm(temp);
        if(gamma(i,j) < 0.2*gmax && gamma(i,j) > 0)
            temp = temp/gamma(i,j)*0.2*gmax;
        end
        fxx(i,j) = temp(1);
        fyy(i,j) = temp(2);
    end
end

quiver( xx, yy, fxx, fyy, 'color', [0.4, 0.4, 0.4] ); % plot the arrows in gray
hold on;
axis([xmin xmax ymin ymax]);

drawnow;
if verbose ; fprintf("  Done\n") ; end

%% NULLCLINES

if(nullclines)
    if verbose ; fprintf("Computing nullclines...") ; end
    [xx,yy] = meshgrid(linspace(xmin,xmax,nullfineness),linspace(ymin,ymax,nullfineness));
    fxx = zeros(size(xx));
    fyy = zeros(size(xx));
    for i = 1:size(xx,1)
        for j = 1:size(xx,2)
            temp = f(0,[xx(i,j);yy(i,j)]);
            fxx(i,j) = temp(1);
            fyy(i,j) = temp(2);
        end
    end
    contour(xx,yy,fxx,[0,0],'color',[0.8500 0.3250 0.0980])
    contour(xx,yy,fyy,[0,0],'color',[0.4940 0.1840 0.5560])
    
    drawnow;
    if verbose ; fprintf("  Done\n") ; end
end

%% DRAW SOLUTIONS
if verbose ; fprintf("Computing solutions...") ; end
for i=1:size(simulationpoints,1)
    drawsolution(simulationpoints(i,:)');
end

drawnow;
if verbose ; fprintf("  Done\n") ; end

%% DRAW FIXED POINTS

if verbose && ~isempty(fixedpointestimates)
    fprintf("Computing fixed points...") ;
end

for i=1:size(fixedpointestimates,1)
    drawfixedpoint(fixedpointestimates(i,:)');
end

if verbose && ~isempty(fixedpointestimates)
    drawnow;
    fprintf("  Done\n") ;
end

%% ATTEMPTS AT CLOSED ORBITS
if verbose && ~isempty(orbitestimates)
    fprintf("Computing orbits...") ;
end

for i=1:size(orbitestimates,1)
    drawclosedorbit(orbitestimates(i,:)')
end

if verbose && ~isempty(orbitestimates)
    drawnow;
    fprintf("  Done\n") ;
end

%% PLOTS PARAMS
axis([xmin xmax ymin ymax]);

if reportplot
    % Changes font and axis position
    ax = gca ;
    ax.XAxisLocation = 'origin' ;
    ax.YAxisLocation = 'origin' ;
    set(0,'DefaultLineColor','k') ;
    set(gca,'box','off') ;
    set(gca, 'FontSize', 17) ;
    xlabel('$x$','interpreter', 'latex') ;
    ylabel('$y$','interpreter', 'latex') ;
    set(gca,'TickLabelInterpreter','latex') ;
    leg = legend() ;
    set(leg,'visible','off')
    
    % Suppresses margin around plot
    outerpos = ax.OuterPosition ;
    ti = ax.TightInset ;
    left = outerpos(1) + ti(1) ;
    bottom = outerpos(2) + ti(2) ;
    ax_width = outerpos(3) - ti(1) - ti(3) ;
    ax_height = outerpos(4) - ti(2) - 1.5*ti(4) ;
    ax.Position = [left bottom ax_width ax_height] ;
end

if verbose ; fprintf("\n") ; end

%% INTERNAL FUNCTIONS

    function [] = drawsolution(x0)
        options = odeset('Refine',4,'RelTol',1.0e-3);
        if( strcmp('both', direction) || strcmp('forward', direction) )
            [~,x_forward] = odesolver(f, tspan, x0,options);
            l = line(x_forward(:,1),x_forward(:,2),'color','b','linewidth',lw);
            uistack(l,'bottom');
        end
        
        if( strcmp('both', direction) || strcmp('backward', direction) )
            [~,x_backward] = odesolver(f_backward, tspan, x0,options);
            l = line(x_backward(:,1),x_backward(:,2),'color','b','linewidth',lw);
            uistack(l,'bottom');
        end
    end

    function [] = addsolution(src,event)
        [x_i,y_i] = ginput(1);
        drawsolution([x_i;y_i]);
        simulationpoints = [simulationpoints;x_i,y_i];
    end

    function [] = drawfixedpoint(x0)
        options = optimset('Display','off');
        [fp,~,info] = fsolve( @(x) f(0,x), x0,options);
        if( info ~= 1 )
            return
        end
        plot(fp(1),fp(2), 'color', 'r', 'marker', '.', 'markersize', 20) ;
        
        if(showmanifolds)
            stablemanifolds = [];
            [J,~]=jacobiancsd(@(x) f(0,x),fp);
            [V,e] = eig(J,'vector');
            
            % Check if point is saddle node
            if( isreal(e) )
                if( e(1) < 0 && e(2) > 0 )
                    sep = fp + esmall*V(:,1);
                    sep2 = fp - esmall*V(:,1);
                    stablemanifolds = [sep';sep2'];
                elseif( e(1) > 0 && e(2) < 0)
                    sep = fp + esmall*V(:,2);
                    sep2 = fp - esmall*V(:,2);
                    stablemanifolds = [sep';sep2'];
                end
            end
            if(~isempty(stablemanifolds))
                for iii=1:size(stablemanifolds,1)
                    [~,x_backward] = odesolver(f_backward, tspan, ...
                                        stablemanifolds(iii,:)',options);
                    line([fp(1);x_backward(:,1)],[fp(2);x_backward(:,2)],...
                        'color','g','linewidth',lw);
                end
            end
        end
    end

    function [] = addfixedpoint(src,event)
        [x_i,y_i] = ginput(1);
        drawfixedpoint([x_i;y_i]);
        fixedpointestimates = [fixedpointestimates;x_i,y_i];
    end

    function [] = drawclosedorbit(x0)
        options = odeset('Refine',4,'RelTol',1.0e-6);
        % Time span may need to be adjusted to account for more difficult orbits
        [t,x] = odesolver(f, tspan, x0,options);

        % Try to identify a closed orbit
        TF = find(islocalmin(x(:,1)));
        index1 = TF(length(TF)-1);
        index2 = TF(length(TF));

        if( norm( x(index1,:) - x(index2,:) ) < 0.1*norm(x(index1,:)) ...
                && norm( x(index1,:) - x(index1 + round((index2-index1)/2),:) ) > 0.1*norm(x(index1,:)))
            % we might be close to a closed orbit, refine using collocation

            % Estimate the period
            T = t(index2)-t(index1);
            [x,T] = collocation(f,x(end,:).',T,ntst,ncoll);

            line([x(:,1);x(1,1)],[x(:,2);x(1,2)],...
                'color','r','LineWidth',2);
        elseif(verbose)
            fprintf("\n  No orbit found close to point \n") ;
        end
    end

    function [] = addclosedorbit(src,event)
        [x_i,y_i] = ginput(1);
        drawclosedorbit([x_i;y_i]);
        orbitestimates = [orbitestimates;x_i,y_i];
    end

    function [] = printparameters(src,event)
        simulationpoints
        fixedpointestimates
        orbitestimates
    end

    function [xy_input] = getuserinput(xy_initial)
        done = false;
        if( isempty(xy_initial) )
            x_initial = [];
            y_initial = [];
        else
            x_initial = xy_initial(:,1);
            y_initial = xy_initial(:,2);
        end
        xy_input = [];
        selecteddots = plot(x_initial,y_initial,'r*');
        while(~done)
            [x_i,y_i] = ginput(1);
            delete(selecteddots);
            if(isempty(x_i))
                done = true;
            else
                xy_input = [xy_input;x_i,y_i];
                selecteddots = plot([x_initial;xy_input(:,1)],...
                    [y_initial;xy_input(:,2)],'r*');
            end
        end
        fprintf("The points selected were:")
        xy_input
    end

    function [A,z]=jacobiancsd(fun,x)
        % JACOBIANCSD    Complex Step Jacobian
        % J = jacobiancsd(f,x) returns the numberical (m x n) Jacobian matrix of a
        % m-vector function, f(x) at the refdrence point, x (n-vector).
        % [J,z] = jacobiancsd(f,x) also returns the function value, z=f(x).
        %
        % Example
        % f=@(x)[x(1)*x(2)^2;x(1)*x(3)^2;x(1)^2];
        % x=1:3;
        % [J,z]=jacobiancsd(f,x)
        % J =
        %     4     4     0
        %     9     0     6
        %     2     0     0
        % z =
        %     4
        %     9
        %     1
        %
        % By Yi Cao at Cranfield University, 02/01/2008
        %
        z=fun(x);                       % function value
        n=numel(x);                     % size of independent
        m=numel(z);                     % size of dependent
        A=zeros(m,n);                   % allocate memory for the Jacobian matrix
        h_small=n*eps;                        % differentiation step size
        for k=1:n                       % loop for each independent variable
            x1=x;                       % reference point
            x1(k)=x1(k)+h_small*1i;           % increment in kth independent variable
            A(:,k)=imag(fun(x1))/h_small;     % complex step differentiation
        end
        
    end

end



