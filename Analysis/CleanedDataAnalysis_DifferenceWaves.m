%% Chunk 1 - load the data 

% Enter from where you want to load the data of which you want to compute
% the difference waves
dataload_path = 'C:\Users\rosah\Desktop\Rosas Unikrams\6th semester from Asus\Parkinson study project\Thesis things\EEG_feelSpace\EEG_data_feelSpace\CleanedDataAnalysis\WithoutBaseline\Averaged'
cd(dataload_path);

% load all data to plot it
% note that the trials will be indicated as nr of subjects now (due to eeg_checkset)
EEG_wrist_odd = pop_loadset('EEG_cleaned_wrist_odd_stats.set');
EEG_wrist_stand = pop_loadset('EEG_cleaned_wrist_stand_stats.set');
EEG_waist_odd = pop_loadset('EEG_cleaned_waist_odd_stats.set');
EEG_waist_stand = pop_loadset('EEG_cleaned_waist_stand_stats.set');
EEG_ankle_odd = pop_loadset('EEG_cleaned_ankle_odd_stats.set');
EEG_ankle_stand = pop_loadset('EEG_cleaned_ankle_stand_stats.set');
EEG_visual_odd = pop_loadset('EEG_cleaned_visual_odd_stats.set');
EEG_visual_stand = pop_loadset('EEG_cleaned_visual_stand_stats.set');

%% Chunk 2 - compute the difference waves

% first we need to compute the difference waves between the standard and
% the oddball stimulus for each condition
wrist_difference = EEG_wrist_odd.mean - EEG_wrist_stand.mean;
wrist_difference_sem = EEG_wrist_odd.sem - EEG_wrist_stand.sem;
waist_difference = EEG_waist_odd.mean - EEG_waist_stand.mean;
waist_difference_sem = EEG_waist_odd.sem - EEG_waist_stand.sem;
ankle_difference = EEG_ankle_odd.mean - EEG_ankle_stand.mean;
ankle_difference_sem = EEG_ankle_odd.sem - EEG_ankle_stand.sem;
visual_difference = EEG_visual_odd.mean - EEG_visual_stand.mean;
visual_difference_sem = EEG_visual_odd.sem - EEG_visual_stand.sem;


%% Chunk 3 - Plot ERP difference wave for the Fz and Pz electrode

% our x axis
time_window = linspace(-200, 600, 205);
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
plot(time_window, wrist_difference(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, wrist_difference(elec_nr,:,:) + wrist_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, wrist_difference(elec_nr,:,:) - wrist_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('odd - standard', 'SEM +', 'SEM -');
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
title('Wrist vibration');

ax2 = nexttile;
hold on 
plot(time_window, waist_difference(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, waist_difference(elec_nr,:,:) + waist_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, waist_difference(elec_nr,:,:) - waist_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('odd - standard', 'SEM +', 'SEM -');
title('Waist vibration');

ax3 = nexttile;
hold on 
plot(time_window, ankle_difference(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, ankle_difference(elec_nr,:,:) + ankle_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, ankle_difference(elec_nr,:,:) - ankle_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('odd - standard', 'SEM +', 'SEM -');
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('Ankle vibration');

ax4 = nexttile;
hold on 
plot(time_window, visual_difference(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, visual_difference(elec_nr,:,:) + visual_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, visual_difference(elec_nr,:,:) - visual_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('odd - standard', 'SEM +', 'SEM -');
xlabel('ms from stimulus onset');
title('Visual task');

lg  = legend('odd - standard', 'SEM +', 'SEM -','Orientation','Horizontal','NumColumns',3); 
lg.Layout.Tile = 'South'; % <-- Legend placement with tiled layout

%% Chunk 4 - check the plot and save it

% save the figure as pdf
saveas(gcf, sprintf('Figures\\%s_difference_waves_WOBaseline', elec_name), 'pdf');

%% Chunk 4 - difference waves of difference waves between body parts

wrist_ankle_diff = wrist_difference - ankle_difference;
wrist_ankle_diff_sem = wrist_difference_sem - ankle_difference_sem;
wrist_waist_diff = wrist_difference - waist_difference;
wrist_waist_diff_sem = wrist_difference_sem - waist_difference_sem;
ankle_waist_diff = ankle_difference - waist_difference;
ankle_waist_diff_sem = ankle_difference_sem - waist_difference_sem;

% plot color
diff_wave_colour = [0.8500 0.3250 0.0680];
% choose an electrode 
elec_name = 'Fz';
elec_nr = 6; %Fz is 6 and Pz is 26

% choose a plot title
figure_title = sprintf('Electrode %s - ERP difference waves between body parts\n baseline removed', elec_name);
sgtitle(figure_title);

% create a tiled layout and get the current axis in order to set the legend
% at the correct position
tlo = tiledlayout(2,2);
diff_waves_figure  = gca; 

ax1 = nexttile;
hold on 
plot(time_window, wrist_ankle_diff(elec_nr,:,:))
plot(time_window, wrist_ankle_diff(elec_nr,: ,:) + wrist_ankle_diff_sem(elec_nr,: ,:), ':')
plot(time_window, wrist_ankle_diff(elec_nr,: ,:) - wrist_ankle_diff_sem(elec_nr,: ,:), ':')
hold off
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('wrist - ankle');

ax2 = nexttile;
hold on 
plot(time_window, wrist_waist_diff(elec_nr,:,:))
plot(time_window, wrist_waist_diff(elec_nr,:,:) + wrist_waist_diff_sem(elec_nr,:,:), ':')
plot(time_window, wrist_waist_diff(elec_nr,:,:) - wrist_waist_diff_sem(elec_nr,:,:), ':')
hold off
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('wrist - waist');

ax3 = nexttile;
hold on 
plot(time_window, ankle_waist_diff(elec_nr,:,:))
plot(time_window, ankle_waist_diff(elec_nr,:,:) + ankle_waist_diff_sem(elec_nr,:,:), ':')
plot(time_window, ankle_waist_diff(elec_nr,:,:) - ankle_waist_diff_sem(elec_nr,:,:), ':')
hold off
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('ankle - waist');

lg  = legend('difference wave', 'SEM +', 'SEM -','Orientation','Horizontal','NumColumns',3); 
lg.Layout.Tile = 'South'; % <-- Legend placement with tiled layout

%%

saveas(gcf, sprintf('Figures\\%s_diffWaves_bodyparts_WObaseline', elec_name), 'pdf');
