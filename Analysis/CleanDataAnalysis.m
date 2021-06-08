%% Chunk 1

% enter from where you want to load the data and where you want to save it
dataload_path = '/net/store/nbp/projects/EEG_Tactile/EEG_Tactile_FollowUp/raw_data';
saving_path = '/net/store/nbp/projects/EEG_Tactile/EEG_Tactile_FollowUp';

% find the preprocessed files
cd(dataload_path);
all_files = dir('**/*.set'); % (only loads the files with a .set ending)
all_files = {all_files.name};


% specify if you would like to have the baseline removed
remove_baseline = true;

% Loop through every file 
for file = all_files
    
% load the cleaned data set that we want to split into the conditions
eeg_cleaned = pop_loadset(file);

% set a window span for the epochs
window=[-0.2 .8];
% epoch continuous data according to the 8 conditions (waist, wrist, ankle,
% visual) each (oddball and standard stimulus)
[eeg_cleaned_visual_odd, indices_visual_odd] = pop_epoch( eeg_cleaned, {'1'}, window, 'epochinfo', 'yes');
[eeg_cleaned_visual_stand, indices_visual_stand] = pop_epoch( eeg_cleaned, {'3'}, window, 'epochinfo', 'yes');

[eeg_cleaned_ankle_swapped_odd, indices_ankle_swapped_odd] = pop_epoch( eeg_cleaned, {'5'}, window, 'epochinfo', 'yes');
[eeg_cleaned_ankle_swapped_stand, indices_ankle_swapped_stand] = pop_epoch( eeg_cleaned, {'7'}, window, 'epochinfo', 'yes');

[eeg_cleaned_ankle_odd, indices_ankle_odd] = pop_epoch( eeg_cleaned, {'9'}, window, 'epochinfo', 'yes');
[eeg_cleaned_ankle_stand, indices_ankle_stand] = pop_epoch( eeg_cleaned, {'11'}, window, 'epochinfo', 'yes');

[eeg_cleaned_visual_swapped_odd, indices_visual_swapped_odd] = pop_epoch( eeg_cleaned, {'14'}, window, 'epochinfo', 'yes');
[eeg_cleaned_visual_swapped_stand, indices_visual_swapped_stand] = pop_epoch( eeg_cleaned, {'13'}, window, 'epochinfo', 'yes');

eeg_cleaned_visual_odd.orig_indices = indices_waist_odd;
eeg_cleaned_visual_stand.orig_indices = indices_waist_stand;
eeg_cleaned_ankle_swapped_odd.orig_indices = indices_wrist_odd;
eeg_cleaned_wrist_stand.orig_indices = indices_wrist_stand;
eeg_cleaned_ankle_odd.orig_indices = indices_ankle_odd;
eeg_cleaned_ankle_stand.orig_indices = indices_ankle_stand;
eeg_cleaned_visual_odd.orig_indices = indices_visual_odd;
eeg_cleaned_visual_stand.orig_indices = indices_visual_stand;

% remove the baseline if desired 
if remove_baseline
fprintf('Remove baseline: %s', string(remove_baseline));
eeg_cleaned_waist_odd = pop_rmbase(eeg_cleaned_waist_odd, [-199 0]);
eeg_cleaned_waist_stand = pop_rmbase(eeg_cleaned_waist_stand, [-199 0]);
eeg_cleaned_wrist_odd = pop_rmbase(eeg_cleaned_wrist_odd, [-199 0]);
eeg_cleaned_wrist_stand = pop_rmbase(eeg_cleaned_wrist_stand, [-199 0]);
eeg_cleaned_ankle_odd = pop_rmbase(eeg_cleaned_ankle_odd, [-199 0]);
eeg_cleaned_ankle_stand = pop_rmbase(eeg_cleaned_ankle_stand, [-199 0]);
eeg_cleaned_visual_odd = pop_rmbase(eeg_cleaned_visual_odd, [-199 0]);
eeg_cleaned_visual_stand = pop_rmbase(eeg_cleaned_visual_stand, [-199 0]);
end

% save the file 
cd(saving_path);
eeg_cleaned.filename = eeg_cleaned.filename(1:end-10);
% the waist condition
pop_saveset(eeg_cleaned_waist_odd, 'filename', sprintf('%s_cleaned_waist_odd.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_waist_odd.filepath);
pop_saveset(eeg_cleaned_waist_stand, 'filename', sprintf('%s_cleaned_waist_stand.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_waist_stand.filepath);
% the wrist condition
pop_saveset(eeg_cleaned_wrist_odd, 'filename', sprintf('%s_cleaned_wrist_odd.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_wrist_odd.filepath);
pop_saveset(eeg_cleaned_wrist_stand, 'filename', sprintf('%s_cleaned_wrist_stand.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_wrist_stand.filepath);
% the ankle condition
pop_saveset(eeg_cleaned_ankle_odd, 'filename', sprintf('%s_cleaned_ankle_odd.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_ankle_odd.filepath);
pop_saveset(eeg_cleaned_ankle_stand, 'filename', sprintf('%s_cleaned_ankle_stand.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_ankle_stand.filepath);
% the visual condition
pop_saveset(eeg_cleaned_visual_odd, 'filename', sprintf('%s_cleaned_visual_odd.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_visual_odd.filepath);
pop_saveset(eeg_cleaned_visual_stand, 'filename', sprintf('%s_cleaned_visual_stand.set', eeg_cleaned.filename), 'filepath', eeg_cleaned_visual_stand.filepath);

cd(dataload_path);
end