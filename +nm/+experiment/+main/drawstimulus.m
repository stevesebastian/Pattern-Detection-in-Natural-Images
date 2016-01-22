function stimulusOnsetMs = drawstimulus(experimentStruct, x, y, stimulus, trial)
% drawstimulus
%
% Draws the stimulus for a trial on the screen at the x and y stimulus
% coordinates.
%
% R. Calen Walshe January 14, 2016.

stimulusTexture     = Screen('Maketexture', experimentStruct.window, stimulus);
stimulusDestination = nm.experiment.main.positionstimulusonscreen(x, y, stimulus);

Screen('DrawTexture', experimentStruct.window, stimulusTexture, [], stimulusDestination);

[VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', experimentStruct.window, 0, 1);

stimulusOnsetMs = StimulusOnsetTime;       
end