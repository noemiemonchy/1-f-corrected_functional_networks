path = uigetdir;
cd(path)
sublist = dir('sub*');
nsub =  length(sublist);

freqranges = {[2, 4], [5, 7], [8, 12], [13, 29], [30, 45]};
nfreq = length(freqranges);
spec_mat = zeros(nsub, nfreq, 68, 68);

for subi = [1 : 7, 9:nsub]
    cd(sublist(subi).name)
    subpath = dir('sub*');
    cd(subpath(1).name)
    specpath = dir('*specparam*.mat');
    load(specpath.name)
    
for nROI = 1:68
    
    temp = Options.FOOOF.data(nROI).peak_params;
    npeaks = size(temp, 1);        
    n = 1;
    for peaks = 1:npeaks
        
        for frange = 1:length(freqranges)
            
            if freqranges{frange}(1) < temp(n) && temp(n) < freqranges{frange}(2)
                spec_mat(subi, frange, nROI, :) = repmat(1, 68, 1);
                spec_mat(subi, frange, :, nROI) = repmat(1, 68, 1);
            end

        end
        n = n+1;
    end
    
end
cd ..
cd ..
end