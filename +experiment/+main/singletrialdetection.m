function [response,responseOnsetMs] = runSingleTrial(ExpSettings, StimuliSettings, blockNumber, trialNumber)
%SINGLETRIALDETECTION Runs a single trialNumber of the detection experiment
%
% Example: 
%   [response, responseOnsetMs] = SINGLETRIALDETECTION(experimentStruct, stimulus, blockNumber, trialNumber);
%   
%   See also PRESENTFIXATIONCROSS, DRAWSTIMULUS.
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

fixcrossPosX = StimuliSettings.fixPosPix(trialNumber, blockNumber, 1);
fixcrossPosY = StimuliSettings.fixPosPix(trialNumber, blockNumber, 2);

stimulusPosX = StimuliSettings.stimPosPix(trialNumber, blockNumber, 1);
stimulusPosY = StimuliSettings.stimPosPix(trialNumber, blockNumber, 2);

blankIntervalS = ExpSettings.blankIntervalMS/1000;
fixationIntervalS = ExpSettings.fixationIntervalMs/1000;

stimuli = StimuliSettings.
experiment.main.presentfixationcross(ExpSettings, fixcrossPosX, fixcrossPosY);

if ExpSettings.bFovea
    Screen('Flip', ExpSettings.window, 1);
    WaitSecs(blankIntervalS);
else
    WaitSecs(fixationIntervalS);
end

stimulusOnsetMs = experiment.main.drawstimulus(ExpSettings, stimulusPosX, stimulusPosY, stimulus);

WaitSecs(experimentStruct.displayTimeSeconds);

[response, responseOnsetMs] = experiment.main.waitforresponse(experimentStruct, stimulusOnsetMs);

experiment.main.removestimulus(experimentStruct, stimulusPosX, stimulusPosY, stimulus);

experiment.main.presentfixationcross(experimentStruct, fixcrossPosX, fixcrossPosY);

experiment.main.presentfeedback(experimentStruct, blockNumber, trialNumber, response);
    
end