function [response, RT] = waitforresponse(experimentStruct,stimulusOnsetMs)
%% waitforresponse
%
%   Waits for a response to be made. If the response is made during the
%   response interval the response value is returned. Otherwise, the
%   function returns without any response.
%
%   R. Calen Walshe January 14, 2016.
    response            = -1;
    RT                  = -1; 
    maxPresentationTime = stimulusOnsetMs + 1.5; %CHANGE TO VARIABLE

    t = GetSecs();
      
    while t < maxPresentationTime     
        % Check the keyboard.
        [keyIsDown,secs, keyCode] = KbCheck;   
        if      keyCode(KbName('leftarrow'))
                    response        = 1;
                    RT = t - stimulusOnsetMs;
        elseif  keyCode(KbName('rightarrow'))
                    response        = 0;
                    RT = t - stimulusOnsetMs;
        end
        t = GetSecs();
        WaitSecs(.001);
    end
    
end