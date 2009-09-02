function [mdn_of_mdn_of_cov, mdn_of_mdn_of_cov_end, stdev_of_mdn_of_cov_end, coef_of_var_of_mdn_of_cov_end, min_mdn_cov_end, max_mdn_cov_end, bc] = plot_branch_coverage_over_time(classes, faults, branches, start_time, end_time, time_unit, central_method)
% Load branch coverage data.
% `classes' is a cell array containing the list of names of classes.
% `faults' is a cell array containing the fault data of corresponding class in `classes'.
% `branches' is a cell array containing the branch data of corresponding class in `classes'.
% Return values:
% mdn_of_mdn_of_cov is a table of the form 
% [time, median of median of coverage level over time], it describes the
% overall branch coverage trend for all classes.
% mdn_of_mdn_of_cov_end is the median of medians of branch coverage level
% at the end time slot over all classes. 
% stdev_of_mdn_of_cove_end is the standard deviation of medians of branch
% coverage level at the end time slot.
% coef_of_var_of_mdn_of_cov_end is the cofficient of variation of median of
% medians of branch coverage level at the end time slot.
% min_mdn_cov_end is the minimal branch coverage level over all classes at
% the end time slot.
% max_mdn_cov_end is the maximal branch coverage level over all classes at
% the end time slot.


sz = size (classes);
number_of_class = sz(2);

X=[];
Y=[];

bc=zeros(number_of_class, 1);

for i=1:number_of_class
    [cf, cb] = central_branch_coverage_data (faults{i}, branches{i}, start_time, end_time, time_unit, central_method);
    sz = size (branches{i}{1});
    number_of_branch = sz(1);
    
    X = horzcat (X, cb{1}(:, 1));
    Y = horzcat (Y, (cb{1}(:, 2) ./ number_of_branch));
    bc(i) = Y(end_time - start_time + 1, i);
end

%Calculate result values.
sz = size (Y);
number_of_time = sz(1);

mdn_end = Y (number_of_time, :);
mdn_of_mdn_of_cov_end = median(mdn_end);
stdev_of_mdn_of_cov_end = std (mdn_end);
coef_of_var_of_mdn_of_cov_end = stdev_of_mdn_of_cov_end / mdn_of_mdn_of_cov_end * 100;
min_mdn_cov_end = min (mdn_end);
max_mdn_cov_end = max (mdn_end);

%Calculate the median of branch coverage over time.
X = horzcat (X, cb{1}(:, 1));

mcov = zeros(number_of_time, 1);

for i=1:number_of_time
    mm = Y(i, :);
    mcov(i) = median (mm);
end
Y = horzcat (Y, mcov);

%Calculate result values.
mdn_of_mdn_of_cov = horzcat (X(:,1), mcov);

%Plot graph.
figure
set(gcf,'DefaultAxesColorOrder',[1 1 0; 1 0 1; 0 1 1; 1 0 0; 0 1 0; 0 0 1; 0 0 0; 0.3216 0.1882 0.1882; 0 0.498 0; 0.4784 0.06275 0.8941; 0.04314 0.5176 0.7804; 0.8706 0.4902 0; 0.2 0.2 0; 0 0.4 0.8; 0.6 0 0.2]);
handles = plot (X, Y);

%Set properties for the curve of median of medians of branch coverage
%level.
set (handles(number_of_class+1), 'LineWidth', 2);
set (handles(number_of_class+1), 'Color', 'k');

%Setup legends.
lgd_names =horzcat (classes, {'Median of medians'});
legend (handles, lgd_names, 'Location', 'NortheastOutside', 'FontSize', 10);

%Setup X-axis label.
if time_unit == 1
    time_label = 'Time (seconds)';
elseif time_unit == 60
    time_label = 'Time (minutes)';
elseif time_unit == 3600 
    time_label = 'Time (hours)';
else
    time_label = 'Time';
end
xlabel (time_label);
xlim ([0, 360]);
set(gca,'XTick',[0:30:360])
ylim ([0.5, 1.1]);
%Setup Y-axis label.
ylabel ('Branch coverage level', 'FontSize', 12);





