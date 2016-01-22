function runexperimentblock(experimentStruct,stimulusArray)
%% function runoccludebinexp
%   Description: This script runs through a set of trials defined by a
%   block.
%
%   Author: R. Calen Walshe January 16, 2016

%setupblock(experimentStruct)

nTrials     = experimentStruct.nTrials;
nLevels     = experimentStruct.nLevels;

blockData = zeros(nLevels, nTrials, 2);

for i = 1:nLevels
    presenttargetonly(experimentStruct);    
    levelStimulus = stimulusArray(:,:,:,i);
    for k = 1:nTrials
        trial = k;
        stimulus = levelStimulus(:,:,trial);
        [response, RT] = singletrialdetection(experimentStruct, stimulus, trial);

        blockData(nLevels, nTrials, 1) = response;
        blockData(nLevels, nTrials, 2) = RT;

        WaitSecs(experimentStruct.STIMULUSDELAY); % wait time between trials
    end

    Screen('TextSize', experimentStruct.window, 25)
    DrawFormattedText(experimentStruct.window, 'End of the block', 'center', 'center');
    Screen('Flip', experimentStruct.window);
  
end

end

function presenttargetonly(experimentStruct)
%% presenttargetonly
%   Used for the beginning of blocks. Presents that target, with text, at
%   the beginning of the block.

w = experimentStruct.window;

ppd                         = experimentStruct.ppd;
fixationcrossWidthDeg       = 1/20;
fixationcrossLengthDeg      = 1/10;

linewidthPix    = fixationcrossWidthDeg * ppd;
linelengthPix   = fixationcrossLengthDeg * ppd;

xCoordsFix      = [-linelengthPix linelengthPix 0 0];
yCoordsFix      = [0 0 -linelengthPix linelengthPix];
Screen('Drawlines', experimentStruct.window, [xCoordsFix;yCoordsFix], ...
    linewidthPix, 0, [experimentStruct.fixcrossPosX(1), experimentStruct.fixcrossPosY(1)]);

oldTextSize          = Screen('TextSize', w, 25);
[nx, ny, textbounds] = DrawFormattedText(w, 'Observe the target that you will be required to detect.\nPress spacebar when ready to continue the experiment.', 'center',1*experimentStruct.ppd);
targetTexture        = Screen('MakeTexture', w, experimentStruct.target);

Screen('DrawTexture', w, targetTexture);

Screen('Flip',w);

[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(KbName('space'))
    [keyIsDown,secs, keyCode] = KbCheck;
end

end

