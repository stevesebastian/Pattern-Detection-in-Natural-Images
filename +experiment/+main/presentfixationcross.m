function presentfixationcross(ExpSettings, fixPosXY)
%PRESENTFIXATIONCROSS Draw a fixation cross at the specified position.
%
% Example: 
%   SINGLETRIALDETECTION(ExpSettings, fixationcrossPosX, fixationcrossPosY);
%   
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>
    
ppd                     = ExpSettings.pixelsPerDeg;

blankIntervalS = ExpSettings.blankIntervalMs/1000;
fixationIntervalS = ExpSettings.fixationIntervalMs/1000;

fixationcrossWidthDeg   = 1/20;
fixationcrossLengthDeg  = 1/10;

linewidthPix    = fixationcrossWidthDeg * ppd;
linelengthPix   = fixationcrossLengthDeg * ppd;

xCoordsFix      = [-linelengthPix linelengthPix 0 0];
yCoordsFix      = [0 0 -linelengthPix linelengthPix];

Screen('Drawlines', ExpSettings.window, [xCoordsFix;yCoordsFix], ...
    linewidthPix, 0, [fixPosXY(1), fixPosXY(2)]);

WaitSecs(fixationIntervalS);

if(ExpSettings.bFovea)
    Screen('Flip', ExpSettings.window, 1);
    WaitSecs(blankIntervalS);
end
