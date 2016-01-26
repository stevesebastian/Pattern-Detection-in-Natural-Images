function [response,responseOnsetMs] = singletrialdetection(experimentStruct,stimulus, block, trial)
%SINGLETRIALDETECTION Runs a single trial of the detection experiment
%
% Example: 
%   [response, responseOnsetMs] = SINGLETRIALDETECTION(experimentStruct, stimulus, block, trial);
%   
%   See also PRESENTFIXATIONCROSS, DRAWSTIMULUS.
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

fixcrossPosX = experimentStruct.fixPosPix(trial, block, 1);
fixcrossPosY = experimentStruct.fixPosPix(trial, block, 2);

stimulusPosX = experimentStruct.stimPosPix(trial, block, 1);
stimulusPosY = experimentStruct.stimPosPix(trial, block, 2);

nm.experiment.main.presentfixationcross(experimentStruct, fixcrossPosX, fixcrossPosY);

if experimentStruct.bFovea
    Screen('Flip', experimentStruct.window, 1);
    WaitSecs(experimentStruct.fixcrossOffSeconds);
else
    WaitSecs(experimentStruct.stimulusDelaySeconds);
end

stimulusOnsetMs             = nm.experiment.main.drawstimulus(experimentStruct, stimulusPosX, stimulusPosY, stimulus);

WaitSecs(experimentStruct.displayTimeSeconds);

[response, responseOnsetMs] = nm.experiment.main.waitforresponse(experimentStruct, stimulusOnsetMs);

nm.experiment.main.removestimulus(experimentStruct, stimulusPosX, stimulusPosY, stimulus);

nm.experiment.main.presentfixationcross(experimentStruct, fixcrossPosX, fixcrossPosY);

nm.experiment.main.presentfeedback(experimentStruct, block, trial, response);
    
end