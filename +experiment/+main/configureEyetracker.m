function el = configureEyetracker(SessionSettings)
%CONFIGUREEYETRACKER Do routines to initialize eyetracker.
%   Description: The eyetracker needs to have certain parameters in order
%   to operature correctly. This script executes those routines and checks
%   that the eyetracker is connected and running properly.
%
% v1.0 R. Calen Walshe (calen.walshe@utexas.edu)

[status, dummy] = EyelinkInit();
el = EyelinkInitDefaults(SessionSettings.window);
el.backgroundcolour = SessionSettings.bgPixVal;

el.dummyconnected = dummy;

if dummy == 0
    % make sure that we get gaze data from the Eyelink
    Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA');

    Eyelink('Command', 'set_idle_mode');
    Eyelink('Command', 'clear_screen 0');
    EyelinkDoTrackerSetup(el,'d');
    Eyelink('Command', 'set_idle_mode');            
    Eyelink('StartRecording');

    % record a few samples before we actually start displaying
    WaitSecs(0.1);
end



Screen('FillRect', SessionSettings.window, SessionSettings.bgPixVal);
Screen('Flip', SessionSettings.window);

% start recording eye position
Eyelink('StartRecording');

end