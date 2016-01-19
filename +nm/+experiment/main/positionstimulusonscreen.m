function stimulusDestination = positionstimulusonscreen(x,y, stimulus)
%% positionstimulusonscreen
%
%   Find the coordinates to pass that will enable the stimulus to be placed
%   on the correct pixel position on the screen. The x,y coordinates for
%   the centre of the stimulus are supplied along with the stimulus to be
%   presented. The stimulus is used to compute the size of the stimulus
%   presentation rectangle.

stimulusRect         = SetRect(0, 0, size(stimulus,2), size(stimulus,1));
stimulusDestination  = floor(CenterRectOnPointd(stimulusRect, x, y));   

end