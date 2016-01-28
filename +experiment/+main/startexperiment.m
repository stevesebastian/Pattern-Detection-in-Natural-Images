
function SessionData = startexperiment(SessionSettings,blockNumber)
%STARTEXPERIMENT Launch the detection experiment.
%
% Example: 
%   blockData = STARTEXPERIMENT(SessionSettings, blockNumber);
%   
%   See also RUNEXPERIMENTBLOCK
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

% Clear the workspace
close all;
sca;

% Setup PTB with some default values
PsychDefaultSetup(2);

% Seed the random number generator
rand('seed', sum(100 * clock));

% Set the screen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Open the screen
[window, windowRect] = Screen('OpenWindow', screenNumber, SessionSettings.bgPixVal, [], [], 2);
SessionSettings.window = window;
SessionSettings.bFovea = 1;

SessionStimuli = SessionSettings.loadSessionStimuli(SessionSettings, windowRect(3:4), blockNumber);

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

SessionData = experiment.main.runSession(SessionSettings, SessionStimuli);

