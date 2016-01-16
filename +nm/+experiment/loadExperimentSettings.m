function ExpSettings = loadExperimentSettings(ImgStats, expTypeStr, binIndex, cLvls)


%% 

if(strcmp(expTypeStr, 'fovea'))
    
    monitorMaxPix = 255;
    
    filePathImages = ImgStats.Settings.filePathImages;
    targetTypeStr = 'gabor';
	nLevels = 5;
	nTrials = 30;
	nBlocks = 2;

	pTarget = 0.5;

	pixelsPerDeg = 120;
	targetPosDeg = zeros(nLevels, nTrials, nBlocks, 2);
	fixPosDeg = zeros(nLevels, nTrials, nBlocks, 2);

	targetFunction = @nm.lib.gabor2D;
	loadStimuliFunction = @nm.experiment.additiveTarget;

	bTargetPresent  = nm.experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);
	targetAmplitude = repmat(cLvls, [nTrials, 1, nBlocks]);
	[stimuli, stimuliIndex] = ...
        nm.experiment.samplePatchesForExperiment(ImgStats, tergetTypeStr, [5 5 5], filePathImages);
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix;

end

