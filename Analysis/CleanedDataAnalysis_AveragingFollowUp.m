%% Chunk 1
addpath(genpath('/work/vbenhauser/eeglab2021.0'))

% In this file we are averaging all trials that belong to the same
% condition: wrist, waist, ankle, visual and each oddball/standard 

% Where do you want to save the averaged files?
saving_path = '/net/store/nbp/projects/EEG_Tactile/EEG_Tactile_FollowUp'


% Enter from where you want to load the data that you want to average
dataload_path = '/net/store/nbp/projects/EEG_Tactile/EEG_Tactile_FollowUp/sorted_by_condition'
cd(dataload_path);

% Load 8 files to have the most important information for every condition
% Empty the data field, such that we can fill it with the averaged data
% later
EEG_visual_odd = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_visual_odd.set');
EEG_visual_odd.data = [];
EEG_visual_odd.epoch = [];
EEG_visual_stand = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_visual_stand.set');
EEG_visual_stand.data = [];
EEG_visual_stand.epoch = [];
EEG_ankle_swapped_odd = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_ankle_swapped_odd.set');
EEG_ankle_swapped_odd.data = [];
EEG_ankle_swapped_odd.epoch = [];
EEG_ankle_swapped_stand = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_ankle_swapped_stand.set');
EEG_ankle_swapped_stand.data = [];
EEG_ankle_swapped_stand.epoch = [];
EEG_ankle_odd = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_ankle_odd.set');
EEG_ankle_odd.data = [];
EEG_ankle_odd.epoch = [];
EEG_ankle_stand = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_ankle_stand.set');
EEG_ankle_stand.data = [];
EEG_ankle_stand.epoch = [];
EEG_visual_swapped_odd = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_visual_swapped_odd.set');
EEG_visual_swapped_odd.data = [];
EEG_visual_swapped_odd.epoch = [];
EEG_visual_swapped_stand = pop_loadset('autocleaned_VibrotactFollowUpID10_cleaned_visual_swapped_stand.set');
EEG_visual_swapped_stand.data = [];
EEG_visual_swapped_stand.epoch = [];

% We will loop through all 8 conditions
% Find the condtion-separated datafiles and empty the data

all_visual_odd = dir('**/*visual_odd.set'); 
all_visual_odd = {all_visual_odd.name}; 

all_visual_stand = dir('**/*visual_stand.set'); 
all_visual_stand = {all_visual_stand.name}; 

all_ankle_swapped_odd = dir('**/*ankle_swapped_odd.set'); 
all_ankle_swapped_odd = {all_ankle_swapped_odd.name}; 


all_ankle_swapped_stand = dir('**/*ankle_swapped_stand.set'); 
all_ankle_swapped_stand = {all_ankle_swapped_stand.name}; 


all_ankle_odd = dir('**/*ankle_odd.set'); 
all_ankle_odd = {all_ankle_odd.name}; 


all_ankle_stand = dir('**/*ankle_stand.set'); 
all_ankle_stand = {all_ankle_stand.name}; 


all_visual_swapped_odd = dir('**/*visual_swapped_odd.set'); 
all_visual_swapped_odd = {all_visual_swapped_odd.name}; 

all_visual_swapped_stand = dir('**/*visual_swapped_stand.set'); 
all_visual_swapped_stand = {all_visual_swapped_stand.name}; 



%% Chunk 2 - looping through the data and average over trials

% Loop through all datasets with every condition 
% There should be 1 data set for each condition so we can run all of them
% in the same loop
for file_nr = 1:length(all_visual_odd)
    
fprintf('File nr: %i \n', file_nr);
    
% load the data sets
eeg_cleaned_visual_odd = pop_loadset(all_visual_odd{file_nr});
eeg_cleaned_visual_stand = pop_loadset(all_visual_stand{file_nr});
eeg_cleaned_ankle_swapped_odd = pop_loadset(all_ankle_swapped_odd{file_nr});
eeg_cleaned_ankle_swapped_stand = pop_loadset(all_ankle_swapped_stand{file_nr});
eeg_cleaned_ankle_odd = pop_loadset(all_ankle_odd{file_nr});
eeg_cleaned_ankle_stand = pop_loadset(all_ankle_stand{file_nr});
eeg_cleaned_visual_swapped_odd = pop_loadset(all_visual_swapped_odd{file_nr});
eeg_cleaned_visual_swapped_stand = pop_loadset(all_visual_swapped_stand{file_nr});

% average over trials (the third dimension) and save the averages in the data field
EEG_visual_odd.data(:,:,file_nr) = mean(eeg_cleaned_visual_odd.data, 3, 'omitnan');
EEG_visual_stand.data(:,:,file_nr) = mean(eeg_cleaned_visual_stand.data, 3, 'omitnan');
EEG_ankle_swapped_odd.data(:,:,file_nr) = mean(eeg_cleaned_ankle_swapped_odd.data, 3, 'omitnan');
EEG_ankle_swapped_stand.data(:,:,file_nr) = mean(eeg_cleaned_ankle_swapped_stand.data, 3, 'omitnan');
EEG_ankle_odd.data(:,:,file_nr) = mean(eeg_cleaned_ankle_odd.data, 3, 'omitnan');
EEG_ankle_stand.data(:,:,file_nr) = mean(eeg_cleaned_ankle_stand.data, 3, 'omitnan');
EEG_visual_swapped_odd.data(:,:,file_nr) = mean(eeg_cleaned_visual_swapped_odd.data, 3, 'omitnan');
EEG_visual_swapped_stand.data(:,:,file_nr) = mean(eeg_cleaned_visual_swapped_stand.data, 3, 'omitnan');
end

%% Chunk 3 - save the data

% The data now has the shape of (electrodes x data points x subjects)
% Save the files of every condition
cleaned_filename = 'EEG_autocleaned';
EEG_visual_odd.subjects = 17;
% the visual condition
pop_saveset(EEG_visual_odd, 'filename', sprintf('%s_visual_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_visual_stand, 'filename', sprintf('%s_visual_stand.set', cleaned_filename), 'filepath', saving_path);
% the ankle_swapped condition
pop_saveset(EEG_ankle_swapped_odd, 'filename', sprintf('%s_ankle_swapped_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_ankle_swapped_stand, 'filename', sprintf('%s_ankle_swapped_stand.set', cleaned_filename), 'filepath', saving_path);
% the ankle condition
pop_saveset(EEG_ankle_odd, 'filename', sprintf('%s_ankle_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_ankle_stand, 'filename', sprintf('%s_ankle_stand.set', cleaned_filename), 'filepath', saving_path);
% the visual_swapped condition
pop_saveset(EEG_visual_swapped_odd, 'filename', sprintf('%s_visual_swapped_odd.set', cleaned_filename), 'filepath', saving_path);
pop_saveset(EEG_visual_swapped_stand, 'filename', sprintf('%s_visual_swapped_stand.set', cleaned_filename), 'filepath', saving_path);