clear;
close all;

%% Find a initial fold point to start the continuation from

prob_name = 'ex2_3';
ode_func = @ex2_system;
p_names = {'r', 'h'};
p_cont = {'r'};
p_range = {[-1,1]};
x_start = 0.3;
p_start = [1,0.1];

prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = ode_isol2ep(prob, '', ode_func, x_start, p_names, p_start);
bd1 = coco(prob, prob_name, [], 1, p_cont, p_range);


%% Continuate along the branch of fold points

% We will be varying both r and h to find a curve of fold points
p_cont = {'r', 'h'};
p_range = {[0, 2], [-0.1, 0.1]};

prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
fold = coco_bd_labs(bd1, 'SN');
prob = ode_SN2SN(prob, '', prob_name, fold(1));
bd2 = coco(prob, 'ex2_3_fold_curve', [], 1, p_cont, p_range);

x = coco_bd_col(bd2, 'x');
r = coco_bd_col(bd2, 'r');
h = coco_bd_col(bd2, 'h');

plot3(x,r,h,'k.');
xlabel('x'); ylabel('r'); zlabel('h');
grid on