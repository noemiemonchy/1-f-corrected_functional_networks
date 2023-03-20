%  Add BCT in the path

addpath(genpath(uigetdir))
% Load fc matrices

cd(uigetdir)
outpath = 'Graph_metrics_results/';

thr_fc_HC = load('Thresholded_node_FC_results_HC.mat');
thr_fc_PD = load('Thresholded_node_FC_results_PD.mat');
thr_fc_1f_HC = load('Thresholded_node_1f_FC_results_HC.mat');
thr_fc_1f_PD = load('Thresholded_node_1f_FC_results_PD.mat');

% Mat size : nsub * fc method * nROI * nROI * frequencies


% Create a csv file containing ROI-averaged graph metrics values
% with headers:
% Sub, Gp, Thresh_meth(node or node+1/f), FC_meth(5), Frequencies(5),
% mean_degree, mean_strength, mean_clustering, path, mean_betweenness

group = {'HC', 'PD'};
thresh_meth = {'node', 'node_1f'};
fc_meth = {'plv', 'wpli', 'ciplv', 'oenv', 'henv'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows

varnames = {'sub', 'group','thresh_met', 'fc_meth', ...
    'frequencies', 'mean_degree', 'mean_strength', 'mean_clustering',...
    'path', 'mean_betweenness'};
vartypes = {'double', 'string',...
    'string','string','string','double','double','double','double','double'};

t = table('Size', [10000, 10], 'VariableTypes', vartypes, 'VariableNames', varnames);
% HC
% thresh node
for subi = 1 : size(thr_fc_HC.thresh_node_mats, 1)
    for fci = 1 : size(thr_fc_HC.thresh_node_mats, 2)
        for freqi = 1 : size(thr_fc_HC.thresh_node_mats, 5)
            sub = subi ;
            gp = 'HC';
            thr = 'node';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            mdeg = mean(degrees_und(squeeze(thr_fc_HC.thresh_node_mats(subi,fci,:,:,freqi))));
            mstr = mean(strengths_und(squeeze(thr_fc_HC.thresh_node_mats(subi,fci,:,:,freqi))));
            mclu = mean(clustering_coef_wu(squeeze(thr_fc_HC.thresh_node_mats(subi,fci,:,:,freqi))));
            path = charpath(squeeze(thr_fc_HC.thresh_node_mats(subi,fci,:,:,freqi)));
            mbet = mean(betweenness_wei(squeeze(thr_fc_HC.thresh_node_mats(subi,fci,:,:,freqi))));
            t(i,:) = {sub, gp, thr, fc, freq, mdeg, mstr, mclu, path, mbet};
            i = i+1;
        end
    end
end
% thresh node 1/f
for subi = 1 : size(thr_fc_1f_HC.thresh_node_1f_mats, 1)
    for fci = 1 : size(thr_fc_1f_HC.thresh_node_1f_mats, 2)
        for freqi = 1 : size(thr_fc_1f_HC.thresh_node_1f_mats, 5)
            sub = subi ;
            gp = 'HC';
            thr = 'node_1f';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            mdeg = mean(degrees_und(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            mstr = mean(strengths_und(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            mclu = mean(clustering_coef_wu(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            path = charpath(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(subi,fci,:,:,freqi)));
            mbet = mean(betweenness_wei(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            t(i,:) = {sub, gp, thr, fc, freq, mdeg, mstr, mclu, path, mbet};
            i = i+1;
        end
    end
end
% PD
% thresh node
for subi = [1 : 7, 9: size(thr_fc_PD.thresh_node_mats, 1)]
    for fci = 1 : size(thr_fc_PD.thresh_node_mats, 2)
        for freqi = 1 : size(thr_fc_PD.thresh_node_mats, 5)
            
            sub = subi ;
            gp = 'PD';
            thr = 'node';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            mdeg = mean(degrees_und(squeeze(thr_fc_PD.thresh_node_mats(subi,fci,:,:,freqi))));
            mstr = mean(strengths_und(squeeze(thr_fc_PD.thresh_node_mats(subi,fci,:,:,freqi))));
            mclu = mean(clustering_coef_wu(squeeze(thr_fc_PD.thresh_node_mats(subi,fci,:,:,freqi))));
            path = charpath(squeeze(thr_fc_PD.thresh_node_mats(subi,fci,:,:,freqi)));
            mbet = mean(betweenness_wei(squeeze(thr_fc_PD.thresh_node_mats(subi,fci,:,:,freqi))));
            t(i,:) = {sub, gp, thr, fc, freq, mdeg, mstr, mclu, path, mbet};
            i = i+1;
        end
    end
end
% thresh node 1/f
for subi = [1 : 7, 9:size(thr_fc_1f_PD.thresh_node_1f_mats, 1)]
    for fci = 1 : size(thr_fc_1f_PD.thresh_node_1f_mats, 2)
        for freqi = 1 : size(thr_fc_1f_PD.thresh_node_1f_mats, 5)
            
            sub = subi ;
            gp = 'PD';
            thr = 'node_1f';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            mdeg = mean(degrees_und(squeeze(thr_fc_1f_PD.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            mstr = mean(strengths_und(squeeze(thr_fc_1f_PD.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            mclu = mean(clustering_coef_wu(squeeze(thr_fc_1f_PD.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            path = charpath(squeeze(thr_fc_1f_PD.thresh_node_1f_mats(subi,fci,:,:,freqi)));
            mbet = mean(betweenness_wei(squeeze(thr_fc_1f_PD.thresh_node_1f_mats(subi,fci,:,:,freqi))));
            t(i,:) = {sub, gp, thr, fc, freq, mdeg, mstr, mclu, path, mbet};
            i = i+1;
            
        end
    end
end

graph_t = rmmissing(t);
writetable(graph_t, [outpath, '/graph_table.csv']);


% Create a nsub*gp (1 = HC, 2 = PD) *thresh (1=node, 2 = node_1f)*
% fc (1 ='plv', 2='wpli', 3='ciplv', 4='oenv', 5='henv')*
% freq (1 = delta, 2=theta, 3=alpha, 4=beta, 5=gamma)
% *68 matrix with condition specific
% degrees, to investigate degree distribution

degree_dist = zeros(30, 2, 2, 5, 5, 68);

for subi = 1 : size(thr_fc_HC.thresh_node_mats, 1)
    for fci = 1 : size(thr_fc_HC.thresh_node_mats, 2)
        for freqi = 1 : size(thr_fc_HC.thresh_node_mats, 5)
            degree_dist(subi, 1, 1, fci, freqi, :) = degrees_und(squeeze(thr_fc_HC.thresh_node_mats(subi,fci,:,:,freqi)));
        end
    end
end
% thresh node 1/f
for subi = 1 : size(thr_fc_1f_HC.thresh_node_1f_mats, 1)
    for fci = 1 : size(thr_fc_1f_HC.thresh_node_1f_mats, 2)
        for freqi = 1 : size(thr_fc_1f_HC.thresh_node_1f_mats, 5)
            degree_dist(subi, 1, 2, fci, freqi, :) = degrees_und(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(subi,fci,:,:,freqi)));
        end
    end
end
% PD
% thresh node
for subi = [1 : 7, 9: size(thr_fc_PD.thresh_node_mats, 1)]
    for fci = 1 : size(thr_fc_PD.thresh_node_mats, 2)
        for freqi = 1 : size(thr_fc_PD.thresh_node_mats, 5)
            degree_dist(subi, 2, 1, fci, freqi, :) = degrees_und(squeeze(thr_fc_PD.thresh_node_mats(subi,fci,:,:,freqi)));
        end
    end
end
% thresh node 1/f
for subi = [1 : 7, 9:size(thr_fc_1f_PD.thresh_node_1f_mats, 1)]
    for fci = 1 : size(thr_fc_1f_PD.thresh_node_1f_mats, 2)
        for freqi = 1 : size(thr_fc_1f_PD.thresh_node_1f_mats, 5)
            degree_dist(subi, 2, 2, fci, freqi, :) = degrees_und(squeeze(thr_fc_1f_PD.thresh_node_1f_mats(subi,fci,:,:,freqi)));
        end
    end
end

save('degree_dist.mat', 'degree_dist');



%% Get % of nodes retained from the 5% thresholded mat after 1/f thresh

% n possible connections
npc = ((68^2)/2) - (68/2);

% n connections remaining after 5% thresh
nthresh_5 = round((5 * npc)/100);


%% Number of nodes with true oscillations


group = {'HC', 'PD'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows

varnames = {'sub', 'group', ...
    'frequencies', 'n_nodes_kept', };
vartypes = {'double', 'string',...
    'string','double'};

t = table('Size', [10000, 4], 'VariableTypes', vartypes, 'VariableNames', varnames);
% for HC
for subi = 1:size(spec_mat_HC.new_spec_mat, 1)
    for freqi = 1:size(spec_mat_HC.new_spec_mat, 2)
        
        % get temp mat
        temp = squeeze(new_spec_mat(subi,freqi,:,:));
        % store number of nodes kept after 1/f
        nnode = nnz(sum(temp)); % nnz counts non zero elements
        
        sub = subi ;
        gp = 'HC';
        freq = frequencies{freqi};
        t(i,:) = {sub, gp, freq, nnode};
        i = i+1;
    end
    
end


% for PD
for subi = 1:size(spec_mat_PD.new_spec_mat, 1)
    for freqi = 1:size(spec_mat_PD.new_spec_mat, 2)
        
        % get temp mat
        temp = squeeze(new_spec_mat(subi,freqi,:,:));
        % store number of nodes kept after 1/f
        nnode = nnz(sum(temp)); % nnz counts non zero elements
        
        sub = subi ;
        gp = 'PD';
        freq = frequencies{freqi};
        t(i,:) = {sub, gp, freq, nnode};
        i = i+1;
    end
    
end

graph_t = rmmissing(t);
writetable(graph_t, [outpath, '/graph_table_nodes_kept_1f_only.csv']);

%% Overall n connections remaining after 1/f thresh

% load
spec_mat_HC = load('new_specmat_HC.mat');
spec_mat_PD = load('new_specmat_PD.mat');


group = {'HC', 'PD'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows

varnames = {'sub', 'group', ...
    'frequencies', 'pct_cx_kept_only1f', };
vartypes = {'double', 'string',...
    'string','double'};

t = table('Size', [10000, 4], 'VariableTypes', vartypes, 'VariableNames', varnames);

% Create output matrix

nconn_1f_global = zeros(size(new_spec_mat, 1), ...
    size(new_spec_mat, 2));

% For HC
for subi = 1:size(spec_mat_HC.new_spec_mat, 1)
    for freqi = 1:size(spec_mat_HC.new_spec_mat, 2)
        
        % get temp mat
        temp = squeeze(spec_mat_HC.new_spec_mat(subi,freqi,:,:));
        
        % keep lower triangular part
        temp_tri = tril(temp);
        n = size(temp_tri, 1);
        temp_tri(1:n+1:end) = 0; % clear diagonal
        
        % store proportion of connections kept after 1/f
        nconn_1f_global = (nnz(temp_tri) * 100) / npc; % nnz counts non zero elements
        sub = subi ;
        gp = 'HC';
        freq = frequencies{freqi};
        t(i,:) = {sub, gp, freq, nconn_1f_global};
        i = i+1;
        
        
    end
    
end

% For PD
for subi = 1:size(spec_mat_PD.new_spec_mat, 1)
    for freqi = 1:size(spec_mat_PD.new_spec_mat, 2)
        
        % get temp mat
        temp = squeeze(spec_mat_PD.new_spec_mat(subi,freqi,:,:));
        
        % keep lower triangular part
        temp_tri = tril(temp);
        n = size(temp_tri, 1);
        temp_tri(1:n+1:end) = 0; % clear diagonal
        
        % store proportion of connections kept after 1/f
        nconn_1f_global = (nnz(temp_tri) * 100) / npc; % nnz counts non zero elements
        sub = subi ;
        gp = 'PD';
        freq = frequencies{freqi};
        t(i,:) = {sub, gp, freq, nconn_1f_global};
        i = i+1;
        
        
    end
    
end

graph_t = rmmissing(t);
writetable(graph_t, [outpath, '/graph_table_connexions_kept_1f_only.csv']);


%% n connections remaining after 5% and 1/f thresh

% Create table

thr_fc_1f_HC = load('Thresholded_node_1f_FC_results_HC.mat');
thr_fc_1f_PD = load('Thresholded_node_1f_FC_results_PD.mat');


group = {'HC', 'PD'};
fc_meth = {'plv', 'wpli', 'ciplv', 'oenv', 'henv'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

i = 1; % initiate counter to fill rows

varnames = {'sub', 'group', 'fc_meth', ...
    'frequencies', 'pct_cx_kept', };
vartypes = {'double', 'string',...
    'string','string','double'};

t = table('Size', [10000, 5], 'VariableTypes', vartypes, 'VariableNames', varnames);
% For HC
for subi = 1:size(thr_fc_1f_HC.thresh_node_1f_mats, 1)
    for freqi = 1:size(thr_fc_1f_HC.thresh_node_1f_mats, 5)
        for fci = 1: size(thr_fc_1f_HC.thresh_node_1f_mats, 2)
            
            % get temp mat
            temp = squeeze(thr_fc_1f_HC.thresh_node_1f_mats(subi,fci,:,:,freqi));
            
            % keep lower triangular part
            temp_tri = tril(temp);
            
            % binarize
            temp_tri_bin = logical(temp_tri);
            
            % store proportion of connections kept after 1/f
            nconn_pthresh_1f = (nnz(temp_tri_bin) * 100) / npc;
            
            sub = subi ;
            gp = 'HC';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            t(i,:) = {sub, gp, fc, freq, nconn_pthresh_1f};
            i = i+1;
            
        end
    end
    
end

% For PD
for subi = 1:size(thr_fc_1f_PD.thresh_node_1f_mats, 1)
    for freqi = 1:size(thr_fc_1f_PD.thresh_node_1f_mats, 5)
        for fci = 1: size(thr_fc_1f_PD.thresh_node_1f_mats, 2)
            
            % get temp mat
            temp = squeeze(thr_fc_1f_PD.thresh_node_1f_mats(subi,fci,:,:,freqi));
            
            % keep lower triangular part
            temp_tri = tril(temp);
            
            % binarize
            temp_tri_bin = logical(temp_tri);
            
            % store proportion of connections kept after 1/f
            nconn_pthresh_1f = (nnz(temp_tri_bin) * 100) / npc;
            
            sub = subi ;
            gp = 'PD';
            fc = fc_meth{fci};
            freq = frequencies{freqi};
            t(i,:) = {sub, gp, fc, freq, nconn_pthresh_1f};
            i = i+1;
            
        end
    end
    
end

graph_t = rmmissing(t);
writetable(graph_t, [outpath, '/graph_table_connexions_kept_5pct_and_1f.csv']);

