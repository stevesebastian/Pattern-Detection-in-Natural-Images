function BlockStimuli = loadStimuliAdditive(ExpSettings, blockNumber)

stimuli = ExpSettings.stimuli(:,:,:,:,blockNumber);
target = ExpSettings.target;
targetAmplitude = ExpSettings.targetAmplitude(:,:,blockNumber);
bTargetPresent = ExpSettings.bTargetPresent(:,:,blockNumber);
stimPosPix = ExpSettings.stimPosPix(:,:,:,blockNumber);
fixPosPix = ExpSettings.fixPosPix(:,:,:,blockNumber);

bgPixVal = ExpSettings.bgPixVal; 

bAdditive = 1;
bitDepth = 8;

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
        thisStimulus = round((thisStimulus./(2^14-1))*(2^8-1));
        
        if(bTargetPresent(iTrials, iLevels))
            thisTarget = target.*targetAmplitude(iTrials,iLevels)*255;
            thisStimulus = ...
                nm.lib.embedImageinCenter(thisStimulus, thisTarget, bAdditive, bitDepth);
        end

        % Apply the mask
        thisStimulus(~circMask) = bgPixVal;
        stimuli(:,:,iTrials,iLevels) = thisStimulus;
    end
end

BlockStimuli = struct('stimuli', stimuli, 'bTargetPresent', bTargetPresent, ...
    'stimPosPix', stimPosPix, 'fixPosPix', fixPosPix,'bgPixVal', bgPixVal);