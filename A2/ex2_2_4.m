clear;
close all;

% fixed value for h
h_fix = -0.0025;

%% find first branch

prob_name = 'ex2_2';
ode_func = @ex2_system;
p_names = {'r', 'h'};
p_cont = {'r'};
p_range = {[-1,1]};

x_start = 0;
p_start = [-1,h_fix];

% Set some computation parameters
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'h_min', 0.01);
prob = coco_set(prob, 'cont', 'h_max', 0.05);
prob = coco_set(prob, 'corr', 'ItMX', 10);
prob = coco_set(prob, 'cont', 'ItMX', 100);

% Do the actual continuation
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% visualize first branch
figure(1); clf; hold on;
x = coco_bd_col(bd1, 'x');
r = coco_bd_col(bd1, 'r');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), 'b.');
plot(r(ustab_idxs), x(ustab_idxs), 'r.');

idx = coco_bd_idxs(bd1, 'SN');
plot(r(idx), x(idx), 'ro','markerfacecolor','r');
xlabel('r'); ylabel('x');

%% find second branch

x_start = 0.3;
p_start = [0.1,h_fix];

% Set some computation parameters
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'h_min', 0.01);
prob = coco_set(prob, 'cont', 'h_max', 0.05);
prob = coco_set(prob, 'corr', 'ItMX', 10);
prob = coco_set(prob, 'cont', 'ItMX', 100);

% Do the actual continuation
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd2 = coco(prob, prob_name, [], 1, p_cont, p_range);

% visualize second branch
x = coco_bd_col(bd2, 'x');
r = coco_bd_col(bd2, 'r');

ustab = coco_bd_col(bd2, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), 'b.');
plot(r(ustab_idxs), x(ustab_idxs), 'r.');

idx = coco_bd_idxs(bd2, 'SN');
plot(r(idx), x(idx), 'ro','markerfacecolor','r');
xlabel('r'); ylabel('x');