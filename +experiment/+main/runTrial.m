function [response,responseTimeMs] = runTrial(SessionSettings, trialNumber, levelNumber)
%SINGLETRIALDETECTION Runs a single trialNumber of the detection experiment
%
% Example: 
%   [response, responseOnsetMs] = SINGLETRIALDETECTION(experimentStruct, stimulus, levelNumber, trialNumber);
%   
%   See also PRESENTFIXATIONCROSS, DRAWSTIMULUS.
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

if(~SessionSettings.bFovea)        
    experiment.main.checkFixationCross(SessionSettings, trialNumber, SessionSettings.fixPosPix(trialNumber, levelNumber, :));
end

experiment.main.fixationInterval(SessionSettings, trialNumber, levelNumber);

experiment.main.stimulusInterval(SessionSettings, trialNumber, levelNumber);

[response, responseTimeMs] = experiment.main.responseInterval(SessionSettings, trialNumber, levelNumber);

experiment.main.giveFeedback(SessionSettings, response, trialNumber, levelNumber);

if SessionSettings.bFovea
    Eyelink('Message', 'TRIAL_RESULT 0')
end