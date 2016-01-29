function configureeyetracker(window)
%CONFIGUREEYETRACKER Do routines to initialize eyetracker.
%   Description: The eyetracker needs to have certain parameters in order
%   to operature correctly. This script executes those routines and checks
%   that the eyetracker is connected and running properly.
%
% v1.0 R. Calen Walshe (calen.walshe@utexas.edu)

el=EyelinkInitDefaults(window);

% make sure that we get gaze data from the Eyelink
Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA');

% Calibrate the eye tracker
EyelinkDoTrackerSetup(el);

% do a final check of calibration using driftcorrection
EyelinkDoDriftCorrection(el);
   
EyelinkDoTrackerSetup(el);

% start recording eye position
Eyelink('StartRecording');
% record a few samples before we actually start displaying
WaitSecs(0.1);

end