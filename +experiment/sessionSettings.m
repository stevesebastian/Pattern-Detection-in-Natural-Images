function SessionSettings = sessionSettings(ImgStats, expTypeStr, targetTypeStr, binIndex, targetLvls, nSubjects)
%SESSIONSETTINGS Loads settings and stimuli for each experimental session 
% 
% Example: 
%  ExpSettings = SESSIONSETTINGS(ImgStats, 'fovea', [5 5 5], linspace(0.05, 0.2, 5)); 
%
% Output: 
%  ExpSettings Structure containing stimuli and experiment settings
%
% See also:
%   LOADSTIMULIADDITIVE
%
% v1.0, 1/22/2016, Steve Sebastian <sebastian@utexas.edu>
% v1.1, 2/4/2016,  R. Calen Walshe <calen.walshe@utexas.edu> Added
% peripheral settings.


%% FOVEA
if(strcmp(expTypeStr, 'fovea'))
    
    stimulusIntervalMs = 200;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(targetLvls);
	nTrials = 30;
	nSessions = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 120;
  
    targetAmplitude = repmat(targetLvls, [nTrials, 1, nSessions]);
	
    stimPosDeg = zeros(nTrials, nLevels, nSessions, 2);
	fixPosDeg = zeros(nTrials, nLevels, nSessions, 2);
    
	loadSessionStimuli = @experiment.loadStimuliAdditive;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nSessions, pTarget);

    sampleMethod = 'random';
    imgSet       = 'N';
    
	[stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, ...
        targetTypeStr, binIndex, nTrials, nLevels, nSessions, sampleMethod, imgSet);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;

    SessionSettings = struct('binIndex', binIndex, 'monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nSessions', nSessions, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs);
%% FOVEA PILOT
elseif(strcmp(expTypeStr, 'fovea_pilot'))
        
    stimulusIntervalMs = 200;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
    nDummyTrials = 1;
    
	nLevels = length(targetLvls);
	nTrials = 20 + nDummyTrials;
	nSessions = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 120;
  
    targetAmplitude = squeeze(repmat(targetLvls, [nTrials, 1, nSessions]));
	
    stimPosDeg = zeros(nTrials, nLevels, nSessions, 2);
	fixPosDeg = zeros(nTrials, nLevels, nSessions, 2);
    
	loadSessionStimuli = @experiment.loadStimuliAdditive;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nSessions, pTarget);

    bTargetPresent(1,:,:) = 1;
    
    sampleMethod = 'random';
    imageType = 'N'; % Use only nature images
    
	[stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, ...
        targetTypeStr, binIndex, nTrials, nLevels, nSessions, sampleMethod, imageType);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;

    SessionSettings = struct('binIndex', binIndex, 'monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nSessions', nSessions, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs, 'nDummyTrials', nDummyTrials);
%% PERIPHERY
elseif(strcmp(expTypeStr, 'periphery'))
    stimulusIntervalMs = 200;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
    nDummyTrials = 1;
    
	nLevels = size(targetLvls,2);
	nTrials = 30 + nDummyTrials;
	nSessions = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 60;

    stimPosDeg = zeros(nTrials, nLevels, nSubjects, nSessions, 2);
    fixPosDeg  = zeros(nTrials, nLevels, nSubjects, nSessions, 2);
    
    
    targetLuminance = 18.30; % Median luminance in image database    
    contrastRMS     = .33; %Median Contrast in image database
    targetContrast  = repmat(ones(1,nLevels)*contrastRMS  , [nTrials, 1, nSessions]); % Contrast
    targetAmplitude = repmat(ones(1,nLevels)*0 , [nTrials, 1, nSessions]); % Amplitude
       
    sampleMethod = 'random';
    imageType = 'N';
 
    stimulusDistanceDeg     = 10;
    stimPosDeg(:,:,:,:,1)     = stimulusDistanceDeg;
	fixPosDeg(:,:,:,:,1)      = stimPosDeg(:,:,:,:,1) - repmat(targetLvls, [nTrials,1,1,nSessions]);


	loadSessionStimuli = @experiment.loadStimuliOccluding;

    bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nSessions, pTarget);
    bTargetPresent(1,:,:) = 1; % Always set the first trial to be a target present trial. A single example trial.

	[stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, ...
        targetTypeStr, binIndex, nTrials, nLevels, nSessions, sampleMethod, imageType); 
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1)) * monitorMaxPix./100;
    
    envelope = ImgStats.Settings.envelope;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nSessions', nSessions, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetContrast', targetContrast, 'targetAmplitude', targetAmplitude,...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs, 'envelope', envelope,...
        'targetLuminance', targetLuminance, 'nDummyTrials', nDummyTrials);    
    
