"""
File in which the control of the belt and defines the functionalities for the vibrotactile oddball blocks is defined.
Functions:
- connect_to_USB
- disconnect_belt
- vibrotactile_oddball_ankle
- vibrotactile_swapped_oddball_ankle
- start_trial
It also handles the connection between the belt and the computer via USB.
"""

from pybelt import classicbelt
import parallel
import random, time
import numpy as np
from psychopy import core
class VibrationController():
    """
    The VibrationController controls the connection to the feelSpace belt.
    It saves the number of the vibrotactile units and links it to its purpose.

    Parameters
    ----------
    ankle_vibromotor : int
        The number of the vibrotactile unit attached to the ankle.
    ankle_trigger : list
        List with trigger codes for the ankle condition.
    ankle_swapped_trigger : list
        List with trigger codes for the ankle swapped condition.
    trial_break : float
        The length of the break between stimuli presentations in seconds.
    trial_length : float
        Defines the length of the trial (each stimulus presentation) in seconds.

    Attributes
    ----------
    belt_controller : BeltController
        This is where we store the controller of the belt, that is defined in
        the pyBelt package.
    ankle_vibomotor : int
        Stores the vibrotactile unit ID for the ankle.
    ankle_trigger : list
        Stores trigger codes for the ankle condition.
    ankle_swapped_trigger : list
        Stores trigger codes for the ankle swapped condition.
    trial_break : float
        Stores the length of the break between stimuli presentations in seconds.
    trial_length : float
        Stores the length of the trial (stimulus presentation) in seconds.
    """

    def __init__(self, ankle_vibromotor, ankle_trigger, ankle_swapped_trigger,
                vibration_strong, vibration_weak, trial_break, trial_length):
        """Constructor that initializes the belt controller."""
        # Instantiate a belt controller
        self.belt_controller = classicbelt.BeltController(delegate=self)
        self.ankle_vibromotor = ankle_vibromotor
        self.ankle_trigger = ankle_trigger
        self.ankle_swapped_trigger = ankle_swapped_trigger
        self.vibration_strong = vibration_strong
        self.vibration_weak = vibration_weak
        self.trial_break = trial_break
        self.trial_length = trial_length

    def connect_to_USB(self):
        """Connect the belt to the serial port (USB)"""
        # connect belt to usb serial port
        print("Connect belt via USB.")
        print("Mode of the belt: ", self.belt_controller.getBeltMode())
        self.belt_controller.connectBeltSerial()

    def disconnect_belt(self):
        """Disconnect belt from serial port (USB)"""
        self.belt_controller.disconnectBelt()

    def vibrotactile_oddball_ankle(self, trials, oddball_ratio):
        """
        Start oddball vibration pattern at the ankle.

        Parameters:
        ----------
        trials : int
            A decimal integer indicating the nr. of trials
        oddball_ratio : float
            Indicating the proportion of odd stimuli
        """
        # Output used as control option for the experimenter.
        print('-----------------------------------')
        print('           VIBROTACTILE ANKLE          ')
        print('-----------------------------------\n')

        total_trial_standard = np.zeros(int(trials*(1-oddball_ratio)))
        total_trial_oddball = np.ones(int(trials*(oddball_ratio)))
        total_trial = np.concatenate([total_trial_oddball, total_trial_standard])

        oddball_count = 0
        standard_count = 0
        swapped = False

        for i in range(trials):

            np.random.shuffle(total_trial)
            random_number = total_trial[0]

            if random_number==1:
                mode = "oddball"
                oddball_count += 1
            else:
                mode = "standard"
                standard_count += 1

            print('MODE (standard or oddball): ', mode)

            self.start_trial(mode, swapped, [self.ankle_vibromotor], self.ankle_trigger)

            total_trial = np.delete(total_trial, 0)

            # break between trials
            time.sleep(self.trial_break)

        print('oddballs', oddball_count)
        print('standards', standard_count)

    def vibrotactile_swapped_oddball_ankle(self, trials, oddball_ratio):
        """
        Start oddball vibration pattern at the ankle but with swapped intensity for
        the oddball/standard condition. In the swapped condition the oddball
        vibration will be low and the standard will be high.

        Parameters:
        ----------
        trials : int
            A decimal integer indicating the nr. of trials
        oddball_ratio : float
            Indicating the proportion of odd stimuli
        """
        # Output used as control option for the experimenter.
        print('-----------------------------------------------')
        print('           VIBROTACTILE ANKLE SWAPPED         ')
        print('-----------------------------------------------\n')

        total_trial_standard = np.zeros(int(trials*(1-oddball_ratio)))
        total_trial_oddball = np.ones(int(trials*(oddball_ratio)))
        total_trial = np.concatenate([total_trial_oddball, total_trial_standard])

        oddball_count = 0
        standard_count = 0
        swapped = True

        for i in range(trials):

            np.random.shuffle(total_trial)
            random_number = total_trial[0]

            if random_number==1:
                stimulus = "oddball"
                oddball_count += 1
            else:
                stimulus = "standard"
                standard_count += 1

            print('Stimulus (standard or oddball): ', stimulus)

            self.start_trial(stimulus, swapped, [self.ankle_vibromotor], self.ankle_swapped_trigger)

            total_trial = np.delete(total_trial, 0)

            # break between trials
            time.sleep(self.trial_break)

        print('oddballs', oddball_count)
        print('standards', standard_count)


    def start_trial(self, stimulus, swapped, vibromotors, trigger_codes):
        """
        Either an oddball or a standard vibration starts.

        Parameters
        ----------
        stimulus : str
            "Standard" or "oddball" -> vibration of low or high intensity
        swapped : bool
            True for swapped stimuli (high intensity standard and low intensity odd)
        vibromotors : int
            Integer refering to the correct vibrating unit
        trigger_codes : list
            Trigger for the stimuli in the respective vibrotactile condition.
            The order is [oddball, standard, break]
        """
        if not swapped:
            vibration_standard = self.vibration_weak
            vibration_oddball = self.vibration_strong
        else:
            vibration_standard = self.vibration_strong
            vibration_oddball = self.vibration_weak

        if stimulus == "standard":
            self.belt_controller.vibrateAtPositions(vibromotors, trigger_codes[1], 1, vibration_standard)
            time.sleep(self.trial_length)
            self.belt_controller.stopVibration()

        elif stimulus == "oddball":
            # Vibrate a first time (trigger is set in classicbelt function)
            self.belt_controller.vibrateAtPositions(vibromotors, trigger_codes[0], 1, vibration_oddball)
            time.sleep(self.trial_length)
            self.belt_controller.stopVibration()

        # Trigger break
        classicbelt.p.setData(trigger_codes[2])
        core.wait(0.01)
        classicbelt.p.setData(0)
