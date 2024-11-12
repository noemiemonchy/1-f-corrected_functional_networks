%  Add BCT in the path
addpath(genpath(uigetdir))
% Load fc matrices

cd(uigetdir)
outpath = 'Graph_metrics_results/';

thr_fc_SRM = load('Thresholded_prop_5_FC_results_SRM.mat');
thr_fc_1f_SRM = load('Thresholded_1f_prop_5_FC_results_SRM.mat');

% Mat size : nsub * fc method * nROI * nROI * frequencies

% Create a csv file containing ROI-averaged graph metrics values
% with headers:
% Sub, Gp, Thresh_meth(node or node+1/f), FC_meth(5), Frequencies(5),
% mean_degree, mean_strength, mean_clustering, path, mean_betweenness

thresh_meth = {'prop', '1f_prop'};
fc_meth = {'plv', 'wpli', 'ciplv', 'oenv', 'henv'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows
% add variable 'group' for dataset A
varnames = {'sub','thresh_met', 'fc_meth', ...
    'frequencies', 'mean_clustering',...
    'path', 'mean_betweenness','global_efficiency'};
vartypes = {'double',...
    'string','string','string','double','double','double','double'};

t = table('Size', [5500, 8], 'VariableTypes', vartypes, 'VariableNames', varnames);

% thresh prop
for subi = 1 : size(thr_fc_SRM.thresh_node_mats, 1)
    for fci = 1 : size(thr_fc_SRM.thresh_node_mats, 2)
        for freqi = 1 : size(thr_fc_SRM.thresh_node_mats, 5)
            sub = subi ;
            thr = 'prop';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            mclu = mean(clustering_coef_wu(squeeze(thr_fc_SRM.thresh_node_mats(subi,fci,:,:,freqi))));
            path = charpath(squeeze(thr_fc_SRM.thresh_node_mats(subi,fci,:,:,freqi)));
            mbet = mean(betweenness_wei(squeeze(thr_fc_SRM.thresh_node_mats(subi,fci,:,:,freqi))));
            effi = mean(efficiency_wei(squeeze(thr_fc_SRM.thresh_node_mats(subi,fci,:,:,freqi))));
            t(i,:) = {sub, thr, fc, freq, mclu, path, mbet, effi};
            i = i+1;
        end
    end
end

% thresh 1/f prop
for subi = 1 : size(thr_fc_1f_SRM.thresh_node_1f_mats, 1)
    for fci = 1 : size(thr_fc_1f_SRM.thresh_node_1f_mats, 2)
        for freqi = 1 : size(thr_fc_1f_SRM.thresh_node_1f_mats, 5)
            sub = subi ;
            thr = '1f_prop';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            mdeg = mean(degrees_und(squeeze(thr_fc_1f_SRM.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            mclu = mean(clustering_coef_wu(squeeze(thr_fc_1f_SRM.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            path = charpath(squeeze(thr_fc_1f_SRM.thresh_node_1f_mats(subi,fci,:,:,freqi)));
            mbet = mean(betweenness_wei(squeeze(thr_fc_1f_SRM.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            effi = mean(efficiency_wei(squeeze(thr_fc_1f_SRM.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            t(i,:) = {sub, thr, fc, freq, mclu, path, mbet, effi};
            i = i+1;
        end
    end
end

graph_t = rmmissing(t);
writetable(graph_t, 'graph_table_SRM.csv');

%% Get % of nodes retained from the 5% thresholded mat after 1/f thresh

% n possible connections
npc = ((68^2)/2) - (68/2);

% n connections remaining after 5% thresh
nthresh_5 = round((5 * npc)/100);


%% Number of nodes with true oscillations
spec_mat_SRM = load('new_spec_mat_SRM');

frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows

varnames = {'sub', ...
    'frequencies', 'n_nodes_kept', };
vartypes = {'double',...
    'string','double'};

t = table('Size', [10000, 3], 'VariableTypes', vartypes, 'VariableNames', varnames);

for subi = 1:size(spec_mat_SRM.new_spec_mat, 1)
    for freqi = 1:size(spec_mat_SRM.new_spec_mat, 2)
        
        % get temp mat
        temp = squeeze(spec_mat_SRM.new_spec_mat(subi,freqi,:,:));
        % store number of nodes kept after 1/f
        nnode = nnz(sum(temp)); % nnz counts non zero elements
        
        sub = subi ;
        freq = frequencies{freqi};
        t(i,:) = {sub, freq, nnode};
        i = i+1;
    end
    
end


graph_t = rmmissing(t);
writetable(graph_t, 'graph_table_nodes_kept_1f_only_SRM.csv');

%% Overall n connections remaining after 1/f thresh

% load
spec_mat_SRM = load('new_spec_mat_SRM.mat');

frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows

varnames = {'sub', ...
    'frequencies', 'pct_cx_kept_only1f', };
vartypes = {'double',...
    'string','double'};

t = table('Size', [10000, 3], 'VariableTypes', vartypes, 'VariableNames', varnames);

% Create output matrix

nconn_1f_global = zeros(size(spec_mat_SRM.new_spec_mat, 1), ...
    size(spec_mat_SRM.new_spec_mat, 2));

% For HC
for subi = 1:size(spec_mat_SRM.new_spec_mat, 1)
    for freqi = 1:size(spec_mat_SRM.new_spec_mat, 2)
        
        % get temp mat
        temp = squeeze(spec_mat_SRM.new_spec_mat(subi,freqi,:,:));
        
        % keep lower triangular part
        temp_tri = tril(temp);
        n = size(temp_tri, 1);
        temp_tri(1:n+1:end) = 0; % clear diagonal
        
        % store proportion of connections kept after 1/f
        nconn_1f_global = (nnz(temp_tri) * 100) / npc; % nnz counts non zero elements
        sub = subi ;
        freq = frequencies{freqi};
        t(i,:) = {sub, freq, nconn_1f_global};
        i = i+1;
        
        
    end
    
end

graph_t = rmmissing(t);
writetable(graph_t, 'graph_table_connexions_kept_1f_only_SRM.csv');


%% n connections remaining after 5% and 1/f thresh

% Create table

thr_fc_1f_SRM = load('Thresholded_1f_prop_5_FC_results_SRM.mat');

fc_meth = {'plv', 'wpli', 'ciplv', 'oenv', 'henv'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows

varnames = {'sub', 'fc_meth', ...
    'frequencies', 'pct_cx_kept', };
vartypes = {'double',...
    'string','string','double'};

t = table('Size', [10000, 4], 'VariableTypes', vartypes, 'VariableNames', varnames);
% For HC
for subi = 1:size(thr_fc_1f_SRM.thresh_node_1f_mats, 1)
    for freqi = 1:size(thr_fc_1f_SRM.thresh_node_1f_mats, 5)
        for fci = 1: size(thr_fc_1f_SRM.thresh_node_1f_mats, 2)
            
            % get temp mat
            temp = squeeze(thr_fc_1f_SRM.thresh_node_1f_mats(subi,fci,:,:,freqi));
            
            % keep lower triangular part
            temp_tri = tril(temp);
            
            % binarize
            temp_tri_bin = logical(temp_tri);
            
            % store proportion of connections kept after 1/f
            nconn_pthresh_1f = (nnz(temp_tri_bin) * 100) / npc;
            
            sub = subi ;
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            t(i,:) = {sub, fc, freq, nconn_pthresh_1f};
            i = i+1;
            
        end
    end
    
end


graph_t = rmmissing(t);
writetable(graph_t, 'graph_table_connexions_kept_5pct_and_1f_SRM.csv');



