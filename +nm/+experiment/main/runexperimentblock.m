function runexperimentblock(experimentStruct,stimulusArray)
%% function runoccludebinexp
%   Description: This script runs through a set of trials defined by a
%   block.
%
%   Author: R. Calen Walshe January 16, 2016

%setupblock(experimentStruct)

MAX_TRIALS = experimentStruct.MAX_TRIALS;

presenttargetonly(experimentStruct);

blockData = zeros(MAX_TRIALS, 4);

for i = 1:MAX_TRIALS
    trial = i;
    stimulus = stimulusArray(:,:,i);
    [response, RT] = singletrialdetection(experimentStruct, stimulus, trial);
        
    blockData(i,1) = response;
    blockData(i,2) = RT;
    
    WaitSecs(experimentStruct.STIMULUSDELAY); % wait time between trials
end

Screen('TextSize', experimentStruct.window, 25)
DrawFormattedText(experimentStruct.window, 'End of the block', 'center', 'center');
Screen('Flip', experimentStruct.window);
  
end

function presenttargetonly(experimentStruct)
%% presenttargetonly
%   Used for the beginning of blocks. Presents that target, with text, at
%   the beginning of the block.

w = experimentStruct.window;

Screen('Flip', w,1);

oldTextSize          = Screen('TextSize', w, 25);
[nx, ny, textbounds] = DrawFormattedText(w, 'Observe the target that you will be required to detect.\nPress spacebar when ready to continue the experiment.', 'center',1*experimentStruct.ppd);
targetTexture        = Screen('MakeTexture', w, experimentStruct.target);

Screen('DrawTexture', w, targetTexture);
Screen('Flip', w);

[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(KbName('space'))
    [keyIsDown,secs, keyCode] = KbCheck;   
end

end

