%  Add BCT in the path

addpath(genpath(uigetdir))

% load files

cd(uigetdir) % go where the following file are stored
% here example with data from dataset A - HC
load('FC_results_HC.mat')
load('new_specmat_HC.mat')



% Mat size : nsub * fc method * nROI * nROI * frequencies
thresh_node_mats = zeros(size(result_mat));
thresh_node_1f_mats = zeros(size(result_mat));


for subi = 1:size(thresh_node_mats, 1)
    
    for fci = 1:size(thresh_node_mats, 2)
        
        for freqi = 1:size(thresh_node_mats, 5)
            
            
            temp_fc_mat = squeeze(result_mat(subi, fci,:,:,freqi));
            thresh_node_mats(subi, fci,:,:,freqi) = threshold_proportional(temp_fc_mat, 0.05);
            temp_fc_mat_4_1f = threshold_proportional(temp_fc_mat, 0.05);
            %             Different results with Judie's code             
%             C = temp_fc_mat;
%             for r = 1:nROI
%                 nodeStrength(r) = sum(abs(temp_fc_mat(:,r)));
%             end
%             
%             cLims = [-max(abs(temp_fc_mat(:))) max(abs(temp_fc_mat(:)))];
%             %     [~,I] = maxk(nodeStrength,1+floor((1-thresh)*nROI));
%             [~,ind]=sort(nodeStrength,'descend');
%             I=ind(1:1+floor((1-thresh_val)*nROI));
%             C_thresh=zeros(nROI,nROI);
%             for j=1:nROI
%                 for k=1:nROI
%                     if(ismember(j,I)&&ismember(k,I))
%                         C_thresh(j,k)=C(j,k);
%                     end
%                 end
%             end
%             C_thresh(C_thresh==0)=0;
%             thresh_node_mats(subi, fci,:,:,freqi) = C_thresh;
            
            
            % Now threshold further using specparam results
            temp_thresh_mat = squeeze(new_spec_mat(subi, freqi,:,:));
            
            temp_fc_mat_4_1f(temp_thresh_mat == 0) = 0;
            
            thresh_node_1f_mats(subi, fci,:,:,freqi) = temp_fc_mat_4_1f;
            
        end
    end
    
end





for freqi = 1:5
    figure
    imagesc(squeeze(mean(thresh_node_1f_mats(:,5,:,:,freqi),1)))
    set(gca,'clim',[0,1])
    colorbar
end

