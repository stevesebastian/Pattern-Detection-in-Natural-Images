function stimulusOut = additiveTarget(backgroundImg, targetFunction, TargetParams)
%ADDITIVETARGET Adds the target specified by targetFunction to the background
% 
% Example: 
% 	stimulusOut = ADDITIVETARGET(backgroundImg, @lib.gabor2D, GaborParams);
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

target = targetFunction(TargetParams);

bAdditive = 1;
bitsIn = 8;

stimulusOut = lib.embedImageinCenter(background, target, bAdditive, bitsIn);
