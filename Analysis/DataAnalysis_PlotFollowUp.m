%% Chunk 1 - load the data 

% Enter from where you want to load the data that you want to plot
dataload_path = 'C:\Users\rosah\Desktop\Rosas Unikrams\6th semester from Asus\Parkinson study project\Thesis things\EEG_feelSpace\EEG_data_feelSpace\BAthesis_PilotAnalysis\7subjects\Averaged'
cd(dataload_path);

% load all data to plot it
% note that the trials will be indicated as 7 now (due to eeg_checkset)
EEG_ankle_swapped_odd = pop_loadset('EEG_autocleaned_ankle_swapped_odd_stats.set');
EEG_ankle_swapped_stand = pop_loadset('EEG_autocleaned_ankle_swapped_stand_stats.set');
EEG_visual_odd = pop_loadset('EEG_autocleaned_visual_odd_stats.set');
EEG_visual_stand = pop_loadset('EEG_autocleaned_visual_stand_stats.set');
EEG_ankle_odd = pop_loadset('EEG_autocleaned_ankle_odd_stats.set');
EEG_ankle_stand = pop_loadset('EEG_autocleaned_ankle_stand_stats.set');
EEG_visual_swapped_odd = pop_loadset('EEG_autocleaned_visual_swapped_odd_stats.set');
EEG_visual_swapped_stand = pop_loadset('EEG_autocleaned_visual_swapped_stand_stats.set');

% Get original chanloc information 
eeg_step1 = pop_loadset();
eeg_step1 = pop_select(eeg_step1, 'nochannel', {'BIP2' 'BIP3' 'BIP4' 'AUX1' 'AUX2' 'AUX3' 'AUX4'}); 
channel_locations = {eeg_step1.chanlocs};

%% Chunk 2 - Prepare for plotting the 4 conditions recorded by the Fz and Pz electrode

% our x axis
time_window = linspace(-200, 800, 512);

% choose an electrode 
elec_name = 'Fp1';
elec_nr = 1; %Fz is 6 and Pz is 26 and Cz is 16

% choose a plot title
figure_title = sprintf('Electrode %s - ERP comparison for visual and vibrotactile oddball paradigm', elec_name);

% to plot the standard errors of the mean we need the error in both directions
sem_plus_ankle_swapped_stand = EEG_ankle_swapped_stand.mean(elec_nr,:,:) + EEG_ankle_swapped_stand.sem(elec_nr,:,:);
sem_minus_ankle_swapped_stand = EEG_ankle_swapped_stand.mean(elec_nr,:,:) - EEG_ankle_swapped_stand.sem(elec_nr,:,:);
sem_plus_ankle_swapped_odd = EEG_ankle_swapped_odd.mean(elec_nr,:,:) + EEG_ankle_swapped_odd.sem(elec_nr,:,:);
sem_minus_ankle_swapped_odd = EEG_ankle_swapped_odd.mean(elec_nr,:,:) - EEG_ankle_swapped_odd.sem(elec_nr,:,:);

sem_plus_visual_stand = EEG_visual_stand.mean(elec_nr,:,:) + EEG_visual_stand.sem(elec_nr,:,:);
sem_minus_visual_stand = EEG_visual_stand.mean(elec_nr,:,:) - EEG_visual_stand.sem(elec_nr,:,:);
sem_plus_visual_odd = EEG_visual_odd.mean(elec_nr,:,:) + EEG_visual_odd.sem(elec_nr,:,:);
sem_minus_visual_odd = EEG_visual_odd.mean(elec_nr,:,:) - EEG_visual_odd.sem(elec_nr,:,:);

sem_plus_ankle_stand = EEG_ankle_stand.mean(elec_nr,:,:) + EEG_ankle_stand.sem(elec_nr,:,:);
sem_minus_ankle_stand = EEG_ankle_stand.mean(elec_nr,:,:) - EEG_ankle_stand.sem(elec_nr,:,:);
sem_plus_ankle_odd = EEG_ankle_odd.mean(elec_nr,:,:) + EEG_ankle_odd.sem(elec_nr,:,:);
sem_minus_ankle_odd = EEG_ankle_odd.mean(elec_nr,:,:) - EEG_ankle_odd.sem(elec_nr,:,:);