elseif(strcmp(expTypeStr, 'phase-noise'))        
    stimulusIntervalMs = 200;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
    binContrast = [0.03, 0.1, 0.17, 0.31, 0.45];    
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(targetLvls);
	nTrials = 30;
	nSessions = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 60;
        
    stimPosDeg = zeros(nTrials, nLevels, nSessions, 2);
    fixPosDeg  = zeros(nTrials, nLevels, nSessions, 2);
    
    contrastRMS     = .17;
    targetContrast  = repmat(ones(1,nLevels)*contrastRMS  , [nTrials, 1, nSessions]); % Contrast
    targetAmplitude = repmat(ones(1,nLevels)*0 , [nTrials, 1, nSessions]); % Amplitude    
    
    stimulusDistanceDeg     = 10;
    stimPosDeg(:,:,:,1)     = stimulusDistanceDeg;
	fixPosDeg(:,:,:,1)      = stimPosDeg(:,:,:,1) - repmat(targetLvls, [nTrials,1,nSessions]);
    
	loadSessionStimuli = @experiment.loadStimuliPhaseNoise;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nSessions, pTarget);

    sampleMethod = 'random';
    
	[stimuli, stimuliIndex] = experiment.sampleNoisePatchForExperiment(ImgStats, ...
        targetTypeStr, binIndex, binContrast, nTrials, nLevels, nSessions, sampleMethod);
        
	bgPixVal = 127;
    
    envelope = ImgStats.Settings.envelope;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nSessions', nSessions, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetContrast', targetContrast, 'targetAmplitude', targetAmplitude,...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs, 'envelope', envelope);

elseif(strcmp(expTypeStr, 'uniform'))        
    stimulusIntervalMs = 200;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;   
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(targetLvls);
	nTrials = 30;
	nSessions = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 60;
        
    stimPosDeg = zeros(nTrials, nLevels, nSessions, 2);
    fixPosDeg  = zeros(nTrials, nLevels, nSessions, 2);
    
    contrastRMS     = .17;
    targetContrast  = repmat(ones(1,nLevels)*contrastRMS  , [nTrials, 1, nSessions]); % Contrast
    targetAmplitude = repmat(ones(1,nLevels)*0 , [nTrials, 1, nSessions]); % Amplitude    
    
    stimulusDistanceDeg     = 10;
    stimPosDeg(:,:,:,1)     = stimulusDistanceDeg;
	fixPosDeg(:,:,:,1)      = stimPosDeg(:,:,:,1) - repmat(targetLvls, [nTrials,1,nSessions]);
    
	loadSessionStimuli = @experiment.loadStimuliUniform;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nSessions, pTarget);

    sampleMethod = 'random';
    
	[stimuli, stimuliIndex] = experiment.sampleUniformPatchForExperiment(ImgStats, binIndex, nTrials, nLevels, nSessions); % load a noise patch, but do not present it.
        
	bgPixVal = 0; %ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;
    
    envelope = ImgStats.Settings.envelope;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nSessions', nSessions, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetContrast', targetContrast, 'targetAmplitude', targetAmplitude,...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs, 'envelope', envelope);
end    
    
end
