function SessionSettings = sessionSettings(ImgStats, expTypeStr, binIndex, cLvls)
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


%% 
if(strcmp(expTypeStr, 'fovea'))
    
    monitorMaxPix = 255;    
    
    filePathImages = ImgStats.Settings.filePathImages;
    targetTypeStr = 'gabor';
    
    targetIndex = nm.lib.getTargetIndexFromString(ImgStats.Settings, targetTypeStr);
    target = ImgStats.Settings.targets(:,:,targetIndex);
    
	nLevels = length(cLvls);
	nTrials = 30;
	nBlocks = 2;

	pTarget = 0.5;
  
    pixelsPerDeg = 120;
  
    targetAmplitude = repmat(cLvls, [nTrials, 1, nBlocks]);
	
    stimPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
	fixPosDeg = zeros(nTrials, nLevels, nBlocks, 2);
    
	loadStimuliFunction = @nm.experiment.loadStimuliAdditive;

	bTargetPresent  = nm.experiment.generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget);

	[stimuli, stimuliIndex] = nm.experiment.samplePatchesForExperiment(ImgStats, targetTypeStr, binIndex, nTrials, nLevels, nBlocks);
        
	bgPixVal = ImgStats.Settings.binCenters.L(binIndex(1))*monitorMaxPix./100;

    SessionSettings = struct('monitorMaxPix', monitorMaxPix, ...
        'filePathImages', filePathImages, 'target', target, 'targetTypeStr', targetTypeStr, ...
        'nLevels', nLevels, 'nTrials', nTrials, 'nBlocks', nBlocks, ...
        'pTarget', pTarget, 'pixelsPerDeg', pixelsPerDeg, 'stimPosDeg', stimPosDeg, ...
        'fixPosDeg', fixPosDeg, 'loadStimuliFunction', loadStimuliFunction, ...
        'bTargetPresent', bTargetPresent, 'targetAmplitude', targetAmplitude, ...
        'stimuli', stimuli, 'stimuliIndex', stimuliIndex, 'bgPixVal', bgPixVal);
    
end

