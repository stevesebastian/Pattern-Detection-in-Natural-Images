function SessionData = runMaskingExperiment(subjectStr, expTypeStr, targetTypeStr)
%STARTEXPERIMENT Launch the detection experiment.
%
% Example: 
%   blockData = STARTEXPERIMENT(ExpSettings, blockNumber);
%   
%   See also RUNEXPERIMENTBLOCK
%
% v2.0, 1/27/2016, Steve Sebastian, R. C. Walshe <calen.walshe@utexas.edu>

%% Load in the settings
[ExpSettings, sessionNumber] = experiment.loadCurrentSession(subjectStr, expTypeStr, targetTypeStr);

% Clear the workspace
close all;
sca;
Eyelink('Shutdown');

% Setup PTB with some default values
PsychDefaultSetup(2);

% Seed the random number generator
rand('seed', sum(100 * clock));

% Set the screen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Open the screen
[window, windowRect] = Screen('OpenWindow', screenNumber, ExpSettings.bgPixVal, [], [], 2);


SessionSettings = ExpSettings.loadSessionStimuli(ExpSettings, windowRect(3:4), sessionNumber);
SessionSettings.window = window;

el              = experiment.main.configureEyetracker(SessionSettings);
SessionSettings.el = el;
% Present cute intro
im      = imread('./+experiment/+main/maskingintro.jpg');
tex     = Screen('MakeTexture', window, im);
Screen('DrawTexture', window, tex);
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set the text size
Screen('TextSize', window, 60);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set the blend function for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

SessionData = experiment.main.runSession(SessionSettings);

