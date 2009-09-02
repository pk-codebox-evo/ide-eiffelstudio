function [mdn_of_mdn_cov_simi, std_of_mdn_of_mdn_cov_simi, unvisited_branches] = plot_hard_to_test_branch_coverage_similarity_over_time(classes, faults, branches, start_time, end_time, time_unit, central_method)
% Load branch coverage data.
% `classes' is a cell array containing the list of names of classes.
% `faults' is a cell array containing the fault data of corresponding class in `classes'.
% `branches' is a cell array containing the branch data of corresponding class in `classes'.
% `similarity' is a cell array, each element is a branch coverage similarity table for the corresponding class in `classes' of the form 
% [time, similarity_by_the_end_of_time].

% mdn_cov_simi is a table of the form
% [time, median of medians of branch coverage similarity over classes] 

sz = size (classes);
number_of_class = sz(2);

sz = size (branches{1});
number_of_session =  sz(2);
simi = {};
std_simi = {};
unvisited_branches={};

number_of_time = end_time - start_time + 1;
X=[];
Y=[];
XSD=[];
YSD=[];

for i=1:number_of_class
    bchs = branches{i};
    sz = size (bchs{1});
    number_of_branch = sz(1);
    
    tp = 1;
    simi_table = zeros (number_of_time, 2);
    std_table = zeros (number_of_time, 2);
    for t=start_time:end_time
        bchvector = zeros (number_of_branch, number_of_session);
        branch_untested_times = zeros (number_of_branch, 1);   
        for j=1:number_of_session            
            bch = bchs{j}(:, 3);
            %bch_id = find (bch >= 0 & bch <= t* time_unit);
            bch_id = find (bch <= t* time_unit);
            unvisited_bch_index = find (bch == -1 & bch <= t * time_unit);           
            branch_untested_times(unvisited_bch_index) = branch_untested_times(unvisited_bch_index) + 1;
            bb = zeros (number_of_branch, 1);
            bb (bch_id, 1) = bchs{j}(bch_id, 3);
            bchvector(:, j) = bb;
        end
        simis=zeros (1, number_of_session * (number_of_session -1) /2);
        v = 1;
        for j=1:number_of_session-1
            for k=j+1:number_of_session
              %simis(v) = similarity (bchvector(:, j), bchvector(:, k));  
              ids = find (branch_untested_times >= 1);
              simis(v) = similarity (bchvector(branch_untested_times(ids), j), bchvector(branch_untested_times(ids), k));  
              v = v + 1;
            end
        end
        mm = median (simis);
        bchsd = std (simis);
        simi_table(tp , 1:2) = [t, mm];
        std_table (tp, 1:2) = [t, bchsd];
        tp = tp + 1;
        if t == end_time
           uuid = find (branch_untested_times == 30);
           uu = bchs{1}(uuid, 1);
           unvisited_branches = horzcat(unvisited_branches, {uu});
        end
    end
    simi = horzcat (simi, {simi_table});
    std_simi = horzcat (std_simi, {std_table});
    X=horzcat (X, simi_table(:, 1));
    Y=horzcat (Y, simi_table(:, 2));

    XSD=horzcat (XSD, std_table(:, 1));
    YSD=horzcat (YSD, std_table(:, 2));
end

%Calculate median of branch coverage similarity.
median_of_bch_cov = zeros (number_of_time, 1);
for t=start_time:end_time
    mcv = zeros (1, number_of_class);
    for i=1:number_of_class
        mcv(i) = simi{i}(t, 2);
    end
    mm = median (mcv);
    median_of_bch_cov (t) = mm;
end

simi = horzcat (simi, {median_of_bch_cov});

mdn_of_mdn_cov_simi = horzcat (X(:,1), median_of_bch_cov);

X = horzcat (X, (start_time:end_time)');
Y = horzcat (Y, median_of_bch_cov);

%Calculate median of standard deviation of branch coverage similarity.
median_of_std_bch_cov = zeros (number_of_time, 1);
for t=start_time:end_time
    mcv = zeros (1, number_of_class);
    for i=1:number_of_class
        mcv(i) = std_simi{i}(t, 2);
    end
    mm = median (mcv);
    median_of_std_bch_cov (t) = mm;
end

XSD = horzcat (XSD, (start_time:end_time)');
YSD = horzcat (YSD, median_of_std_bch_cov);

std_of_mdn_of_mdn_cov_simi = horzcat ((start_time:end_time)', median_of_std_bch_cov);
set(gcf,'DefaultAxesColorOrder',[1 1 0; 1 0 1; 0 1 1; 1 0 0; 0 1 0; 0 0 1; 0 0 0; 0.3216 0.1882 0.1882; 0 0.498 0; 0.4784 0.06275 0.8941; 0.04314 0.5176 0.7804; 0.8706 0.4902 0; 0.2 0.2 0; 0 0.4 0.8; 0.6 0 0.2]);
handles = plot (X, Y);

set(handles(number_of_class + 1), 'LineWidth', 2);
set(handles(number_of_class + 1), 'Color', 'k');
lgd_names = horzcat (classes, {'Median of medians'});

%Setup legends.
legend (handles, lgd_names, 'Location', 'NortheastOutside');

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

%Setup Y-axis label.
ylabel ('Similarity of difficult to exercise branches', 'FontSize', 12);
xlim([1, 360]);
ylim([0.8,1.02]);
set(gca,'XTick',[0:30:360]);

%Plot standard deviation of branch coverage.
figure
%YSD = YSD ./ Y .* 100
set(gcf,'DefaultAxesColorOrder',[1 1 0; 1 0 1; 0 1 1; 1 0 0; 0 1 0; 0 0 1; 0 0 0; 0.3216 0.1882 0.1882; 0 0.498 0; 0.4784 0.06275 0.8941; 0.04314 0.5176 0.7804; 0.8706 0.4902 0; 0.2 0.2 0; 0 0.4 0.8; 0.6 0 0.2]);
std_handles = plot (XSD, YSD);

%Setup legends.
std_lgd_names = horzcat (classes, {'Median of stdev'});
legend (std_handles, std_lgd_names, 'Location', 'NortheastOutside');
set(std_handles(number_of_class + 1), 'LineWidth', 2);
set(std_handles(number_of_class + 1), 'Color', 'k');

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
xlim([start_time, end_time]);
ylim([-0.1,0.5]);

%Setup Y-axis label.
ylabel ('Standard deviation of similarity', 'FontSize', 12);
set(gca,'XTick',[0:30:360]);



