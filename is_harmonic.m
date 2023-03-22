%% Check if beta oscillations are alpha harmonics


%% for HC

path = uigetdir;
cd(path)
sublist = dir('sub*');
nsub =  length(sublist);
nROIs = 68;

freqranges = {[2, 4], [5, 7], [8, 12], [13, 29], [30, 45]};
harmo_hc = zeros(nsub, nROIs);

for subi = 1 :nsub
    cd(sublist(subi).name)
    subpath = dir('sub*');
    cd(subpath(1).name)
    specpath = dir('*specparam*.mat');
    load(specpath.name)
    
    for nROI = 1:68
        
        temp = Options.FOOOF.data(nROI).peak_params;
        npeaks = size(temp, 1);
        n = 1;
        
        if npeaks == 1
            harmo_hc(subi, nROI) = 0;
        end
        
        if npeaks > 1
            if freqranges{4}(1)<temp(2,1)<freqranges{4}(2)
                if mod(temp(2,1)/temp(1,1),1)==0
                    harmo_hc(subi, nROI) = 1;
                else
                    harmo_hc(subi, nROI) = 0;
                end
            end
        end
    end
 
    cd ..
    cd ..
end

%% Check if any beta peaks is a harmonic of another alpha peak ?

% List all the second peaks

% List all the first peaks




%% Same for PD

path = uigetdir;
cd(path)
sublist = dir('sub*');
nsub =  length(sublist);
nROIs = 68;

freqranges = {[2, 4], [5, 7], [8, 12], [13, 29], [30, 45]};
nfreq = length(freqranges);
harmo_pd = zeros(nsub, nROIs);

for subi = [1 :7, 9:nsub]
    cd(sublist(subi).name)
    subpath = dir('sub*');
    cd(subpath(1).name)
    specpath = dir('*specparam*.mat');
    load(specpath.name)
    
    for nROI = 1:68
        
        temp = Options.FOOOF.data(nROI).peak_params;
        npeaks = size(temp, 1);
        n = 1;
        
        if npeaks == 1
            harmo_pd(subi, nROI) = 0;
        end
        
        if npeaks > 1
            if freqranges{4}(1)<temp(2,1)<freqranges{4}(2)
                if mod(temp(2,1)/temp(1,1),1)==0
                    harmo_pd(subi, nROI) = 1;
                else
                    harmo_pd(subi, nROI) = 0;
                end
            end
        end
    end
 
    cd ..
    cd ..
end


