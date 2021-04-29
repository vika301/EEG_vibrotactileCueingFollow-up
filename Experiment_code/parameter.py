from psychopy import logging
# Important parameters defined for the main experiment

participant_ID = input('Please enter the participant ID: ') # e.g. 38
fingertapping_file_name = 'Fingertapping_Data_followUp/EEGtactileFollowUp_Fingertapping_participant_' + str(participant_ID) + '.csv'

# logging
#filename = 'EEG_tactile_logging'
#logFile = logging.LogFile(filename + '.log', level=logging.EXP)
logging.console.setLevel(logging.CRITICAL) # this outputs to the screen, not a file

trials = 20 #200
oddball_ratio = 0.3
trial_break = 0.7
trial_length = 0.8

# Parameters for the visual oddball task
circle_colors = ["cyan", "pink"] # ["cyan", "pink"] in the swap condition cyan is the oddball color

# Parameters for the vibrotactile oddball task
ankle_vibromotor = 12
vibration_weak = 30
vibration_strong = 100

# Trigger codes (oddball, standard, break) for the 4 different blocks
ankle_trigger = [9, 11, 12]
ankle_swapped_trigger = [5, 7, 8]
visual_trigger = [1, 3, 4]
visual_swapped_trigger = [14, 13, 15]

# "Translation" to the attached labels on the feelSpace belt:
# variable above:attached label
# 12:2
# 7:9
# 9:7
# 8:8
