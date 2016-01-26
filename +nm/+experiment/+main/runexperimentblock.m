function runexperimentblock(experimentStruct,stimulusArray)
%RUNEXPERIMENTBLOCK Runs a single block of an experiment.
% Description: 
%   A block consists of N levels. Each level contains M trials. The
%   experiment protocol is agnostic to what visual content define the block
%   and levels. stimulusArray defines what is present and is setup prior to
%   the experiment (see +stats).
%
% Example: 
%   [response, responseOnsetMs] = SINGLETRIALDETECTION(experimentStruct, stimulus, block, trial);
%   
%   See also SINGLETRIALDETECTION
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

nTrials     = experimentStruct.nTrials;
nLevels     = experimentStruct.nLevels;

blockData = zeros(nLevels, nTrials, 2);

for i = 1:nLevels
    block = i;
    
    
    presenttargetonly(experimentStruct, i);
    
    nm.experiment.main.presentfixationcross(experimentStruct, experimentStruct.fixPosPix(1, block, 1), experimentStruct.fixPosPix(1, block, 2));    
    
    WaitSecs(1);
    
    levelStimulus = stimulusArray(:,:,:,i);
    for k = 1:nTrials
        trial = k;
        stimulus = levelStimulus(:,:,trial);
        [response, RT] = nm.experiment.main.singletrialdetection(experimentStruct, stimulus, block, trial);

        blockData(nLevels, nTrials, 1) = response;
        blockData(nLevels, nTrials, 2) = RT;

        WaitSecs(.5); % ADD AS VARIABLE
    end

    Screen('TextSize', experimentStruct.window, 25);
    DrawFormattedText(experimentStruct.window, 'End of the block', 'center', 'center');
    Screen('Flip', experimentStruct.window);
    WaitSecs(1);
  
end

end

function presenttargetonly(experimentStruct, Level)
%% presenttargetonly
%   Used for the beginning of blocks. Presents that target, with text, at
%   the beginning of the block.

posInd = randsample(1:experimentStruct.nTrials,1);


fixX = experimentStruct.fixPosPix(posInd, Level, 1);
fixY = experimentStruct.fixPosPix(posInd, Level, 2);

stimX = experimentStruct.stimPosPix(posInd, Level, 1);
stimY = experimentStruct.stimPosPix(posInd, Level, 2);

w       = experimentStruct.window;

ppd                         = experimentStruct.ppd;
fixationcrossWidthDeg       = 1/20;
fixationcrossLengthDeg      = 1/10;

linewidthPix    = fixationcrossWidthDeg * ppd;
linelengthPix   = fixationcrossLengthDeg * ppd;

xCoordsFix      = [-linelengthPix linelengthPix 0 0];
yCoordsFix      = [0 0 -linelengthPix linelengthPix];
Screen('Drawlines', experimentStruct.window, [xCoordsFix;yCoordsFix], ...
    linewidthPix, 0, [fixX, fixY]);

oldTextSize          = Screen('TextSize', w, 25);
[nx, ny, textbounds] = DrawFormattedText(w, 'Observe the target that you will be required to detect.\nPress spacebar when ready to continue the experiment.', 'center',1*experimentStruct.ppd);

 targetTexture        = Screen('MakeTexture', w, experimentStruct.targetLevel(:,:,Level));
stimulusDestination = nm.experiment.main.positionstimulusonscreen(stimX, stimY, experimentStruct.targetLevel(:,:,1));

Screen('DrawTexture', experimentStruct.window, targetTexture, [], stimulusDestination);

Screen('Flip',w);

[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(KbName('space'))
    [keyIsDown,secs, keyCode] = KbCheck;
end

end

