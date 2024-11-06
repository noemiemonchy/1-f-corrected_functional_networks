%  Add BCT in the path

addpath(genpath(uigetdir))

% load files

cd(uigetdir) % go where the following file are stored
% here example with data from dataset A - HC
load('FC_results_HC.mat')
load('new_specmat_HC.mat')



% Mat size : nsub * fc method * nROI * nROI * frequencies
thresh_node_mats = zeros(size(result_mat));


for subi = 1:size(thresh_node_mats, 1)
    
    for fci = 1:size(thresh_node_mats, 2)
        
        for freqi = 1:size(thresh_node_mats, 5)
            
            
            temp_fc_mat = squeeze(result_mat(subi, fci,:,:,freqi));
            thresh_node_mats(subi, fci,:,:,freqi) = threshold_proportional(temp_fc_mat, 0.05);
            
            
        end
    end
    
end

