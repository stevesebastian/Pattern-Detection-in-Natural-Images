function SubjectExpFile = subjectExperimentFile(ExpSettings, nBins)
%SUBJECTEXPERIMENTFILE Initialize all matrices for subject out in
%experiment
% 
% Example: 
%  ExpSettings = SUBJECTEXPERIMENTFILE(ExpSettings, nBins); 
%
% Output: 
%  SubjectExpFile Structure containing subject output values
%
% See also:
%   SETUPEXPERIMENT, SESSIONSETTINGS
%
% v1.0, 2/18/2016, Steve Sebastian <sebastian@utexas.edu>

%% 
binIndex    = ExpSettings.binIndex;
nTrials     = ExpSettings.nTrials;
nLevels     = ExpSettings.nLevels;
nSessions   = ExpSettings.nSessions;

%% Experimental values
SubjectExpFile.binIndex = binIndex;
SubjectExpFile.levelCompleted = zeros(nSessions, nBins);
SubjectExpFile.targetAmplitude = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.stimPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.fixPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.stimuliIndex = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.pixelsPerDeg = ExpSettings.pixelsPerDeg;
SubjectExpFile.bgPixVal = ExpSettings.bgPixVal;

%% Performance values
SubjectExpFile.bTargetPresent = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.response = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.hit = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.miss = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.falseAlarm = zeros(nTrials, nLevels, nSessions, nBins);
SubjectExpFile.correctRejection = zeros(nTrials, nLevels, nSessions, nBins);
