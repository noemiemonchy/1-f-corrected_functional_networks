
cd(uigetdir) % go to the brainstorm data folder containing the subjects data
addpath(genpath(uigetdir)) % add bst to path

% Get subject folders list
sub_list = dir();

% remove non subject folders and files from the list
sub_list = sub_list(startsWith({sub_list.name},'sub'));

% sub * fc_method * ROI * ROI * frequency result matrix
result_mat = zeros(length(sub_list), 5, 68, 68, 5);

% Loop through subjects
for subi = [1:7, 9:length(sub_list)] % DATASET A : do not take into account the participant 8 (technical problem); DATASET B : for subi = [1:length(sub_list)]
    
    cd(sub_list(subi).name)
    
    fold_list = dir();
    fold_list = fold_list(startsWith({fold_list.name}, 'sub'));
    cd(fold_list.name)
    
    epochs = dir('timefreq_connectn*');
    
  
    n_plv_files = length(dir('*_plv*'));
    n_ciplv_files = length(dir('*ciplv*'));
    n_wpli_files = length(dir('*wpli*'));
    n_henv_files = length(dir('*henv*'))/2;
    n_oenv_files = length(dir('*oenv*'))/2;
    
    plv_epochs = zeros(n_plv_files, 68, 68, 5);
    ciplv_epochs = zeros(n_ciplv_files, 68, 68, 5);
    wpli_epochs = zeros(n_wpli_files, 68, 68, 5);
    henv_epochs = zeros(n_henv_files, 68, 68, 5);
    oenv_epochs = zeros(n_oenv_files, 68, 68, 5);
    
    % set counters
    plv_c = 1;
    ciplv_c = 1;
    wpli_c = 1;
    henv_c = 1;
    oenv_c = 1;
    
    % Loop through connectivity method
    for epochi = 1:length(dir('timefreq_connectn*')) % to find connectivity matrices 
        epoch = load(epochs(epochi).name);
        fc_method = epoch.Comment(1:4);
        % Read connectivity matrices in the right format,
        % and store in all epochs mat needs bst in the path
        switch fc_method
            case 'PLV:'
                plv_epochs(plv_c,:,:,:) = squeeze(bst_memory('GetConnectMatrix', epoch));
                plv_c = plv_c+1;
            case 'wPLI'
                wpli_epochs(wpli_c,:,:,:) = squeeze(bst_memory('GetConnectMatrix', epoch));
                wpli_c = wpli_c+1 ;
            case 'ciPL'
                ciplv_epochs(ciplv_c,:,:,:) = squeeze(bst_memory('GetConnectMatrix', epoch));
                ciplv_c = ciplv_c+1;
            case 'oenv'
                oenv_epochs(oenv_c,:,:,:) = squeeze(bst_memory('GetConnectMatrix', epoch));
                oenv_c = oenv_c+1;
            case 'penv'
                henv_epochs(henv_c,:,:,:) = squeeze(bst_memory('GetConnectMatrix', epoch));
                henv_c = henv_c+1;
        end
    end
    % Average epochs connectivity
    result_mat(subi, 1, :, :, :) = squeeze(mean(plv_epochs, 1));
    result_mat(subi, 2, :, :, :) = squeeze(mean(wpli_epochs, 1));
    result_mat(subi, 3, :, :, :) = squeeze(mean(ciplv_epochs, 1));
    result_mat(subi, 4, :, :, :) = squeeze(mean(oenv_epochs, 1));
    result_mat(subi, 5, :, :, :) = squeeze(mean(henv_epochs, 1));
    
    disp(['Subject ', num2str(subi), ' is done.'])
    
    cd ..
    cd ..
end
