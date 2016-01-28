function runexperimentblock(SessionSettings, SessionStimuli)
%RUNEXPERIMENTBLOCK Runs a single block of an experiment.
% Description: 
%   A block consists of N levels. Each level contains M trials. The
%   experiment protocol is agnostic to what visual content define the block
%   and levels. stimulusArray defines what is present and is setup prior to
%   the experiment (see +stats).
%
% Example: 
%   [response, responseOnsetMs] = SINGLETRIALDETECTION(ExperimentStruct, stimulus, block, trial);
%   
%   See also SINGLETRIALDETECTION
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

nTrials     = SessionSettings.nTrials;
nLevels     = SessionSettings.nLevels;

fixationIntervalS = SessionSettings.fixationIntervalMs/1000;
responseIntervalS = SessionSettings.responseIntervalMs/1000;

blockData = zeros(nLevels, nTrials, 2);

for iLevel = 1:nLevels
    block = iLevel;
        
%     presenttargetonly(SessionSettings, iLevel);
    
    experiment.main.presentfixationcross(SessionSettings, SessionStimuli.fixPosPix(1, block, 1), SessionStimuli.fixPosPix(1, block, 2));    
    
    WaitSecs(fixationIntervalS);
    
    levelStimuli = SessionStimuli.stimuli(:,:,:,iLevel);
    
    for iTrial = 1:nTrials

        stimulus = levelStimuli(:,:,iTrial);
        [response, RT] = experiment.main.singletrialdetection(SessionSettings, stimulus, iLevel, iTrial);

        blockData(nLevels, nTrials, 1) = response;
        blockData(nLevels, nTrials, 2) = RT;

        WaitSecs(responseIntervalS);

    Screen('TextSize', ExperimentStruct.window, 25);
    DrawFormattedText(ExperimentStruct.window, 'End of the block', 'center', 'center');
    Screen('Flip', ExperimentStruct.window);
    WaitSecs(1);
  
    end
end

end

function presenttargetonly(ExperimentStruct, Level)
%% presenttargetonly
%   Used for the beginning of blocks. Presents that target, with text, at
%   the beginning of the block.

posInd = randsample(1:ExperimentStruct.nTrials,1);


fixX = ExperimentStruct.fixPosPix(posInd, Level, 1);
fixY = ExperimentStruct.fixPosPix(posInd, Level, 2);

stimX = ExperimentStruct.stimPosPix(posInd, Level, 1);
stimY = ExperimentStruct.stimPosPix(posInd, Level, 2);

w       = ExperimentStruct.window;

ppd                         = ExperimentStruct.ppd;
fixationcrossWidthDeg       = 1/20;
fixationcrossLengthDeg      = 1/10;

linewidthPix    = fixationcrossWidthDeg * ppd;
linelengthPix   = fixationcrossLengthDeg * ppd;

xCoordsFix      = [-linelengthPix linelengthPix 0 0];
yCoordsFix      = [0 0 -linelengthPix linelengthPix];
Screen('Drawlines', ExperimentStruct.window, [xCoordsFix;yCoordsFix], ...
    linewidthPix, 0, [fixX, fixY]);

oldTextSize          = Screen('TextSize', w, 25);
[nx, ny, textbounds] = DrawFormattedText(w, 'Observe the target that you will be required to detect.\nPress spacebar when ready to continue the experiment.', 'center',1*ExperimentStruct.ppd);

 targetTexture        = Screen('MakeTexture', w, ExperimentStruct.targetLevel(:,:,Level));
stimulusDestination = experiment.main.positionstimulusonscreen(stimX, stimY, ExperimentStruct.targetLevel(:,:,1));

Screen('DrawTexture', ExperimentStruct.window, targetTexture, [], stimulusDestination);

Screen('Flip',w);

[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(KbName('space'))
    [keyIsDown,secs, keyCode] = KbCheck;
end

end

