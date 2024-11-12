%% Number of participants exhibiting connections 

% import the matrix 
load('Thresholded_prop_5_FC_results_SRM.mat')

% we create a matrix for each participant, assigning a value of 0 or 1 
% depending on the presence of a connection between ROIs.

connec = zeros(size(thresh_node_mats));

for subi = 1:size(thresh_node_mats, 1)
    
    for fci = 1:size(thresh_node_mats, 2)
        
        for freqi = 1:size(thresh_node_mats, 5)
             
             
             connec_subi_fci_freqi = zeros(size(thresh_node_mats(subi,fci,:,:,freqi)));
             temp_connec = squeeze(thresh_node_mats(subi,fci,:,:,freqi));
             
             connec_subi_fci_freqi(temp_connec ~= 0) = 1;
             connec(subi,fci,:,:,freqi) = connec_subi_fci_freqi;
             
        end     
    end 
end


% connec is a table 5D containing all the matrices for each subject, each FC method, each frequency, coded as 1 
% or 0 depending on the presence of connections 

fc_meth = {'plv', 'wpli', 'ciplv', 'oenv', 'henv'};
frequencies = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

% now we will compute the sum
% example : for FC method 1 (plv) & frequency band number 3 (alpha) : 
load('Thresholded_prop_5_FC_results_SRM_coded_per_participant.mat')
connec_wPLI_alpha = sum(connec(:,1,:,:,3));
a = squeeze(connec_wPLI_alpha);
max(a(:))
figure; imagesc(a)


%% Percentage normalization based on the total population size 

% import the matrix already coded in the number of participants exhibiting
% connections
load('Thresholded_prop_5_FC_results_SRM_coded_per_participant.mat')
load('Thresholded_1f_prop_5_FC_results_SRM_coded_per_participant.mat')

connec_norm = zeros(2,68,68,5);

for fci = 1:size(connec, 2)

        for freqi = 1:size(connec, 5)
             
             connec_norm_fci_freqi = squeeze(sum(connec(:,fci,:,:,freqi)));
             connec_normi  = (connec_norm_fci_freqi.*(1/size(connec,1)).*100)
             
             connec_norm(fci,:,:,freqi) = connec_normi;
             
        end     
end 

load('Thresholded_1f_prop_5_FC_results_SRM_coded_per_participant_normalised.mat')

ciPLV_alpha_SRM = squeeze(connec_norm(3,:,:,3))
ciPLV_beta_SRM = squeeze(connec_norm(3,:,:,4))



