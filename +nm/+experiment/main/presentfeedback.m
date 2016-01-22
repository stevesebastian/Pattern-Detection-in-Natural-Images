function presentfeedback(experimentStruct, trial, response)

if experimentStruct.correctResponse(trial) == response
    Beeper(800, 1, .3);
else
    Beeper(200, 1, .3);
end
    
end