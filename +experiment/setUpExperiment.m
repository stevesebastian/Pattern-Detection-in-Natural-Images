function setUpExperiment(ImgStats, expTypeStr)

%% 
if(strcmp(expTypeStr, 'fovea'))
    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    
    % Contrast range for each level
    targetLvls = repmat(linspace(0.05, 0.2, 5), [size(binIndex,1) , 1]);    

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), targetLvls(iBin,:));
            
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    % Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];
    
    nSubjects = size(subjectStr, 1);
    nTrials = ExpSettings.nTrials;
    nLevels = ExpSettings.nLevels;
    nSessions = ExpSettings.nBlocks;
    
    ExpSettings.targetTypeStr = {'gabor', 'dog'};
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile.binIndex = binIndex;
            SubjectExpFile.bCompleted = zeros(nBins, 2);
            SubjectExpFile.targetAmplitude = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.stimPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.fixPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.bTargetPresent = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.response     = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.stimuliIndex = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.pixelsPerDeg = ExpSettings.pixelsPerDeg;
            SubjectExpFile.bgPixVal = ExpSettings.bgPixVal;
            
            fpOut = [fpSubjects '/' expTypeStr '/' ExpSettings.targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
elseif(strcmp(expTypeStr, 'fovea_pilot'))
    % Experimental bins
    binIndex = [5 1 5; 5 5 5; 5 10 5; 5 5 1; 5 5 10];
 
    nLevels = 4;
    
    % Contrast range for each level
    lumVal = ImgStats.Settings.binCenters.L(5)/100;
    
    targetLvls(1,:) = linspace(0.05, 0.005, nLevels)*lumVal;
    targetLvls(2,:) = linspace(0.2, 0.01, nLevels)*lumVal;
    targetLvls(3,:) = linspace(0.2, 0.08, nLevels)*lumVal;
    targetLvls(4,:) = linspace(0.1, 0.01, nLevels)*lumVal;
    targetLvls(5,:) = linspace(0.1, 0.01, nLevels)*lumVal;

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), targetLvls(iBin,:));
            
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    % Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];
    
    nSubjects = size(subjectStr, 1);
    nTrials = ExpSettings.nTrials;
    nLevels = ExpSettings.nLevels;
    nSessions = ExpSettings.nBlocks;
    
    ExpSettings.targetTypeStr = {'gabor', 'dog'};
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile.binIndex = binIndex;
            SubjectExpFile.levelCompleted = zeros(nSessions, nBins);
            SubjectExpFile.targetAmplitude = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.stimPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.fixPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.bTargetPresent = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.response = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.hit = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.miss = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.falseAlarm = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.correctRejection = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.stimuliIndex = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.pixelsPerDeg = ExpSettings.pixelsPerDeg;
            SubjectExpFile.bgPixVal = ExpSettings.bgPixVal;
            
            fpOut = [fpSubjects '/' expTypeStr '/' ExpSettings.targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
elseif(strcmp(expTypeStr, 'periphery'))    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    
    % Eccentricity range for each level
    eLvls = repmat(linspace(2, 10, 5), [size(binIndex,1) , 1]);    

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets           
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            
            mkdir([fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr])            
            
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    % Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];
    
    nSubjects = size(subjectStr, 1);
    nTrials   = ExpSettings.nTrials;
    nLevels   = ExpSettings.nLevels;
    nSessions = ExpSettings.nBlocks;
    
    ExpSettings.targetTypeStr = ImgStats.Settings.targetKey;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile.binIndex = binIndex;
            SubjectExpFile.levelCompleted = zeros(nSessions, nBins);
            SubjectExpFile.stimPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.fixPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.bTargetPresent = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.response = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.hit = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.miss = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.falseAlarm = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.correctRejection = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.stimuliIndex = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.pixelsPerDeg = ExpSettings.pixelsPerDeg;
            SubjectExpFile.bgPixVal = ExpSettings.bgPixVal;
            
            fpOut = [fpSubjects '/' expTypeStr '/' ExpSettings.targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
elseif(strcmp(expTypeStr, 'periphery-pilot'))    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    
    % Eccentricity range for each level
    eLvls = repmat(linspace(2, 10, 5), [size(binIndex,1) , 1]);    

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = 1;
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets           
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            
            mkdir([fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr])            
            
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    % Subject experiment files
    subjectStr = ['rcw'];
    
    nSubjects = size(subjectStr, 1);
    nTrials   = ExpSettings.nTrials;
    nLevels   = ExpSettings.nLevels;
    nSessions = ExpSettings.nBlocks;
    
    ExpSettings.targetTypeStr = {'horizontal', 'vertical','bowtie','spot'};
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile.binIndex = binIndex;
            SubjectExpFile.bCompleted = zeros(nBins, 2);
            SubjectExpFile.targetAmplitude = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.levelCompleted = zeros(nSessions, nBins);
            SubjectExpFile.targetPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.fixPosDeg = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.bTargetPresent = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.response     = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.stimuliIndex = zeros(nTrials, nLevels, nSessions, nBins);
            SubjectExpFile.pixelsPerDeg = ExpSettings.pixelsPerDeg;
            SubjectExpFile.bgPixVal = ExpSettings.bgPixVal;
            
            mkdir([fpSubjects '/' expTypeStr '/' ExpSettings.targetTypeStr{iTarget}, '/']);
            
            fpOut = [fpSubjects '/' expTypeStr '/' ExpSettings.targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
end
end
