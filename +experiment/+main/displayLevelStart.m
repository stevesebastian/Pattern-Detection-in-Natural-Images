function displayLevelStart(ExpSettings, SessionStimuli, blockNumber)
%% presenttargetonly
%   Used for the beginning of blocks. Presents that target, with text, at
%   the beginning of the block.


% Display the fixation and stimulus position from a random trial in the
% block

randTrial = randsample(ExpSettings.nTrials,1);
fixPosPixXY = SessionStimuli.fixPosPix(randTrial, blockNumber, :);
stimPosPixXY = SessionStimuli.stimPosPix(randTrial, blockNumber, :);

w       = ExpSettings.window;

fixationcrossWidthDeg       = 1/20;
fixationcrossLengthDeg      = 1/10;

linewidthPix    = fixationcrossWidthDeg.*ExpSettings.pixelsPerDeg;
linelengthPix   = fixationcrossLengthDeg.*ExpSettings.pixelsPerDeg;

xCoordsFix      = [-linelengthPix linelengthPix 0 0];
yCoordsFix      = [0 0 -linelengthPix linelengthPix];
Screen('Drawlines', ExpSettings.window, [xCoordsFix;yCoordsFix], ...
    linewidthPix, 0, [fixPosPixXY(1), fixPosPixXY(2)]);

Screen('TextSize', w, 25);
DrawFormattedText(w, 'Observe the target that you will be required to detect.\nPress any key when ready to continue the experiment.', ...
    'center',ExpSettings.pixelsPerDeg);

target = SessionStimuli.targetSamples(:,:,blockNumber);
targetTexture = Screen('MakeTexture', ExpSettings.window, target);

targetRect         = SetRect(0, 0, size(target,2), size(target,1));
targetDestination  = floor(CenterRectOnPointd(targetRect, stimPosPixXY(1), stimPosPixXY(2))); 

Screen('DrawTexture', ExpSettings.window, targetTexture, [], targetDestination);

Screen('Flip',ExpSettings.window);

KbWait();

WaitSecs(1);

