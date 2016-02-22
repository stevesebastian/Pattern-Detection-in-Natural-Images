function runMaskingExperimentTest(subjectStr, expTypeStr, targetTypeStr, binIndex, sessionNumber, levelNumber)
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
% load ./+experiment/+main/GammaLookup.mat
% Screen('LoadNormalizedGammaTable', window, GammaLookup*[1 1 1]);

ExpSettings.monitorSizePix = windowRect(3:4);

bFovea = 1;

levelStartIndex = ExpSettings.levelStartIndex;
subjectStr = ExpSettings.subjectStr; 
expTypeStr = ExpSettings.expTypeStr;
targetTypeStr = ExpSettings.targetTypeStr;

currentBin = ExpSettings.currentBin;
currentSession = ExpSettings.currentSession;

monitorSizePix = ExpSettings.monitorSizePix;

stimuliIndex = ExpSettings.stimuliIndex(:,:,currentSession); 
stimuli = ExpSettings.stimuli(:,:,:,:,currentSession);
target = ExpSettings.target;
targetAmplitude = ExpSettings.targetAmplitude(:,:,currentSession);
bTargetPresent = ExpSettings.bTargetPresent(:,:,currentSession);
bgPixVal = ExpSettings.bgPixVal; 
pixelsPerDeg = ExpSettings.pixelsPerDeg; 

stimPosDeg = ExpSettings.stimPosDeg(:,:,currentSession, :);
fixPosDeg = ExpSettings.fixPosDeg(:,:,currentSession, :);

stimPosPixXY = lib.monitorDegreesToPixels(stimPosDeg, monitorSizePix, pixelsPerDeg);
fixPosPix = lib.monitorDegreesToPixels(fixPosDeg, monitorSizePix, pixelsPerDeg);

bAdditive   = 1;
bitDepthIn  = 14;
bitDepthOut = 8;

% Create the circular mask
maskSizePix      = size(stimuli(:,:,:,1,1));
maskCenterXY     = [ceil(maskSizePix(1)/2) ceil(maskSizePix(2)/2)];
maskRadiusPix    = ceil((maskSizePix(1)-1)/2); 
[maskX, maskY]   = meshgrid(-(maskCenterXY(1)-1):(maskSizePix(1)-maskCenterXY(1)), -(maskCenterXY(2)-1):(maskSizePix(2)-maskCenterXY(2)));
circMask        = ((maskX.^2+maskY.^2)<=(maskRadiusPix.^2));

nTrials = ExpSettings.nTrials;
nLevels = ExpSettings.nLevels;

targetSizePix = 513;
ditherFilter = ones(targetSizePix,targetSizePix);
ditherFilter(1:2:targetSizePix, 1:2:targetSizePix) = 0;

ditherFilter = ones(targetSizePix.*targetSizePix,1);
ditherFilter(1:2:length(ditherFilter)) = 0;
ditherFilter = reshape(ditherFilter, [targetSizePix, targetSizePix]);

%% Create target examples
ditherFactor = 1;
while 1
    targetSamples = bgPixVal.*ones([513, 513]);
    targetSamplesD = bgPixVal.*ones([513,  513]);

    thisTarget = mean(targetAmplitude(:,1)).*255;
    thisTargetD = thisTarget.*ditherFilter.*ditherFactor;
    
    thisTarget = 50.*ones([513, 513]);
    thisTargetD = 50.*ones([513, 513]).*ditherFactor.*ditherFilter;
    
    targetSamples = ...
            round(lib.embedImageinCenter(targetSamples, thisTarget, bAdditive, bitDepthOut));
    targetSamplesD = ...
            round(lib.embedImageinCenter(targetSamplesD, thisTargetD, bAdditive, bitDepthOut));

    target2 = targetSamples;
    targetD2 = targetSamplesD;
    targetTexture = Screen('MakeTexture', window, target2);
    targetTextureD = Screen('MakeTexture', window, targetD2);

    targetRect         = SetRect(0, 0, size(target2,2), size(target2,1));
    targetDestination  = floor(CenterRectOnPointd(targetRect, stimPosPixXY(1), stimPosPixXY(2))); 
    targetDestinationD  = floor(CenterRectOnPointd(targetRect, stimPosPixXY(1)+400, stimPosPixXY(2))); 

    Screen('DrawTexture', window, targetTextureD, [], targetDestinationD);
    Screen('DrawTexture', window, targetTexture, [], targetDestination);

    Screen('Flip',window);
    keyboard
end
KbWait();

