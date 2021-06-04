%% Chunk 1

% In this file we are averaging all trials that belong to the same
% condition: wrist, waist, ankle, visual and each oddball/standard 

% Where do you want to save the averaged files?
saving_path = 'C:\Users\rosah\Desktop\Rosas Unikrams\6th semester from Asus\Parkinson study project\Thesis things\EEG_feelSpace\EEG_data_feelSpace\AutomatedPreprocessing\SortedByCondition\AveragedOverTrials'

% Enter from where you want to load the data that you want to average
dataload_path = 'C:\Users\rosah\Desktop\Rosas Unikrams\6th semester from Asus\Parkinson study project\Thesis things\EEG_feelSpace\EEG_data_feelSpace\AutomatedPreprocessing\SortedByCondition'
cd(dataload_path);

% Load 8 files to have the most important information for every condition
% Empty the data field, such that we can fill it with the averaged data
% later
EEG_waist_odd = pop_loadset('autocleaned_feelSpace_ID17_waist_odd.set');
EEG_waist_odd.data = [];
EEG_waist_odd.epoch = [];
EEG_waist_stand = pop_loadset('autocleaned_feelSpace_ID17_waist_stand.set');
EEG_waist_stand.data = [];
EEG_waist_stand.epoch = [];
EEG_wrist_odd = pop_loadset('autocleaned_feelSpace_ID17_wrist_odd.set');
EEG_wrist_odd.data = [];
EEG_wrist_odd.epoch = [];
EEG_wrist_stand = pop_loadset('autocleaned_feelSpace_ID17_wrist_stand.set');
EEG_wrist_stand.data = [];
EEG_wrist_stand.epoch = [];
EEG_ankle_odd = pop_loadset('autocleaned_feelSpace_ID17_ankle_odd.set');
EEG_ankle_odd.data = [];
EEG_ankle_odd.epoch = [];
EEG_ankle_stand = pop_loadset('autocleaned_feelSpace_ID17_ankle_stand.set');
EEG_ankle_stand.data = [];
EEG_ankle_stand.epoch = [];
EEG_visual_odd = pop_loadset('autocleaned_feelSpace_ID17_visual_odd.set');
EEG_visual_odd.data = [];
EEG_visual_odd.epoch = [];
EEG_visual_stand = pop_loadset('autocleaned_feelSpace_ID17_visual_stand.set');
EEG_visual_stand.data = [];
EEG_visual_stand.epoch = [];

% We will loop through all 8 conditions
% Find the condtion-separated datafiles and empty the data
all_waist_odd = {dir('**/*waist_odd.set').name}; 
all_waist_stand = {dir('**/*waist_stand.set').name}; 
all_wrist_odd = {dir('**/*wrist_odd.set').name}; 
all_wrist_stand = {dir('**/*wrist_stand.set').name}; 
all_ankle_odd = {dir('**/*ankle_odd.set').name}; 
all_ankle_stand = {dir('**/*ankle_stand.set').name}; 
all_visual_odd = {dir('**/*visual_odd.set').name}; 
all_visual_stand = {dir('**/*visual_stand.set').name}; 

%% Chunk 2 - looping through the data and average over trials

% Loop through all datasets with every condition 
% There should be 1 data set for each condition so we can run all of them
% in the same loop
for file_nr = 1:length(all_waist_odd)
    
fprintf('File nr: %i \n', file_nr);
    
% load the data sets
eeg_cleaned_waist_odd = pop_loadset(all_waist_odd{file_nr});
eeg_cleaned_waist_stand = pop_loadset(all_waist_stand{file_nr});
eeg_cleaned_wrist_odd = pop_loadset(all_wrist_odd{file_nr});
eeg_cleaned_wrist_stand = pop_loadset(all_wrist_stand{file_nr});
eeg_cleaned_ankle_odd = pop_loadset(all_ankle_odd{file_nr});
eeg_cleaned_ankle_stand = pop_loadset(all_ankle_stand{file_nr});
eeg_cleaned_visual_odd = pop_loadset(all_visual_odd{file_nr});
eeg_cleaned_visual_stand = pop_loadset(all_visual_stand{file_nr});

% average over trials (the third dimension) and save the averages in the data field
EEG_waist_odd.data(:,:,file_nr) = mean(eeg_cleaned_waist_odd.data, 3, 'omitnan');
EEG_waist_stand.data(:,:,file_nr) = mean(eeg_cleaned_waist_stand.data, 3, 'omitnan');
EEG_wrist_odd.data(:,:,file_nr) = mean(eeg_cleaned_wrist_odd.data, 3, 'omitnan');
EEG_wrist_stand.data(:,:,file_nr) = mean(eeg_cleaned_wrist_stand.data, 3, 'omitnan');
EEG_ankle_odd.data(:,:,file_nr) = mean(eeg_cleaned_ankle_odd.data, 3, 'omitnan');
EEG_ankle_stand.data(:,:,file_nr) = mean(eeg_cleaned_ankle_stand.data, 3, 'omitnan');
EEG_visual_odd.data(:,:,file_nr) = mean(eeg_cleaned_visual_odd.data, 3, 'omitnan');
EEG_visual_stand.data(:,:,file_nr) = mean(eeg_cleaned_visual_stand.data, 3, 'omitnan');
end

%% Chunk 3 - save the data

% The data now has the shape of (electrodes x data points x subjects)
% Save the files of every condition
cleaned_filename = 'EEG_autocleaned';
EEG_waist_odd.subjects = 22;
% the waist condition
pop_saveset(EEG_waist_odd, 'filename', sprintf('%s_waist_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_waist_stand, 'filename', sprintf('%s_waist_stand.set', cleaned_filename), 'filepath', saving_path);
% the wrist condition
pop_saveset(EEG_wrist_odd, 'filename', sprintf('%s_wrist_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_wrist_stand, 'filename', sprintf('%s_wrist_stand.set', cleaned_filename), 'filepath', saving_path);
% the ankle condition
pop_saveset(EEG_ankle_odd, 'filename', sprintf('%s_ankle_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_ankle_stand, 'filename', sprintf('%s_ankle_stand.set', cleaned_filename), 'filepath', saving_path);
% the visual condition
pop_saveset(EEG_visual_odd, 'filename', sprintf('%s_visual_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_visual_stand, 'filename', sprintf('%s_visual_stand.set', cleaned_filename), 'filepath', saving_path);