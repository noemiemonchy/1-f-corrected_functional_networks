%  Add BCT in the path

addpath(genpath(uigetdir))
% Load fc matrices

cd(uigetdir)
outpath = 'Graph_metrics_results/';

thr_fc_HC = load('Thresholded_node_FC_results_HC.mat');
thr_fc_PD = load('Thresholded_node_FC_results_PD.mat');
thr_fc_1f_HC = load('Thresholded_node_1f_FC_results_HC.mat');
thr_fc_1f_PD = load('Thresholded_node_1f_FC_results_PD.mat');


% Create a csv file containing ROI-averaged graph metrics values
% with headers:
% Sub, Gp, Thresh_meth(node or node+1/f), FC_meth(5), Frequencies(5),
% mean_degree, mean_strength, mean_clustering, path, mean_betweenness

group = {'HC', 'PD'};
thresh_meth = {'node', 'node_1f'};
fc_meth = {'plv', 'wpli', 'ciplv', 'oenv', 'henv'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};



% Create a nsub*gp*thresh*fc*freq*68 matrix with condition specific
% degrees, to investigate degree distribution



% degree

deg = degrees_und(squeeze(thr_fc_HC.thresh_node_mats(1,1,:,:,4)));
deg2 = degrees_und(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(1,1,:,:,4)));

% strength

strength = strengths_und(squeeze(thr_fc_HC.thresh_node_mats(1,1,:,:,4)));
strength2 = strengths_und(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(1,1,:,:,4)));

% clustering coefficient

clu = clustering_coef_wu(squeeze(thr_fc_HC.thresh_node_mats(1,1,:,:,4)));
clu2 = clustering_coef_wu(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(1,1,:,:,4)));

% path length
path = charpath(squeeze(thr_fc_HC.thresh_node_mats(1,1,:,:,5)));
path2 = charpath(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(1,1,:,:,5)));

% betweenness centrality
betw = betweenness_wei(squeeze(thr_fc_HC.thresh_node_mats(1,1,:,:,3)));
betw2 = betweenness_wei(squeeze(thr_fc_1f_HC.thresh_node_1f_mats(1,1,:,:,3)));
% Graph distance ?