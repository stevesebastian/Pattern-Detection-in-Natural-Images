function SessionSettings = sessionSettings(ImgStats, expTypeStr, targetTypeStr, binIndex, cLvls)
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


%% 
if(strcmp(expTypeStr, 'fovea'))
    
    stimulusIntervalMs = 250;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
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
    
	loadSessionStimuli = @experiment.loadStimuliAdditive;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

    sampleMethod = 'random';
    
	[stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, ...
        targetTypeStr, binIndex, nTrials, nLevels, nBlocks, sampleMethod);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs);
elseif(strcmp(expTypeStr, 'fovea_pilot'))
        
    stimulusIntervalMs = 250;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(cLvls);
	nTrials = 20;
	nBlocks = 1;

	pTarget = 0.5;
  
    pixelsPerDeg = 120;
  
    targetAmplitude = repmat(cLvls, [nTrials, 1, nBlocks]);
	
    stimPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
	fixPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
    
	loadSessionStimuli = @experiment.loadStimuliAdditive;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

    sampleMethod = 'random';
    
	[stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, ...
        targetTypeStr, binIndex, nTrials, nLevels, nBlocks, sampleMethod);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs);
    
elseif(strcmp(expTypeStr, 'periphery'))
    stimulusIntervalMs = 250;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(cLvls);
	nTrials = 30;
	nBlocks = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 60;
  
    targetAmplitude = .17;
	    
    stimPosDeg       = ones(nTrials, nLevels, nBlocks, 2) * 10;
	fixPosDeg        = stimPosDeg - repmat(cLvls, [nTrials,1,nBlocks,2]);
    
	loadSessionStimuli = @experiment.loadStimuliOccluding;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

    sampleMethod = 'random';
    
	[stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, ...
        targetTypeStr, binIndex, nTrials, nLevels, nBlocks, sampleMethod);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1)) * monitorMaxPix./100;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs);
elseif(strcmp(expTypeStr, 'periphery-pilot'))
    stimulusIntervalMs = 250;
    responseInvervalMs = 1000;
    fixationIntervalMs = 400;
    blankIntervalMs    = 100;
    
    monitorMaxPix = 255;    
    
    imgFilePath = ImgStats.Settings.imgFilePath;
    
    targetIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(cLvls);
	nTrials = 100;
	nBlocks = 1;

	pTarget = 0.5;
  
    pixelsPerDeg = 60;
  
    targetAmplitude = .17;
	    
    stimPosDeg       = ones(nTrials, nLevels, nBlocks, 2) * 10;
	fixPosDeg        = stimPosDeg - repmat(cLvls, [nTrials,1,nBlocks,2]);
    
	loadSessionStimuli = @experiment.loadStimuliPilot;

	bTargetPresent  = experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

    sampleMethod = 'random';
    
	[stimuli, stimuliIndex] = experiment.samplePatchesForExperiment(ImgStats, ...
        targetTypeStr, binIndex, nTrials, nLevels, nBlocks, sampleMethod);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1)) * monitorMaxPix./100;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'imgFilePath', imgFilePath, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, 'sampleMethod', sampleMethod, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadSessionStimuli', loadSessionStimuli, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal, ...
        'stimulusIntervalMs', stimulusIntervalMs, 'responseIntervalMs', responseInvervalMs, ...
        'fixationIntervalMs', fixationIntervalMs, 'blankIntervalMs', blankIntervalMs);
end
end

