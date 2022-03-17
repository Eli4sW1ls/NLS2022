% This file contains some example code for coco.
% You can start from this file when making a bifurcation diagram for 
clear;
close all;

%% Find the first branch

% Problem name, you can select any name you want, this helps coco keep
% track of different solutions.
prob_name = 'genecontrol';
% Function handle that returns the ode model
ode_func = @gene_control;
% A vector containing the initial state for the model used during
% continuation
x_start = [0,0];
% A list of the names of the parameters used in the model in the order that
% they are used in the function handle.
p_names = {'r'};
% A vector containing the initial value for the parameters used during
% continuation in the order that they are used in the function handle.
p_start = 1;
% A list of the names of the parameters being studied
p_cont = {'r'};
% A list of the ranges of the parameters being studied
p_range = {[0,4]};

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% Plot the result

x = coco_bd_col(bd1, 'x');
r = coco_bd_col(bd1, 'r');
% Find the number of unstable eigenvalues for each point.
ustab = coco_bd_col(bd1, 'ep.test.USTAB');
% Find the indices of the stable and the unstable points.
ustab_idxs = find(ustab > 1);
saddle_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);

figure(1); clf;
plot3(r(stab_idxs), x(1,stab_idxs), x(2,stab_idxs), 'b.');
hold on;
plot3(r(saddle_idxs), x(1,saddle_idxs), x(2,saddle_idxs), 'g.');
plot3(r(ustab_idxs), x(1,ustab_idxs), x(2,ustab_idxs), 'r.');
xlabel('r'); ylabel('x'); zlabel('y');
grid on;

%% Find the second branch

% The previous code only finds one branch of the bifurcation that we want.
% Try to find a suitable starting point that results in the other branch
% and plot the two branches together

x_start = [2,0];
p_start = 4;

% Do the continuation again
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd2 = coco(prob, prob_name, [], 1, p_cont, p_range);

% Plot the result
x = coco_bd_col(bd2, 'x');
r = coco_bd_col(bd2, 'r');
ustab = coco_bd_col(bd2, 'ep.test.USTAB');
ustab_idxs = find(ustab > 1);
saddle_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);

plot3(r(stab_idxs), x(1,stab_idxs), x(2,stab_idxs), 'b.');
plot3(r(saddle_idxs), x(1,saddle_idxs), x(2,saddle_idxs), 'g.');
plot3(r(ustab_idxs), x(1,ustab_idxs), x(2,ustab_idxs), 'r.');
hold off;