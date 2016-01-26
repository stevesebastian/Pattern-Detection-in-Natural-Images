function presentfixationcross(experimentStruct, fixationcrossPosX, fixationcrossPosY)
%PRESENTFIXATIONCROSS Draw a fixation cross at the specified position.
%
% Example: 
%   SINGLETRIALDETECTION(experimentStruct, fixationcrossPosX, fixationcrossPosY);
%   
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>
    
    ppd                     = experimentStruct.ppd;
    fixationcrossWidthDeg   = 1/20;
    fixationcrossLengthDeg  = 1/10;
    
    
    linewidthPix    = fixationcrossWidthDeg * ppd;
    linelengthPix   = fixationcrossLengthDeg * ppd;
    
    
    xCoordsFix      = [-linelengthPix linelengthPix 0 0];
    yCoordsFix      = [0 0 -linelengthPix linelengthPix];
    Screen('Drawlines', experimentStruct.window, [xCoordsFix;yCoordsFix], ...
        linewidthPix, 0, [fixationcrossPosX, fixationcrossPosY]);
    
    if(experimentStruct.bFovea == 1)
        Screen('Flip', experimentStruct.window);
    else
        Screen('Flip', experimentStruct.window,0,1);
    end
end