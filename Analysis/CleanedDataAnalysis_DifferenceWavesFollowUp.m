%% Chunk 1 - load the data 

% Enter from where you want to load the data of which you want to compute
% the difference waves
%%dataload_path = '/net/store/nbp/projects/EEG_Tactile/EEG_Tactile_FollowUp/averaged_files'
dataload_path = 'C:\Users\Victoria Benhauser\Desktop\10 Semester\OddballTactile\EEG_vibrotactileCueingFollow-up\averaged_files'
cd(dataload_path);

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
ankle_swapped_difference = EEG_ankle_swapped_odd.mean - EEG_ankle_swapped_stand.mean;
ankle_swapped_difference_sem = EEG_ankle_swapped_odd.sem - EEG_ankle_swapped_stand.sem;
visual_difference = EEG_visual_odd.mean - EEG_visual_stand.mean;
visual_difference_sem = EEG_visual_odd.sem - EEG_visual_stand.sem;
ankle_difference = EEG_ankle_odd.mean - EEG_ankle_stand.mean;
ankle_difference_sem = EEG_ankle_odd.sem - EEG_ankle_stand.sem;
visual_swapped_difference = EEG_visual_swapped_odd.mean - EEG_visual_swapped_stand.mean;
visual_swapped_difference_sem = EEG_visual_swapped_odd.sem - EEG_visual_swapped_stand.sem;


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
plot(time_window, ankle_swapped_difference(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, ankle_swapped_difference(elec_nr,:,:) + ankle_swapped_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, ankle_swapped_difference(elec_nr,:,:) - ankle_swapped_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('odd - standard', 'SEM +', 'SEM -');
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
title('ankle_swapped condition');

ax2 = nexttile;
hold on 
plot(time_window, visual_difference(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, visual_difference(elec_nr,:,:) + visual_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, visual_difference(elec_nr,:,:) - visual_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('odd - standard', 'SEM +', 'SEM -');
title('visual condition');

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
title('ankle condition');

ax4 = nexttile;
hold on 
plot(time_window, visual_swapped_difference(elec_nr,:,:), 'color', diff_wave_colour) 
plot(time_window, visual_swapped_difference(elec_nr,:,:) + visual_swapped_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
plot(time_window, visual_swapped_difference(elec_nr,:,:) - visual_swapped_difference_sem(elec_nr,:,:), ':', 'color', diff_wave_colour)
hold off
ylim([-2 1]);
%lgd = legend('odd - standard', 'SEM +', 'SEM -');
xlabel('ms from stimulus onset');
title('visual_swapped condition');

lg  = legend('odd - standard', 'SEM +', 'SEM -','Orientation','Horizontal','NumColumns',3); 
lg.Layout.Tile = 'South'; % <-- Legend placement with tiled layout

%% Chunk 4 - check the plot and save it

% save the figure as pdf
saveas(gcf, sprintf('Figures\\%s_difference_waves_WOBaseline', elec_name), 'pdf');

%% Chunk 4 - difference waves of difference waves between body parts
%%% which waves?
ankle_condition_diff = ankle_swapped_difference - ankle_difference;
ankle_condition_diff_sem = ankle_swapped_difference_sem - ankle_difference_sem;
visual_condition_diff = visual_swapped_difference - visual_difference;
visual_condition_diff_sem = visual_swapped_difference_sem - visual_difference_sem;
%ankle_waist_diff = ankle_difference - waist_difference;
%ankle_waist_diff_sem = ankle_difference_sem - waist_difference_sem;

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
plot(time_window, ankle_condition_diff(elec_nr,:,:))
plot(time_window, ankle_condition_diff(elec_nr,: ,:) + ankle_condition_diff_sem(elec_nr,: ,:), ':')
plot(time_window, ankle_condition_diff(elec_nr,: ,:) - ankle_condition_diff_sem(elec_nr,: ,:), ':')
hold off
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('ankle_swapped - ankle');

ax2 = nexttile;
hold on 
plot(time_window, visual_condition_diff(elec_nr,:,:))
plot(time_window, visual_condition_diff(elec_nr,:,:) + visual_condition_diff_sem(elec_nr,:,:), ':')
plot(time_window, visual_condition_diff(elec_nr,:,:) - visual_condition_diff_sem(elec_nr,:,:), ':')
hold off
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('visual_swapped - visual');
%{
ax3 = nexttile;
hold on 
plot(time_window, ankle_waist_diff(elec_nr,:,:))
plot(time_window, ankle_waist_diff(elec_nr,:,:) + ankle_waist_diff_sem(elec_nr,:,:), ':')
plot(time_window, ankle_waist_diff(elec_nr,:,:) - ankle_waist_diff_sem(elec_nr,:,:), ':')
hold off
ylabel(sprintf('Amplitude (%sV) in %s',char(181), elec_name));
xlabel('ms from stimulus onset');
title('ankle - waist');
%}
lg  = legend('difference wave', 'SEM +', 'SEM -','Orientation','Horizontal','NumColumns',3); 
lg.Layout.Tile = 'South'; % <-- Legend placement with tiled layout

%%

saveas(gcf, sprintf('Figures\\%s_diffWaves_bodyparts_WObaseline', elec_name), 'pdf');
