clear 
close all
home

domain_bounds=[10,4];
map=csvread('map4.csv');

% for line=1:domain_bounds(1)
%     for col=1:domain_bounds(2)
%         if map(line,col)==1
%             data_points=[data_points; line col];
%         end
%     end
% end
%another possible example
data_points=[2 2];

use_plot=1;

T=fast_marching(data_points,domain_bounds,use_plot);
mesh(T);