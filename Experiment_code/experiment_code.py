# The experiment code file
# Here the belt is connected and uses the functions file that implements the individual blocks.
# Randomization of trials happens here.
# Reads in parameters from separate parameter file.

import serial #@UnusedImport # PySerial for USB connection
import serial.tools.list_ports
import time
import random
from psychopy import visual, event
import vibrotactile_functions
import visual_functions
import parameter

class Experiment():

    def __init__(self):
        print('----------------')
        print('Start Experiment')
        print('----------------\n')

        # get the vibrotactile and visual functions
        self.belt = vibrotactile_functions.VibrationController(parameter.ankle_vibromotor, parameter.ankle_trigger,
                                                               parameter.ankle_swapped_trigger, parameter.vibration_strong,
                                                               parameter.vibration_weak, parameter.trial_break, parameter.trial_length)
        self.screen = visual_functions.ScreenController(parameter.circle_colors, parameter.trial_break,
                                                        parameter.trial_length, parameter.visual_trigger,
                                                        parameter.visual_swapped_trigger)

        # get the parameter from external file
        self.trials_per_block = parameter.trials
        self.oddball_ratio = parameter.oddball_ratio
        self.circle_colors = parameter.circle_colors

        print("\nThe experiment includes:")
        print("Trials per block: ", self.trials_per_block)

    def start(self):
        """Function that starts the experiment"""
        # Initialize belt controller
        self.belt.connect_to_USB()

        print('+++++++++++++++++++++++++++++++++++')
        print('          -BELT CONNECTED-         ')
        print('+++++++++++++++++++++++++++++++++++\n')

        # Show instructions on screen
        self.screen.show_instructions()

        # The functions for each of the 4 block types are stored in a list,
        # enabling to iterate over and ranodmly execute them in the for-loop
        block_functions = [self.screen.visual_oddball,
                           self.screen.visual_swapped_oddball,
                           self.belt.vibrotactile_oddball_ankle,
                           self.belt.vibrotactile_swapped_oddball_ankle]

        # Keeping track of the fingertapping rounds
        count_fingertapping = 0

        # Shuffle blocks
        random.shuffle(block_functions)

        # Execute all the blocks twice. Before executing another time,
        # all other blocks should have been run at least once.
        remaining_trials =block_functions[:]
        
        # No direct repition of the same trial
        while len(block_functions)!= 8:
            next_trial = random.choice(remaining_trials)
            while next_trial == block_functions[-1]:
                next_trial = random.choice(remaining_trials)
            block_functions.append(next_trial)
            remaining_trials.remove(next_trial)
        

        # Shuffle threw blocks
        for i, function in enumerate(block_functions):
                print('Start next block section!')
                time.sleep(1.0)
                self.screen.show_ready_screen()
                self.screen.show_fixation_cross()
                print('Execute block %i' % (i+1))
                function(self.trials_per_block, self.oddball_ratio)

                if i%2 == 0:
                    print('-----------------------------------')
                    print('-----------FINGER TAPPING----------')
                    print('-----------------------------------\n')
                    count_fingertapping += 1
                    self.screen.start_fingertapping_screen(count_fingertapping)

                print('\n')

        # At the very end of the experiment, disconnect the belt
        self.belt.disconnect_belt()

        # Say good bye and thank the participants
        self.screen.show_thank_you()


def main():
    """ Starts the experiment. """
    try:
        experiment = Experiment()
        experiment.start()

    except Exception as e:
        print(e)

if __name__ == "__main__":
    main()
