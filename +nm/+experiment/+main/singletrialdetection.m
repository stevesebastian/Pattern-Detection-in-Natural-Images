function [response,responseOnsetMs] = singletrialdetection(experimentStruct,stimulus, block, trial)
%% singletrialdetection
%   Runs a single trial of a detection experiment.
%
%   R. Calen Walshe January 14, 2016

fixcrossPosX = experimentStruct.fixPosPix(trial, block, 1);
fixcrossPosY = experimentStruct.fixPosPix(trial, block, 2);

stimulusPosX = experimentStruct.stimPosPix(trial, block, 1);
stimulusPosY = experimentStruct.stimPosPix(trial, block, 2);

nm.experiment.main.presentfixationcross(experimentStruct, fixcrossPosX, fixcrossPosY);

stimulusOnsetMs             = nm.experiment.main.drawstimulus(experimentStruct, stimulusPosX, stimulusPosY, stimulus, trial);            
[response, responseOnsetMs] = nm.experiment.main.waitforresponse(experimentStruct, stimulusOnsetMs);

nm.experiment.main.removestimulus(experimentStruct, stimulusPosX, stimulusPosY, stimulus);

nm.experiment.main.presentfixationcross(experimentStruct, fixcrossPosX, fixcrossPosY);

nm.experiment.main.presentfeedback(experimentStruct, block, trial, response);
    
end