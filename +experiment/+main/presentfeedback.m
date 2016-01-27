function presentfeedback(experimentStruct, block, trial, response)
%PRESENTFEEDBACK Present feedback about performance.
%
%
% v1.0, 1/20/2016, R. C. Walshe <calen.walshe@utexas.edu>

bTargetPresent = experimentStruct.bTargetPresent(trial,block);

if bTargetPresent == response
    Beeper(800, 1, .3);
else
    Beeper(200, 1, .3);
end
    
end