function ExpSettings = loadExperimentSettings(ImgStats, expTypeStr, binIndex, cLvls)


%% 
if(strcmp(expTypeStr, 'fovea'))
    
    monitorMaxPix = 255;    
    monitorSizePix = [1000 1000]; 

    
    filePathImages = ImgStats.Settings.filePathImages;
    targetTypeStr = 'gabor';
	nLevels = 5;
	nTrials = 30;
	nBlocks = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 120;
  
    targetAmplitude = repmat(cLvls, [nTrials, 1, nBlocks]);
	
    targetPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
	fixPosDeg = zeros(nTrials, nLevels, nBlocks, 2);

    targetPosPix = nm.lib.monitorDegreesToPixels(targetPosDeg, monitorSizePix, pixelsPerDeg);
    fixPosPix = nm.lib.monitorDegreesToPixels(targetPosDeg, monitorSizePix, pixelsPerDeg);
    
	targetFunction = @nm.lib.gabor2D;
	loadStimuliFunction = @nm.experiment.additiveTarget;

	bTargetPresent  = nm.experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

	[stimuli, stimuliIndex] = nm.experiment.samplePatchesForExperiment(ImgStats, targetTypeStr, binIndex, nLevels, nTrials, nBlocks);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix;

    ExpSettings = cell('monitorMaxPix', monitorMaxPix, 'monitorSizePix', monitorSizePix, ...
        'filePathImages', filePathImages, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'targetPosDeg', targetPosDeg, ...
        'fixPosDeg', fixPosDeg, 'targetPosPix', targetPosPix, 'fixPosPix', fixPosPix, ...
        'targetFunction', targetFunction, 'loadStimuliFunction', loadStimuliFunction, ...
        'bTargetPresent', bTargetPresent, 'targeAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal);
    
end

