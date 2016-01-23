function removestimulus(experimentStruct,stimulusPosX, stimulusPosY, stimulus)
%% removestimulus
%   Places a mask over the stimulus.
% R. Calen Walshe Jan 15, 2016

    stimulusDestination = nm.experiment.main.positionstimulusonscreen(stimulusPosX, stimulusPosY ,stimulus);
    
    Screen('FillRect', experimentStruct.window, experimentStruct.bgPixVal, stimulusDestination);    
    Screen('Flip', experimentStruct.window);

end