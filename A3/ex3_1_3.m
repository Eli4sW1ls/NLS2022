close all
clear
a = 0.2; b = 0.5;

%%
range = 0:0.001:1.5;

evo = zeros(length(range), 2);

for i = 1:length(range)
    c = range(i);
    J = [c*(1+a-2*c) -b*c;
         (c-a)*(1-c)/b 0];
    evo(i, :) = eig(J);
end

scatter3(range, real(evo(:,1)), imag(evo(:,1)), '.')
hold on
scatter3(range, real(evo(:,2)), imag(evo(:,2)), '.')

ax = gca ;
% ax.XAxisLocation = 'origin' ;
% ax.YAxisLocation = 'origin' ;
set(0,'DefaultLineColor','k') ;
set(gca,'box','off') ;
set(gca, 'FontSize', 17) ;
xlabel('$c$','interpreter', 'latex') ;
ylabel('$Re$','interpreter', 'latex') ;
zlabel('$Im$','interpreter', 'latex') ;
set(gca,'TickLabelInterpreter','latex') ;
leg = legend() ;
set(leg,'visible','off')