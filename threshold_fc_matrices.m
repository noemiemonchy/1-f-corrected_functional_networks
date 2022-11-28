% load files

inpath = 'C:\Users\BigExecomPC\Dropbox\Projets\1_o_f_corrected_nets\';

load([inpath, 'FC_results_HC.mat'])
load([inpath, 'specmat_HC.mat'])

% Mat size : nsub * fc method * nROI * nROI * frequencies
thresh_node_mats = zeros(size(result_mat));
thresh_node_1f_mats = zeros(size(result_mat));

thresh_val = 0.90; % we want to keep 15% of nodes with the highest fc
nROI = 68;

for subi = 1:size(thresholded_mats, 1)
    
    for fci = 1:size(thresholded_mats, 2)
        
        for freqi = 1:size(thresholded_mats, 5)
            
            
            temp_fc_mat = squeeze(result_mat(subi, fci,:,:,freqi));
            C = temp_fc_mat;
            for r = 1:nROI
                nodeStrength(r) = sum(abs(temp_fc_mat(:,r)));
            end
            
            cLims = [-max(abs(temp_fc_mat(:))) max(abs(temp_fc_mat(:)))];
            %     [~,I] = maxk(nodeStrength,1+floor((1-thresh)*nROI));
            [~,ind]=sort(nodeStrength,'descend');
            I=ind(1:1+floor((1-thresh_val)*nROI));
            C_thresh=zeros(nROI,nROI);
            for j=1:nROI
                for k=1:nROI
                    if(ismember(j,I)&&ismember(k,I))
                        C_thresh(j,k)=C(j,k);
                    end
                end
            end
            C_thresh(C_thresh==0)=0;
            thresh_node_mats(subi, fci,:,:,freqi) = C_thresh;
            
            
            % Now threshold further using specparam results
            temp_thresh_mat = squeeze(spec_mat(subi, freqi,:,:));
            
            C_thresh(temp_thresh_mat == 0) = 0;
            
            thresh_node_1f_mats(subi, fci,:,:,freqi) = C_thresh;
            
        end
    end
    
end



for freqi = 1:5
    figure
    imagesc(squeeze(mean(thresh_node_mats(:,5,:,:,freqi),1)))
    set(gca,'clim',[0,0.5])
end

