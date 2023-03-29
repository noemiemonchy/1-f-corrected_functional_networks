%% Plot aperiodic data on cortex

% Uses the Simple Brain Plot toolbox

%% Add GitHub folder to path

path = uigetdir;
addpath(genpath(path));


%% Add Simple Brain Plot to path

path = uigetdir;
addpath(genpath(path));

load('regionDescriptions.mat')
regionDescriptions.aparc_aseg(1:14)=[];



%% Define colormap

cm = plasma;

%% Create a group-averaged exponent and offset

% for HC

path = uigetdir;
cd(path);

load('specparam_hc.mat')

% exponent
exponent_hc = zeros(length(specparam_hc), 68);

for subi = 1:size(exponent_hc,1)
    exponent_hc(subi, : ) = [specparam_hc(subi).aperiodics.exponent];
end

offset_hc = zeros(length(specparam_hc), 68);

for subi = 1:size(offset,1)
    offset_hc(subi, : ) = [specparam_hc(subi).aperiodics.offset];
end

% brain plots

plotBrain(regionDescriptions.aparc_aseg, mean(exponent_hc,1), cm, 'atlas', 'aparc', 'limits', [0.6, 1.2])
plotBrain(regionDescriptions.aparc_aseg, mean(offset_hc,1), cm, 'atlas', 'aparc', 'limits', [-23, -19])


% for PD

path = uigetdir;
cd(path);

load('specparam_pd.mat')
specparam_pd(8) = []; % remove line 8 because subject 8 has no eeg data

% exponent
exponent_pd = zeros(length(specparam_pd), 68);

for subi = 1:size(exponent_pd,1)
    exponent_pd(subi, : ) = [specparam_pd(subi).aperiodics.exponent];
end

offset_pd = zeros(length(specparam_pd), 68);

for subi = 1:size(offset_pd,1)
    offset_pd(subi, : ) = [specparam_pd(subi).aperiodics.offset];
end

% brain plots

plotBrain(regionDescriptions.aparc_aseg, mean(exponent_pd,1), cm, 'atlas', 'aparc', 'limits', [0.6, 1.2])
plotBrain(regionDescriptions.aparc_aseg, mean(offset_pd,1), cm, 'atlas', 'aparc', 'limits', [-23, -19])


%% Create table to get all parameters in a single csv file

% with headers:
% Sub, Gp, mean exponent, mean offset

group = {'HC', 'PD'};

i = 1; % initiate counter to fill rows

varnames = {'sub', 'group','averaged_exponent', 'averaged_offset'};
vartypes = {'double', 'string',...
    'double','double'};

t = table('Size', [10000, 4], 'VariableTypes', vartypes, 'VariableNames', varnames);
% HC
for subi = 1 : size(exponent_hc, 1)
            sub = subi ;
            gp = 'HC';
            averaged_exponent = mean(exponent_hc(subi,:),2);
            averaged_offset = mean(offset_hc(subi,:),2);
            t(i,:) = {sub, gp, averaged_exponent, averaged_offset};
            i = i+1;
end

% PD
for subi = 1 : size(exponent_pd, 1)
            sub = subi ;
            gp = 'PD';
            averaged_exponent = mean(exponent_pd(subi,:),2);
            averaged_offset = mean(offset_pd(subi,:),2);
            t(i,:) = {sub, gp, averaged_exponent, averaged_offset};
            i = i+1;
end

outpath = 'Graph_metrics_results/';
graph_t = rmmissing(t);
writetable(graph_t, [outpath, '/aperiodic_param.csv']);
