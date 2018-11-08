%
% Copyright 2018, Kenny Erleben, DIKU.
%
close all;
clear all;
clc;
      
load('./data.mat');

f_type = 'Times';
f_size = 14;
pixel_width = 1280;
pixel_height = 720;
paper_width_cm = 21;
paper_height_cm = 9*21/16;

s_array = [];
m_array = [];
min_array = [];
max_array = [];
mean_array = [];
var_array = [];

for i=1:length(solvers)

    param = params{i};    
    method = solvers{i};
    
    if ~strcmp(method, 'prox_anderson_acceleration')
        continue;
    end

    N = 0;
    E = [];
    for j=1:length(results{i})
        
        result = results{i}{j};        
        e = sum(result.theta(:));
        if e>0
            N = N +1;
            E = [E, e];
        end
    end
        
    s_array = [s_array, param.s];
    m_array = [m_array, param.m];
    min_array = [min_array, min(E)];
    max_array = [ max_array, max(E)];
    mean_array = [ mean_array, mean(E)];
    var_array = [ var_array, var(E)];
    
end

fh = figure(1);
clf;
[ax, p1, p2 ] = plotyy(1:length(m_array), m_array, 1:length(s_array), s_array );
%p1 = plot(s_array, '>r', 'LineWidth', 2 );
%hold on;
%p2 = plot(m_array, '<k', 'LineWidth', 2 );
grid
%hold off;
set(p1,  'LineWidth', 2)
set(p2,  'LineWidth', 2)
p1.Marker = '>';
p2.Marker = '<';
p1.LineStyle = 'none';
p2.LineStyle = 'none';
set(fh, 'Position', [100, 100, pixel_width, pixel_height]);
set(fh, 'PaperUnits', 'centimeters');
set(fh, 'PaperPosition', [0 0 paper_width_cm paper_height_cm]);
%legend([p1, p2], 'Weight', 'Memory');
xlabel('Experiment No', 'FontSize', f_size, 'FontName', f_type)
ylabel(ax(1), 'Memory', 'FontSize', f_size, 'FontName', f_type)
ylabel(ax(2), 'Weight', 'FontSize', f_size, 'FontName', f_type)
title('Anderson Acceleration Parameters', 'FontSize', f_size, 'FontName', f_type)
filename = 'params';
print(gcf,'-depsc2', filename);


fh = figure(4);
clf;
[ax, p1, p2 ] = plotyy(1:length(mean_array), mean_array, 1:length(var_array), var_array );
%p1 = plot(s_array, '>r', 'LineWidth', 2 );
%hold on;
%p2 = plot(m_array, '<k', 'LineWidth', 2 );
grid
%hold off;
set(p1,  'LineWidth', 2)
set(p2,  'LineWidth', 2)
p1.Marker = 'x';
p2.Marker = 'o';
p1.LineStyle = 'none';
p2.LineStyle = 'none';
set(fh, 'Position', [100, 100, pixel_width, pixel_height]);
set(fh, 'PaperUnits', 'centimeters');
set(fh, 'PaperPosition', [0 0 paper_width_cm paper_height_cm]);
%legend([p1, p2], 'Weight', 'Memory');
xlabel('Experiment No', 'FontSize', f_size, 'FontName', f_type)
ylabel(ax(1), 'Mean of Total Error', 'FontSize', f_size, 'FontName', f_type)
ylabel(ax(2), 'Variance of Total Error', 'FontSize', f_size, 'FontName', f_type)
title('Total Error and Variance of Anderson Acceleration Parameters', 'FontSize', f_size, 'FontName', f_type)
filename = 'errors';
print(gcf,'-depsc2', filename);


fh = figure(2);
clf;
semilogy(mean_array, '-r', 'LineWidth', 2 );
grid
set(fh, 'Position', [100, 100, pixel_width, pixel_height]);
set(fh, 'PaperUnits', 'centimeters');
set(fh, 'PaperPosition', [0 0 paper_width_cm paper_height_cm]);
xlabel('Measurement', 'FontSize', f_size, 'FontName', f_type)
ylabel('Mean of Area Error', 'FontSize', f_size, 'FontName', f_type)
title('Mean Total Error', 'FontSize', f_size, 'FontName', f_type)
filename = 'mean_error';
print(gcf,'-depsc2', filename);


fh = figure(3);
clf;
p5 = semilogy(var_array, '-b', 'LineWidth', 2 );
grid
set(fh, 'Position', [100, 100, pixel_width, pixel_height]);
set(fh, 'PaperUnits', 'centimeters');
set(fh, 'PaperPosition', [0 0 paper_width_cm paper_height_cm]);
xlabel('Measurement', 'FontSize', f_size, 'FontName', f_type)
ylabel('Variance of Area Error', 'FontSize', f_size, 'FontName', f_type)
title('Variance of Total Error', 'FontSize', f_size, 'FontName', f_type)
filename = 'variance_error';
print(gcf,'-depsc2', filename);

