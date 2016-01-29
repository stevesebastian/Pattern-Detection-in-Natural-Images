function stimulusOnsetMs = stimulusInterval(SessionSettings, trialNumber, levelNumber)
%DRAWSTIMULUS Draw the detection stimulus.
%
% Description:
%   The stimulus is presented at the x and y coordinates provided.
%
% Example: 
%   stimulusOnsetMs = DRAWSTIMULUS(SessionSettings, x, y, stimulus);
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

%% Set up 
stimulusIntervalS = SessionSettings.stimulusIntervalS;

stimulus = SessionSettings.stimuli(:,:,trialNumber,levelNumber);

stimulusTexture     = Screen('Maketexture', SessionSettings.window, stimulus);
stimPosXY = SessionSettings.stimPosPix(trialNumber, levelNumber,:);

stimulusRect         = SetRect(0, 0, size(stimulus,2), size(stimulus,1));
stimulusDestination  = floor(CenterRectOnPointd(stimulusRect, stimPosXY(1), stimPosXY(2)));  

%% Display stimulus

Screen('DrawTexture', SessionSettings.window, stimulusTexture, [], stimulusDestination);
[~, StimulusOnsetTime] = Screen('Flip', SessionSettings.window, 0, 1);

WaitSecs(stimulusIntervalS);

Screen('FillRect', SessionSettings.window, SessionSettings.bgPixVal, stimulusDestination);
Screen('Flip', SessionSettings.window);

stimulusOnsetMs = StimulusOnsetTime;
