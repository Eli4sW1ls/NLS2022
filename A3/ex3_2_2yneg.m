% close all
clear 
%%

h_max = 0.1;
d = -0.01;
xy = 2;

% find first branch

prob_name = 'ex3_2';
ode_func = @prpr1;
p_names = {'c', 'd'};
p_cont = {'c'};
p_range = {[-0.5,2]};


x_start = [0, 0.5];
p_start = [0.1, d];

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'cont', 'ItMX', 100);
prob = coco_set(prob, 'cont', 'h_max', h_max);
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% visualize first branch
figure; clf; hold on;
x = coco_bd_col(bd1, 'x');
x = x(xy, :);
c = coco_bd_col(bd1, 'c');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 2);
sstab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(c(stab_idxs), x(stab_idxs), 'b.');
plot(c(ustab_idxs), x(ustab_idxs), 'r.');
plot(c(sstab_idxs), x(sstab_idxs), 'g.');

idx = coco_bd_idxs(bd1, 'SN');
plot(c(idx), x(idx), 'ro','markerfacecolor','r');
hold on;

%% find second branch
% Since we know about the pitchfork bifurcation, we can suspect that the
% imperfection broke the equilibrium branch and that there is a second
% branch.

x_start = [-0.5, 0.1];
p_start = [-0.3, d];

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'ItMX', 1000);
prob = coco_set(prob, 'cont', 'h_max', h_max);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% visualize second branch
x = coco_bd_col(bd1, 'x');
x = x(xy, :);
c = coco_bd_col(bd1, 'c');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 2);
sstab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(c(stab_idxs), x(stab_idxs), 'b.');
plot(c(ustab_idxs), x(ustab_idxs), 'r.');
plot(c(sstab_idxs), x(sstab_idxs), 'g.');

idx = coco_bd_idxs(bd1, 'SN');
plot(c(idx), x(idx), 'ro','markerfacecolor','r');
hold on

%% find second branch
% Since we know about the pitchfork bifurcation, we can suspect that the
% imperfection broke the equilibrium branch and that there is a second
% branch.

x_start = [0.2, 0.01];
p_start = [1.1, d];

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'ItMX', 1000);
prob = coco_set(prob, 'cont', 'h_max', h_max);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% visualize second branch
x = coco_bd_col(bd1, 'x');
x = x(xy, :);
c = coco_bd_col(bd1, 'c');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 2);
sstab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(c(stab_idxs), x(stab_idxs), 'b.');
plot(c(ustab_idxs), x(ustab_idxs), 'r.');
plot(c(sstab_idxs), x(sstab_idxs), 'g.');

idx = coco_bd_idxs(bd1, 'SN');
plot(c(idx), x(idx), 'ro','markerfacecolor','r');
hold on

%% find second branch
% Since we know about the pitchfork bifurcation, we can suspect that the
% imperfection broke the equilibrium branch and that there is a second
% branch.

x_start = [-3, 0.01];
p_start = [1.8, d];

% Do the actual continuation
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'ItMX', 100);
prob = coco_set(prob, 'cont', 'h_max', h_max);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);

% visualize second branch
x = coco_bd_col(bd1, 'x');
x = x(xy, :);
c = coco_bd_col(bd1, 'c');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 2);
sstab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(c(stab_idxs), x(stab_idxs), 'b.');
plot(c(ustab_idxs), x(ustab_idxs), 'r.');
plot(c(sstab_idxs), x(sstab_idxs), 'g.');

idx = coco_bd_idxs(bd1, 'SN');
plot(c(idx), x(idx), 'ro','markerfacecolor','r');
hold off;

ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$c$','interpreter', 'latex') ;
ylabel('$x$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend() ;
set(leg,'visible','off')
title("$d=0$", 'interpreter', 'latex')