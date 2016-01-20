function ExpSettings = loadExperimentSettings(ImgStats, expTypeStr, binIndex, cLvls)


%% 
if(strcmp(expTypeStr, 'fovea'))
    
    monitorMaxPix = 255;    
    monitorSizePix = [1000 1000]; 

    
    filePathImages = ImgStats.Settings.filePathImages;
    targetTypeStr = 'gabor';
    
    targetIndex = nm.lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
    nm.lib.t
	nLevels = 5;
	nTrials = 30;
	nBlocks = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 120;
  
    targetAmplitude = repmat(cLvls, [nTrials, 1, nBlocks]);
	
    targetPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
	fixPosDeg = zeros(nTrials, nLevels, nBlocks, 2);

    stimPosPix = nm.lib.monitorDegreesToPixels(targetPosDeg, monitorSizePix, pixelsPerDeg);
    fixPosPix = nm.lib.monitorDegreesToPixels(targetPosDeg, monitorSizePix, pixelsPerDeg);
    
	loadStimuliFunction = @nm.experiment.additiveTarget;

	bTargetPresent  = nm.experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

	[stimuli, stimuliIndex] = nm.experiment.samplePatchesForExperiment(ImgStats, targetTypeStr, binIndex, nTrials, nLevels, nBlocks);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;

    ExpSettings = struct('monitorMaxPix', monitorMaxPix, 'monitorSizePix', monitorSizePix, ...
        'filePathImages', filePathImages, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'targetPosDeg', targetPosDeg, ...
        'fixPosDeg', fixPosDeg, 'stimPosPix', stimPosPix, 'fixPosPix', fixPosPix, ...
        'targetFunction', targetFunction, 'loadStimuliFunction', loadStimuliFunction, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal);
    
end

