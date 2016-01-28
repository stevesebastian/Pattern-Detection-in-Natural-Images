function fixationInterval(SessionSettings, trialNumber, levelNumber)
%PRESENTFIXATIONCROSS Draw a fixation cross at the specified position.
%
% Example: 
%   SINGLETRIALDETECTION(SessionSettings, fixationcrossPosX, fixationcrossPosY);
%   
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

%% Set up 
target = SessionSettings.fixationTarget; 
fixPosXY = SessionSettings.fixPosPix(trialNumber, levelNumber, :);
fixationIntervalS = SessionSettings.fixationIntervalS;

targetTexture  = Screen('Maketexture', SessionSettings.window, target);
targetRect         = SetRect(0, 0, size(target,2), size(target,1));
targetDestination  = floor(CenterRectOnPointd(targetRect, fixPosXY(1), fixPosXY(2)));  

%% Draw target followed by blank if foveal experiment

Screen('DrawTexture', SessionSettings.window, targetTexture, [], targetDestination);
WaitSecs(fixationIntervalS);

if(SessionSettings.bFovea)
    blankIntervalS = SessionSettings.blankIntervalS;
    Screen('Flip', SessionSettings.window, 1);
    WaitSecs(blankIntervalS);
end
