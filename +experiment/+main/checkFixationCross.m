function checkFixationCross(SessionSettings, fixcrossPosX, fixcrossPosY)

if SessionSettings.el.dummyconnected % in dummy mode use mousecoordinates
    [x,y,button] = GetMouse(SessionSettings.window);
    evt.type = SessionSettings.el.ENDSACC;
    evt.genx = x;
    evt.geny = y;
    evtype=SessionSettings.el.ENDSACC;
else % check for events
    evt = Eyelink('NewestFloatSample');
    
    t0 = GetSecs();
    maxTime = 5;
    fixRect = CenterRectOnPoint(SetRect(0,0,60,60), fixcrossPosX, fixcrossPosY);
    
    while 1        
        if IsInRect(evt.gx(2), evt.gy(2), fixRect)
            break;
        elseif GetSecs() > t0 + maxTime
            EyelinkDoTrackerSetup(SessionSettings.el);
            
            Screen('FillRect', SessionSettings.window, SessionSettings.bgPixVal);
            
            target   = SessionSettings.fixationTarget; 
            
            %% Redraw fixation cross and see how we do.

            targetTexture      = Screen('Maketexture', SessionSettings.window, target);
            targetRect         = SetRect(0, 0, size(target,2), size(target,1));
            targetDestination  = floor(CenterRectOnPointd(targetRect, fixcrossPosX, fixcrossPosY)); 

            
            Screen('DrawTexture', SessionSettings.window, targetTexture, [], targetDestination);
            Screen('Flip', SessionSettings.window, 0, 1);
            
            t0 = GetSecs();
        end
        
        [keyIsDown,secs, keyCode] = KbCheck;   
        if      keyCode(KbName('c'))
            EyelinkDoDriftCorrection(SessionSettings.el);
        end
        WaitSecs(.001);               
    end
    
end

end