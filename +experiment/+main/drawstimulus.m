function stimulusOnsetMs = drawStimulus(experimentStruct, x, y, stimulus)
%DRAWSTIMULUS Draw the detection stimulus.
%
% Description:
%   The stimulus is presented at the x and y coordinates provided.
%
% Example: 
%   stimulusOnsetMs = DRAWSTIMULUS(experimentStruct, x, y, stimulus);
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

stimulusTexture     = Screen('Maketexture', experimentStruct.window, stimulus);
stimulusDestination = experiment.main.positionstimulusonscreen(x, y, stimulus);

Screen('DrawTexture', experimentStruct.window, stimulusTexture, [], stimulusDestination);

[~, StimulusOnsetTime] = Screen('Flip', experimentStruct.window, 0, 1);

stimulusOnsetMs = StimulusOnsetTime;       
