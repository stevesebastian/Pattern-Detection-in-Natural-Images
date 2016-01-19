function presentfixationcross(experimentStruct, fixationcrossPosX, fixationcrossPosY)
%% drawfixationcross
%
%   Draw a fixation cross with several parameters. Most importantly, the
%   position.
%
%   R. Calen Walshe January 14, 2016
    % Draw fixation cross
    ppd                     = experimentStruct.ppd;
    fixationcrossWidthDeg   = 1/20;
    fixationcrossLengthDeg   = 1/10;
    
    
    linewidthPix    = fixationcrossWidthDeg * ppd;
    linelengthPix   = fixationcrossLengthDeg * ppd;
    
    
    xCoordsFix      = [-linelengthPix linelengthPix 0 0];
    yCoordsFix      = [0 0 -linelengthPix linelengthPix];
    Screen('Drawlines', experimentStruct.window, [xCoordsFix;yCoordsFix], ...
        linewidthPix, 0, [fixationcrossPosX, fixationcrossPosY]);
    
    Screen('Flip', experimentStruct.window,0,1);

end