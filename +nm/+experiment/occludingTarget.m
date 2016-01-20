function stimulusOut = occludingTarget(backgroundImg, targetFunction, TargetParams)
%ADDITIVETARGET Adds the target specified by targetFunction to the background
% 
% Example: 
% 	stimulusOut = ADDITIVETARGET(backgroundImg, @nm.lib.haar2D, HaarParams);
%
% 1/19/2016, R.C Walshe <calen.walshe@gmail.com>

target = targetFunction(TargetParams);

bAdditive = 0;
bitsIn = 8;

stimulusOut = nm.lib.embedImageinCenter(background, target, bAdditive, bitsIn);
