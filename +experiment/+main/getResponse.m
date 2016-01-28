function [response, RT] = getResponse(ExpSettings,stimulusOnsetMs)
%% waitforresponse
%
%   Waits for a response to be made. If the response is made during the
%   response interval the response value is returned. Otherwise, the
%   function returns without any response.
%
%   R. Calen Walshe January 14, 2016.

responseIntervalS = ExpSettings.responseIntervalMs/1000;

response            = -1;
RT                  = -1;

t = GetSecs();

while t < responseIntervalS
    % Check the keyboard.
    [~,~, keyCode] = KbCheck;
    if(keyCode(KbName('downarrow')))
        response = 1;
        RT = t - stimulusOnsetMs;
    elseif(keyCode(KbName('leftarrow')))
        response = 0;
        RT = t - stimulusOnsetMs;
    end
    t = GetSecs();
end
