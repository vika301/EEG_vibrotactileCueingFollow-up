%% Chunk 1 - load the data 

% Enter from where you want to load the data of which you want to compute
% the difference waves
%%dataload_path = '/net/store/nbp/projects/EEG_Tactile/EEG_Tactile_FollowUp/averaged_files'
dataload_path = 'C:\Users\Victoria Benhauser\Desktop\10 Semester\OddballTactile\EEG_vibrotactileCueingFollow-up\averaged_files'
cd(dataload_path);

saving_path = 'C:\Users\Victoria Benhauser\Desktop\10 Semester\OddballTactile\EEG_vibrotactileCueingFollow-up';


% load all data to plot it
% note that the trials will be indicated as nr of subjects now (due to eeg_checkset)
EEG_ankle_swapped_odd = pop_loadset('EEG_autocleaned_ankle_swapped_odd_stats.set');
EEG_ankle_swapped_stand = pop_loadset('EEG_autocleaned_ankle_swapped_stand_stats.set');
EEG_visual_odd = pop_loadset('EEG_autocleaned_visual_odd_stats.set');
EEG_visual_stand = pop_loadset('EEG_autocleaned_visual_stand_stats.set');
EEG_ankle_odd = pop_loadset('EEG_autocleaned_ankle_odd_stats.set');
EEG_ankle_stand = pop_loadset('EEG_autocleaned_ankle_stand_stats.set');
EEG_visual_swapped_odd = pop_loadset('EEG_autocleaned_visual_swapped_odd_stats.set');
EEG_visual_swapped_stand = pop_loadset('EEG_autocleaned_visual_swapped_stand_stats.set');

%% Chunk 2 - compute the difference waves

% first we need to compute the difference waves between the standard and
% the oddball stimulus for each condition
difference_ankle_odd = EEG_ankle_swapped_odd.data - EEG_ankle_odd.data;
difference_ankle_odd_mean = EEG_ankle_swapped_odd.mean - EEG_ankle_odd.mean;
difference_ankle_odd_sem = EEG_ankle_swapped_odd.sem - EEG_ankle_odd.sem;

difference_ankle_stand = EEG_ankle_swapped_stand.data - EEG_ankle_stand.data;
difference_ankle_stand_mean = EEG_ankle_swapped_stand.mean - EEG_ankle_stand.mean;
difference_ankle_stand_sem = EEG_ankle_swapped_stand.sem - EEG_ankle_stand.sem;

difference_visual_odd = EEG_visual_swapped_odd.data - EEG_visual_odd.data;
difference_visual_odd_mean = EEG_visual_swapped_odd.mean - EEG_visual_odd.mean;
difference_visual_odd_sem = EEG_visual_swapped_odd.sem - EEG_visual_odd.sem;

difference_visual_stand = EEG_visual_swapped_stand.data - EEG_visual_stand.data;
difference_visual_stand_mean = EEG_visual_swapped_stand.mean - EEG_visual_stand.mean;
difference_visual_stand_sem = EEG_visual_swapped_stand.sem - EEG_visual_stand.sem;

%% Chunk 3 - Plot ERP difference wave for the Fz and Pz electrode

% our x axis
time_window = linspace(-200, 800, 512);
% plot color
diff_wave_colour = [0.8500 0.3250 0.0980];
% choose an electrode 
elec_name = 'Fz';
elec_nr = 6; %Fz is 6 and Pz is 26

% choose a plot title
figure_title = sprintf('Electrode %s - ERP difference waves of visual and vibrotactile oddball\n baseline removed', elec_name);

sgtitle(figure_title);
% create a tiled layout and get the current axis in order to set the legend
% at the correct position
tlo = tiledlayout(2,2);
diff_waves_figure  = gca; 

ax1 = nexttile;
hold on 
plot(time_window, difference_ankle_odd_mean(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, difference_ankle_odd_mean(elec_nr,:,:) + difference_ankle_odd_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, difference_ankle_odd_mean(elec_nr,:,:) - difference_ankle_odd_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('swapped_trials - standard_trials', 'SEM +', 'SEM -');
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
title('ankle_odd condition');

ax2 = nexttile;
hold on 
plot(time_window, difference_ankle_stand_mean(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, difference_ankle_stand_mean(elec_nr,:,:) + difference_ankle_stand_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, difference_ankle_stand_mean(elec_nr,:,:) - difference_ankle_stand_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('swapped_trials - standard_trials', 'SEM +', 'SEM -');
title('ankle_stand condition');

ax3 = nexttile;
hold on 
plot(time_window, difference_visual_odd_mean(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, difference_visual_odd_mean(elec_nr,:,:) + difference_visual_odd_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, difference_visual_odd_mean(elec_nr,:,:) - difference_visual_odd_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('swapped_trials - standard_trials', 'SEM +', 'SEM -');
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('visual_odd condition');

ax4 = nexttile;
hold on 
plot(time_window, difference_visual_stand_mean(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, difference_visual_stand_mean(elec_nr,:,:) + difference_visual_stand_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, difference_visual_stand_mean(elec_nr,:,:) - difference_visual_stand_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('swapped_trials - standard_trials', 'SEM +', 'SEM -');
xlabel('ms from stimulus onset');
title('visual_stand condition');

lg  = legend('swapped_trials - standard_trials', 'SEM +', 'SEM -','Orientation','Horizontal','NumColumns',3); 
lg.Layout.Tile = 'South'; % <-- Legend placement with tiled layout

%% Chunk 4 - Save the data for TFCE
filename = 'DifferenceWaves';
cd(saving_path);

pop_saveset(difference_ankle_odd.data, 'filename', sprintf('%s_ankle_odd.set', filename), 'filepath', saving_path);
%save ('DifferenceWavesFollowUp.m', EEG_ankle_swapped_odd)

