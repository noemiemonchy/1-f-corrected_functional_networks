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
    temp = load(specpath.name);
    specparam_hc(subi) = temp.Options.FOOOF;
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
    temp = load(specpath.name);
    specparam_pd(subi) = temp.Options.FOOOF;
    cd ..
    cd ..
end