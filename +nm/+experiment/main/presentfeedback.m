function presentfeedback(experimentStruct, trial, response)

    fs = 8000;
    T = .4;
    t = 0:(1/fs):T;

    f = 130.81;   
    
    a = 0.5;

    if experimentStruct.correctResponse(trial) == response
        sound(a*sin(10*pi*f*t));
    else
        sound(a*sin(4*pi*f*t));
    end
    
end