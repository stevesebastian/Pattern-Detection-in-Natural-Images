function bChkFix = checkfixationoncross(el, fixcrossPosX, fixcrossPosY)

if Eyelink('isconnected') == el.dummyconnected % in dummy mode use mousecoordinates
    [x,y,button] = GetMouse(window);
    evt.type=el.ENDSACC;
    evt.genx=x;
    evt.geny=y;
    evtype=el.ENDSACC;
else % check for events
    evtype=Eyelink('getnextdatatype');
    evt = Eyelink('getfloatdata', evtype); % get data
    
    t0 = GetSecs();
    maxTime = 2;
    fixRect = CenterRectOnPoint(SetRect(0,0,60,60), fixcrossPosX, fixcrossPosY);
    
    while 1        
        if IsInRect(evt.genx, evt.geny, fixRect)
            break;
        elseif GetSecs() < t0 + maxTime
            EyelinkDoTrackerSetup(el);
        end
        
            [keyIsDown,secs, keyCode] = KbCheck;   
            if      keyCode(KbName('c'))
                EyelinkDoDriftCorrection(el);
            end
            
            t = GetSecs();
            WaitSecs(.001);               
    end
    
end

end