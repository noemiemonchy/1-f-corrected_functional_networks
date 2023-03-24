%% Check if beta oscillations are alpha harmonics

hzbin = 0.5;

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
        harmo_count = 0;
        temp = Options.FOOOF.data(nROI).peak_params;
        npeaks = size(temp, 1);
        n = 1;
        
        if npeaks == 1
            harmo_hc(subi, nROI) = 0;
        end
        
        isInside = discretize(beta, [(alpha*2)-hzbin,(alpha*2)+hzbin])==1;
        
        if npeaks > 1
            
            for peaki = 2:npeaks
                if freqranges{4}(1)<temp(peaki,1)<freqranges{4}(2)
                    beta = temp(peaki,1);
                    if discretize(beta, [(alpha*2)-hzbin,(alpha*2)+hzbin])==1
                        harmo_count=harmo_count+1;
                    end
                end
                
            end
            
        end
        harmo_hc(subi, nROI) = harmo_count;
    end
    
    cd ..
    cd ..
end


%% for PD

path = uigetdir;
cd(path)
sublist = dir('sub*');
nsub =  length(sublist);
nROIs = 68;

freqranges = {[2, 4], [5, 7], [8, 12], [13, 29], [30, 45]};
harmo_pd = zeros(nsub, nROIs);


for subi = [1 :7, 9:nsub]
    cd(sublist(subi).name)
    subpath = dir('sub*');
    cd(subpath(1).name)
    specpath = dir('*specparam*.mat');
    load(specpath.name)
    
    for nROI = 1:68
        harmo_count = 0;
        temp = Options.FOOOF.data(nROI).peak_params;
        npeaks = size(temp, 1);
        n = 1;
        
        if npeaks == 1
            harmo_hc(subi, nROI) = 0;
        end
        
        isInside = discretize(beta, [(alpha*2)-hzbin,(alpha*2)+hzbin])==1;
        
        if npeaks > 1
            
            for peaki = 2:npeaks
                if freqranges{4}(1)<temp(peaki,1)<freqranges{4}(2)
                    beta = temp(peaki,1);
                    if discretize(beta, [(alpha*2)-hzbin,(alpha*2)+hzbin])==1
                        harmo_count=harmo_count+1;
                    end
                end
                
            end
            
        end
        harmo_pd(subi, nROI) = harmo_count;
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
                
                
                % refaire avec compris entre tant et tant en prenant un bin
                % fréquentiel ??
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


