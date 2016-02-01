function displayLevelStart(SessionSettings, blockNumber)
%% presenttargetonly
%   Used for the beginning of blocks. Presents that target, with text, at
%   the beginning of the block.


% Display the fixation and stimulus position from a random trial in the
% block

randTrial = randsample(SessionSettings.nTrials,1);
fixPosPixXY = SessionSettings.fixPosPix(randTrial, blockNumber, :);
stimPosPixXY = SessionSettings.stimPosPix(randTrial, blockNumber, :);

w       = SessionSettings.window;

fixationcrossWidthDeg       = 1/20;
fixationcrossLengthDeg      = 1/10;

linewidthPix    = fixationcrossWidthDeg.*SessionSettings.pixelsPerDeg;
linelengthPix   = fixationcrossLengthDeg.*SessionSettings.pixelsPerDeg;

xCoordsFix      = [-linelengthPix linelengthPix 0 0];
yCoordsFix      = [0 0 -linelengthPix linelengthPix];
Screen('Drawlines', SessionSettings.window, [xCoordsFix;yCoordsFix], ...
    linewidthPix, 0, [fixPosPixXY(1), fixPosPixXY(2)]);

Screen('TextSize', w, 25);
DrawFormattedText(w, 'Observe the target that you will be required to detect.\nPress any key when ready to continue the experiment.', ...
    'center',SessionSettings.pixelsPerDeg);

target = SessionSettings.targetSamples(:,:,blockNumber);
targetTexture = Screen('MakeTexture', SessionSettings.window, target);

targetRect         = SetRect(0, 0, size(target,2), size(target,1));
targetDestination  = floor(CenterRectOnPointd(targetRect, stimPosPixXY(1), stimPosPixXY(2))); 

Screen('DrawTexture', SessionSettings.window, targetTexture, [], targetDestination);

Screen('Flip',SessionSettings.window);

KbWait();

WaitSecs(1);

