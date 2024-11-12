%  Add BCT in the path
addpath(genpath(uigetdir))

% load files

cd(uigetdir) % go where the following file are stored
load('FC_averaged_SRM.mat')
load('new_spec_mat_SRM.mat')

% Mat size : nsub * fc method * nROI * nROI * frequencies
thresh_node_1f = zeros(size(result_mat));
thresh_node_1f_mats = zeros(size(result_mat));


for subi = 1:size(thresh_node_1f, 1)
    
    for fci = 1:size(thresh_node_1f, 2)
        
        for freqi = 1:size(thresh_node_1f, 5)
            
            % mask matrice 1/f
            temp_spec_mat = squeeze(new_spec_mat(subi, freqi,:,:));
            temp_fc_mat = squeeze(result_mat(subi, fci,:,:,freqi));
            
            temp_fc_mat(temp_spec_mat == 0) = 0;
            temp_fc_mat_4_prop = temp_fc_mat;
            
            thresh_node_1f(subi,fci,:,:,freqi) = temp_fc_mat_4_prop;
            
            % mask matrice prop
            
            thresh_node_1f_mats(subi, fci,:,:,freqi) = threshold_proportional(temp_fc_mat_4_prop, 0.05);
            
        end     
    end 
end
 

for freqi = 1:5
    figure
    imagesc(squeeze(mean(thresh_node_1f_mats(:,3,:,:,freqi),1)))
    set(gca,'clim',[0,1])
    colorbar
end

