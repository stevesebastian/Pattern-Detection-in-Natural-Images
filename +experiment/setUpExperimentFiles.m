function setUpExperiment(ImgStats, expTypeStr)

%% 

if(strcmp(expTypeStr, 'fovea'))
    
    monitorMaxPix = 255;    
    
    filePathImages = ImgStats.Settings.filePathImages;
    targetTypeStr = 'gabor';
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(cLvls);
	nTrials = 30;
	nBlocks = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 120;
  
    targetAmplitude = repmat(cLvls, [nTrials, 1, nBlocks]);
	
    stimPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
	fixPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
    
	loadStimuliFunction = @experiment.loadStimuliAdditive;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
            
    for iBin = 1:size(binIndex, 1)
        SessionSettings = experiment.generateSessionSettings(ImgStats, 
        [stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, targetTypeStr, binIndex(iBin,:), nTrials, nLevels, nBlocks);
    end
    
    bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;

    ExpSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'filePathImages', filePathImages, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadStimuliFunction', loadStimuliFunction, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal);
    
end