function ExpSettings = loadExperimentSettings(expTypeStr)


%% 

if(strcmp(expTypeStr, 'fovea'))
	ExpSettings.nLevels = 5;
	ExpSettings.nTrials = 30;
	ExpSettings.nBlocks = 2;

	ExpSettings.pixelsPerDeg = 120;
	ExpSettings.targetPosDeg = zeros(ExpSettings.nLevels, ExpSettings.nTrials, ExpSettings.nBlocks, 2);
	ExpSettings.fixPosDeg = zeros(ExpSettings.nLevels, ExpSettings.nTrials, ExpSettings.nBlocks, 2);

	ExpSettings.targetFunction = @nm.lib.gabor2D;

	ExpSettings.loadStimuliFunction = @nm.experiment.additiveTarget;

	% These values will be set later
	ExpSettings.bTargetPresent  = [];
	ExpSettings.targetAmplitude = [];
	ExpSettings.stimuli = [];
	ExpSettings.bgPixVal = [];
end

