%% Get specparam aperiodic parameters for HC and PD

%% For HC
path = uigetdir;
cd(path)
sublist = dir('sub*');
nsub =  length(sublist);

for subi = [1 :nsub]
    cd(sublist(subi).name)
    subpath = dir('sub*');
    cd(subpath(1).name)
    specpath = dir('*specparam*.mat');
    temp_source = load(specpath(1).name);
    temp_chan = load(specpath(2).name);
    specparam_source_hc(subi).spec = temp_source.Options.FOOOF;
    specparam_source_hc(subi).sub = subpath(1).name(1:7);
    specparam_source_hc(subi).group = 'HC';    
    specparam_scalp_hc(subi).spec = temp_chan.Options.FOOOF;
    specparam_scalp_hc(subi).sub = subpath(1).name(1:7);
    specparam_scalp_hc(subi).group = 'HC';    
    cd ..
    cd ..
end

%% For PD
path = uigetdir;
cd(path)
sublist = dir('sub*');
nsub =  length(sublist);

for subi = [1 : 7, 9:nsub]
    cd(sublist(subi).name)
    subpath = dir('sub*');
    cd(subpath(1).name)
    specpath = dir('*specparam*.mat');
    temp_source = load(specpath(1).name);
    temp_chan = load(specpath(2).name);
    specparam_source_pd(subi).spec = temp_source.Options.FOOOF;
    specparam_source_pd(subi).sub = subpath(1).name(1:7);
    specparam_source_pd(subi).group = 'PD';    
    specparam_scalp_pd(subi).spec = temp_chan.Options.FOOOF;
    specparam_scalp_pd(subi).sub = subpath(1).name(1:7);
    specparam_scalp_pd(subi).group = 'PD';    
    cd ..
    cd ..
end

specparam_source_pd(8) = [];