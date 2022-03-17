clear;
close all;

% fixed value for r
r_fix = 0.01;       % non-generic turning point: r = 0?

%% find the branch

prob_name = 'ex2_1';
ode_func = @ex2_system;
p_names = {'r', 'h'};
p_cont = {'h'};
p_range = {[-2,2]};

x_start = 0;
p_start = [r_fix, 0];

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% plots
figure(1); clf; hold on;
x = coco_bd_col(bd1, 'x');
h = coco_bd_col(bd1, 'h');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(h(stab_idxs), x(stab_idxs), 'b.');
plot(h(ustab_idxs), x(ustab_idxs), 'r.');

% This finds the index of a saddle node
idx = coco_bd_idxs(bd1, 'SN');
plot(h(idx), x(idx), 'ro', 'markerfacecolor','r');
xlabel('h'); ylabel('x');