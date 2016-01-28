function setUpExperiment(ImgStats, expTypeStr)

%% 

if(strcmp(expTypeStr, 'fovea'))
    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    
    % Contrast range for each level
    cLvls = repmat(linspace(0.05, 0.2, 5), [size(binIndex,1) , 1]);    

    fpSettings = '../experiment_settings';
    fpSubjects = '../subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            BinExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), cLvls(iBin,:));
            
            fpOut = [fpSettings '/' expTypeStr '/' BinExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'BinExpSettings');
        end
    end
 
    % Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];
    
    nSubjects = size(subjectStr, 1);
    nTrials = BinExpSettings.nTrials;
    nLevels = BinExpSettings.nLevels;
    nSessions = BinExpSettings.nBlocks;
    
    BinExpSettings.targetTypeStr = {'gabor', 'dog'};
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile.binIndex = binIndex;
            SubjectExpFile.bCompleted = zeros(nBins, 2);
            SubjectExpFile.targetAmplitude = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.targetPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.fixPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.bTargetPresent = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.response     = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.stimuliIndex = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.pixPerDeg = BinExpSettings.pixPerDeg;
            SubjectExpFile.bgPixVal = BinExpSettings.bgPixVal;
            
            fpOut = [fpSubjects '/' expTypeStr '/' BinExpSettings.targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
end