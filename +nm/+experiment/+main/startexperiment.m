function blockData = startexperiment(ExpSettings,Block)
%% startexperiment
%
%   Implements the experiment protocol.
%
%   ExpSettings - A settings structure generated with
%   loadexperimentsettings
%   Block         - Block number
% R. Calen Walshe January 14, 2016

% Clear the workspace
close all;
sca;

% Setup PTB with some default values
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
rand('seed', sum(100 * clock));

% Set the screen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Open the screen
[window, windowRect] = Screen('OpenWindow', screenNumber, ExpSettings.bgPixVal, [], [], 2);

BlockStimuli        = ExpSettings.loadStimuliFunction(ExpSettings, size(windowRect), 1);
experimentStruct    =  createexperimentparams(ExpSettings, windowRect, Block);

% Present cute intro
im      = imread('./+nm/+experiment/+main/maskingintro.jpg');
tex     = Screen('MakeTexture', window, im);
Screen('DrawTexture', window, tex);
Screen('Flip', window);
%WaitSecs(2);

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

experimentStruct.window = window;

nm.experiment.main.runexperimentblock(experimentStruct, BlockStimuli.stimuli);

end

function experimentStruct = createexperimentparams(ExpSettings,windowRect, Block)
% createxperimentstruct
% Creates the parameters for the experiment that will be used by PTB.


ppd         = ExpSettings.pixelsPerDeg;
stimPosPix  = ExpSettings.stimPosDeg(:,:,:,Block) * ExpSettings.pixelsPerDeg;
fixPosPix   = ExpSettings.fixPosDeg(:,:,:,Block) * ExpSettings.pixelsPerDeg;
stimPosPix(:,:,1) = stimPosPix(:,:,1,Block) + windowRect(3)/2;
stimPosPix(:,:,2) = stimPosPix(:,:,2,Block) + windowRect(4)/2;
fixPosPix(:,:,1) = fixPosPix(:,:,1,Block) + windowRect(3)/2;
fixPosPix(:,:,2) = fixPosPix(:,:,2,Block) + windowRect(4)/2;

nLevels = ExpSettings.nLevels;
nTrials = ExpSettings.nTrials;

bgPixVal = ExpSettings.bgPixVal;
bFovea   = ExpSettings.bFovea;

targetLevel = ExpSettings.targetLevel(:,:,:,Block);

bTargetPresent = ExpSettings.bTargetPresent(:,:,Block);

experimentStruct = struct('targetLevel', targetLevel, 'ppd', ppd, 'stimPosPix',...
    stimPosPix, 'fixPosPix', fixPosPix, 'bTargetPresent', bTargetPresent, ...
    'nLevels', nLevels, 'nTrials', nTrials, 'bgPixVal', bgPixVal, ...
    'bFovea', bFovea);

end