sem_plus_visual_swapped_stand = EEG_visual_swapped_stand.mean(elec_nr,:,:) + EEG_visual_swapped_stand.sem(elec_nr,:,:);
sem_minus_visual_swapped_stand = EEG_visual_swapped_stand.mean(elec_nr,:,:) - EEG_visual_swapped_stand.sem(elec_nr,:,:);
sem_plus_visual_swapped_odd = EEG_visual_swapped_odd.mean(elec_nr,:,:) + EEG_visual_swapped_odd.sem(elec_nr,:,:);
sem_minus_visual_swapped_odd = EEG_visual_swapped_odd.mean(elec_nr,:,:) - EEG_visual_swapped_odd.sem(elec_nr,:,:);

%% Chunk 3 - Plot (enter electrode number and name)

% the title of the first figure with 4 subplots
sgtitle(figure_title);
% we have 4 subplots
subplot(2,2,1);
plot(time_window, EEG_ankle_swapped_stand.mean(elec_nr,:,:), 'b', time_window, EEG_ankle_swapped_odd.mean(elec_nr,:,:), 'r',...
    time_window, sem_minus_ankle_swapped_stand, ':b', time_window, sem_plus_ankle_swapped_stand, ':b',...
    time_window, sem_minus_ankle_swapped_odd, ':r', time_window, sem_plus_ankle_swapped_odd, ':r')
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
ylim([-2 2])
lgd = legend('standard', 'oddball');
title('ankle_swapped condition');

subplot(2,2,2);
plot(time_window, EEG_visual_stand.mean(elec_nr,:,:), 'b', time_window, EEG_visual_odd.mean(elec_nr,:,:), 'r',...
    time_window, sem_minus_visual_stand, ':b', time_window, sem_plus_visual_stand, ':b',...
    time_window, sem_minus_visual_odd, ':r', time_window, sem_plus_visual_odd, ':r')
lgd = legend('standard', 'oddball');
ylim([-2 2]);
title('visual condition');

subplot(2,2,3);
plot(time_window, EEG_ankle_stand.mean(elec_nr,:,:), 'b', time_window, EEG_ankle_odd.mean(elec_nr,:,:), 'r',...
    time_window, sem_minus_ankle_stand, ':b', time_window, sem_plus_ankle_stand, ':b',...
    time_window, sem_minus_ankle_odd, ':r', time_window, sem_plus_ankle_odd, ':r')
ylabel(sprintf('Amplitude (%sV) in %s', char(181), elec_name));
xlabel('ms from stimulus onset');
ylim([-2 2]);
lgd = legend('standard', 'oddball');
title('ankle condition');

subplot(2,2,4);
plot(time_window, EEG_visual_swapped_stand.mean(elec_nr,:,:), 'b', time_window, EEG_visual_swapped_odd.mean(elec_nr,:,:), 'r',...
    time_window, sem_minus_visual_swapped_stand, ':b', time_window, sem_plus_visual_swapped_stand, ':b',...
    time_window, sem_minus_visual_swapped_odd, ':r', time_window, sem_plus_visual_swapped_odd, ':r')
xlabel('ms from stimulus onset');
ylim([-2 2]);
lgd = legend('standard', 'oddball');
title('visual_swapped condition');

%% Save as pdf
saveas(gcf, sprintf('Figures\\%s_WObaseline_7subjects', elec_name), 'pdf');

%% Save data in mat file
save('DataPython\\WObaseline_22cleaned.mat', 'time_window', 'EEG_visual_swapped_stand', 'EEG_visual_swapped_odd', 'EEG_ankle_stand', 'EEG_ankle_odd', 'EEG_ankle_swapped_stand', 'EEG_ankle_swapped_odd', 'EEG_visual_stand', 'EEG_visual_odd')