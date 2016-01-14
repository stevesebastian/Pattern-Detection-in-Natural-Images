function ExpSettings = loadExperimentSettings(expTypeStr, binIndex, cLvls)


%% 

if(strcmp(expTypeStr, 'fovea'))
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
	stimuli = [];
	bgPixVal = [];


end

