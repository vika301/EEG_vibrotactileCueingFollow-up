%% Chunk 1

% In this file we are calculating the mean, standard deviation and the
% standard error mean of all subjects

% Enter from where you want to load the data that you want to analyse
%dataload_path = '/net/store/nbp/projects/EEG_Tactile/EEG_Tactile_FollowUp/averaged_files'
dataload_path = 'C:\Users\Victoria Benhauser\Desktop\10 Semester\OddballTactile\AnalysisData\averaged'
cd(dataload_path);

%% Chunk 2 - loop over averaged data and compute mean, std, sem

% Find all 8 data sets
all_files = dir('**/*.set');
all_files = {all_files.name};


% Loop through all datasets with every condition 
for file = all_files

fprintf('File name: %s \n', file{1});
% load the file
EEG_raw = pop_loadset(file);

% calculate the mean, std and sem
EEG_raw.mean = mean(EEG_raw.data, 3, 'omitnan');
EEG_raw.std = std(EEG_raw.data, 0, 3, 'omitnan');
EEG_raw.sem = EEG_raw.std./sqrt(size(EEG_raw.data, 3));

% save the file 
EEG_raw.filename = EEG_raw.filename(1:end-4);
pop_saveset(EEG_raw, 'filename', sprintf('%s_stats.set', EEG_raw.filename));

end
