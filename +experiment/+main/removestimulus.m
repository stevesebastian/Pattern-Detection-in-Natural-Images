function removestimulus(experimentStruct,stimulusPosX, stimulusPosY, stimulus)
%REMOVESTIMULUS Remove stimulus from screen.
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

    stimulusDestination = experiment.main.positionstimulusonscreen(stimulusPosX, stimulusPosY ,stimulus);
    
    Screen('FillRect', experimentStruct.window, experimentStruct.bgPixVal, stimulusDestination);    
    Screen('Flip', experimentStruct.window);

end