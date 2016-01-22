function presentfeedback(experimentStruct, block, trial, response)

bTargetPresent = experimentStruct.bTargetPresent(trial,block);

if bTargetPresent == response
    Beeper(800, 1, .3);
else
    Beeper(200, 1, .3);
end
    
end