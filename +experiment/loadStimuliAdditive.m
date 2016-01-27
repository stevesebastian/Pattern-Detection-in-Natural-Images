function BlockStimuli = loadStimuliAdditive(ExpSettings, monitorSizePix, blockNumber)
%LOADSTIMULIADDITIVE Formats and loads stimuli for experiment 
% 
% Example: 
%  BlockStimuli = LOADSTIMULIADDITIVE(ExpSettings, monitorSizePix, 1); 
%
% Output: 
%  BlockStimuli Structure containing stimuli and experiment settings
%
% v1.0, 1/22/2016, Steve Sebastian <sebastian@utexas.edu>

%% Set up 

stimuli = ExpSettings.stimuli(:,:,:,:,blockNumber);
target = ExpSettings.target;
targetAmplitude = ExpSettings.targetAmplitude(:,:,blockNumber);
bTargetPresent = ExpSettings.bTargetPresent(:,:,blockNumber);
bgPixVal = ExpSettings.bgPixVal; 
pixelsPerDeg = ExpSettings.pixelsPerDeg; 

stimPosDeg = ExpSettings.stimPosDeg(:,:,:,blockNumber);
fixPosDeg = ExpSettings.fixPosDeg(:,:,:,blockNumber);

stimPosPix = lib.monitorDegreesToPixels(stimPosDeg, monitorSizePix, pixelsPerDeg);
fixPosPix = lib.monitorDegreesToPixels(fixPosDeg, monitorSizePix, pixelsPerDeg);

bAdditive = 1;
bitDepthIn = 14;
bitDepthOut = 8;

% Create the circular mask
maskSizePix      = size(stimuli(:,:,:,1,1));
maskCenterXY     = [ceil(maskSizePix(1)/2) ceil(maskSizePix(2)/2)];
maskRadiusPix    = ceil((maskSizePix(1)-1)/2); 
[maskX, maskY]   = meshgrid(-(maskCenterXY(1)-1):(maskSizePix(1)-maskCenterXY(1)), -(maskCenterXY(2)-1):(maskSizePix(2)-maskCenterXY(2)));
circMask        = ((maskX.^2+maskY.^2)<=(maskRadiusPix.^2));

nTrials = ExpSettings.nTrials;
nLevels = ExpSettings.nLevels;

%% Add stimuli to backgrounds
for iTrials = 1:nTrials
    for iLevels = 1:nLevels
        thisStimulus = stimuli(:,:,iTrials,iLevels);
        
        % Convert to 8 bit
        thisStimulus = round((thisStimulus./(2^bitDepthIn-1))*(2^bitDepthOut-1));
        
        if(bTargetPresent(iTrials, iLevels))
            thisTarget = target.*targetAmplitude(iTrials,iLevels)*255;
            thisStimulus = ...
                lib.embedImageinCenter(thisStimulus, thisTarget, bAdditive, bitDepthOut);
        end

        % Apply the mask
        thisStimulus(~circMask) = bgPixVal;
        stimuli(:,:,iTrials,iLevels) = thisStimulus;
    end
end

%% Create target examples
targetSamples = bgPixVal.*ones([size(stimuli, 1) size(stimuli,2), iLevels]);

for iLevels = 1:nLevels
    thisTarget = target.*mean(targetAmplitude(:,iLevels)).*bgPixVal;
    
    targetSamples(:,:,iLevels) = ...
        lib.embedImageinCenter(targetSamples(:,:,iLevels), thisTarget, bAdditive, bitDepthOut);
end

BlockStimuli = struct('stimuli', stimuli, 'bTargetPresent', bTargetPresent, ...
    'stimPosPix', stimPosPix, 'fixPosPix', fixPosPix,'bgPixVal', bgPixVal, ...
    'targetSamples', targetSamples);