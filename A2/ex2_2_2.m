clear;
close all;

% fixed value for h
h_fix = -0.05;

%% find first branch

prob_name = 'ex2_2';
ode_func = @ex2_system;
p_names = {'r', 'h'};
p_cont = {'r'};
p_range = {[-1,1]};


x_start = 1;
p_start = [1, h_fix];

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
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
hold on;
xlabel('r'); ylabel('x');

%% find second branch
% Since we know about the pitchfork bifurcation, we can suspect that the
% imperfection broke the equilibrium branch and that there is a second
% branch.

x_start = 1;
p_start = [-1, h_fix];

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% visualize second branch
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
hold off;