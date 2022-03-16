clear;
close all;

% system definition
sn_func = @(x,p) p + x^2;

% make coco problem structure
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob = ode_isol2ep(prob, '', sn_func, 0, {'r'}, 1); % init continuation
coco(prob, 'saddlenodebif', [], 1, {'r'}, [-2, 2]); % run continuation

% coco(prob, 'saddlenodebif', 'ode', 'isol', 'ep', ...
%     sn_func, 0, {'r'}, 1, ...
%     {'r'}, [-2, 2]);


%% visualize
figure(1); hold on;
bd1 = coco_bd_read('saddlenodebif');
x = coco_bd_col(bd1, 'x');
r = coco_bd_col(bd1, 'r');
plot(r, x);

idx = coco_bd_idxs(bd1, 'SN');
plot(r(idx), x(idx), 'ro');
axis([-2, 2, -2, 2]);