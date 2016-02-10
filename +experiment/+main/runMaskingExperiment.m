function runMaskingExperiment(subjectStr, expTypeStr, targetTypeStr, binIndex, sessionNumber, levelNumber)
%STARTEXPERIMENT Launch the detection experiment.
%
% Example: 
%   blockData = STARTEXPERIMENT(ExpSettings, blockNumber);
%   
%   See also RUNEXPERIMENTBLOCK
%
% v2.0, 1/27/2016, Steve Sebastian, R. C. Walshe <calen.walshe@utexas.edu>

%% Load in the settings
if(nargin < 4)
    ExpSettings = experiment.loadCurrentSession(subjectStr, expTypeStr, targetTypeStr);
else
    ExpSettings = experiment.loadCurrentSession(subjectStr, expTypeStr, targetTypeStr, binIndex, sessionNumber, levelNumber);
end

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
[window, windowRect] = Screen('OpenWindow', screenNumber, ExpSettings.bgPixVal, [], [], 2);

ExpSettings.monitorSizePix = windowRect(3:4);

SessionSettings = ExpSettings.loadSessionStimuli(ExpSettings);

SessionSettings.window = window;

if(~SessionSettings.bFovea)
    Eyelink('Shutdown');
    el = experiment.main.configureEyetracker(window);
    SessionSettings.el     = el;
end

% Present cute intro
 im      = imread('./+experiment/+main/maskingintro.jpg');
tex     = Screen('MakeTexture', window, im);
Screen('DrawTexture', window, tex);
Screen('Flip', window);

% Set the text size
Screen('TextSize', window, 60);

% Set the blend function for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

experiment.main.runSession(SessionSettings);

