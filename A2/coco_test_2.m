clear;
close all;

% functions (tc = transcritical bifurcation normal form)
tc_func = @(x,p) p*x - x^2;
tc_df = @(x,p) p - 2*x;
tc_dp = @(x,p) x;

%% find first branch
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob = ode_isol2ep(prob, '', tc_func, tc_df, tc_dp, 0, {'r'}, -2);
bd1 = coco(prob, 'tcbif1', [], 1, {'r'}, [-2, 2]);


%% visualize first branch
figure(1); hold on;
% bd1 = coco_bd_read('tcbif1'); %% read the saved data
x = coco_bd_col(bd1, 'x');
r = coco_bd_col(bd1, 'r');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), 'b');
plot(r(ustab_idxs), x(ustab_idxs), 'r--');

idx = coco_bd_idxs(bd1, 'BP');
plot(r(idx), x(idx), 'ro');


%% find second branch
branchpoint = coco_bd_labs(bd1, 'BP');

prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob = ode_BP2ep(prob, '', 'tcbif1', branchpoint);

bd2 = coco(prob, 'tcbif2', [], 1, {'r'}, [-2, 2]);

%% visualize second branch
% bd2 = coco_bd_read('tcbif2');
x = coco_bd_col(bd2, 'x');
r = coco_bd_col(bd2, 'r');

ustab = coco_bd_col(bd2, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), 'b');
plot(r(ustab_idxs), x(ustab_idxs), 'r--');

axis([-2, 2, -2, 2]);
xlabel('r');
ylabel('x');
