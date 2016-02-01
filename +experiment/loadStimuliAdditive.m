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

bFovea = ExpSettings.bFovea;

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

bAdditive   = 1;
bitDepthIn  = 14;
bitDepthOut = 8;

responseIntervalS = ExpSettings.responseIntervalMs/1000;
stimulusIntervalS = ExpSettings.stimulusIntervalMs/1000;
fixationIntervalS = ExpSettings.fixationIntervalMs/1000;
blankIntervalS    = ExpSettings.blankIntervalMs/1000;

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

%% Create the fixation target
fixationSize = round(pixelsPerDeg.*0.1);
fixationPixelVal = round(bgPixVal - bgPixVal*0.2);
fixationTarget = fixationPixelVal.*ones(fixationSize, fixationSize);

%% Save

BlockStimuli = struct('stimuli', stimuli, 'bTargetPresent', bTargetPresent, 'stimPosPix', stimPosPix, ...
    'fixPosPix', fixPosPix,'bgPixVal', bgPixVal, 'targetSamples', targetSamples, ...
    'responseIntervalS', responseIntervalS, 'fixationIntervalS', fixationIntervalS, ...
    'stimulusIntervalS', stimulusIntervalS, 'blankIntervalS', blankIntervalS, ...
    'fixationTarget', fixationTarget, 'nTrials', nTrials, 'nLevels', nLevels, ...
    'pixelsPerDeg', pixelsPerDeg, 'bFovea', bFovea);





