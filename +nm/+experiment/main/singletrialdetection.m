function [response,responseOnsetMs] = singletrialdetection(experimentStruct,stimulus, trial)
%% singletrialdetection
%   Runs a single trial of a detection experiment.
%
%   R. Calen Walshe January 14, 2016

fixcrossPosX = experimentStruct.fixcrossPosX(trial);
fixcrossPosY = experimentStruct.fixcrossPosY(trial);

stimulusPosX = experimentStruct.stimulusPosX(trial);
stimulusPosY = experimentStruct.stimulusPosY(trial);

presentfixationcross(experimentStruct, fixcrossPosX, fixcrossPosY);

stimulusOnsetMs             = drawstimulus(experimentStruct, stimulusPosX, stimulusPosY, stimulus, trial);            
[response, responseOnsetMs] = waitforresponse(experimentStruct, stimulusOnsetMs);

removestimulus(experimentStruct, stimulusPosX, stimulusPosY, stimulus);

presentfixationcross(experimentStruct, fixcrossPosX, fixcrossPosY);

presentfeedback(experimentStruct,trial, response);
    
end