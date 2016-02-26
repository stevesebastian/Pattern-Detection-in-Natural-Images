function setUpExperiment(ImgStats, expTypeStr)
%SETUPEXPERIMENT Creates and saves all experimental stimuli and settings
% 
% Example: 
%  SETUPEXPERIMENT(ImgStats, 'fovea'); 
%
% Output: 
%  None
%
% See also:
%   SESSIONSETTINGS
%
% v1.0, 2/18/2016, Steve Sebastian <sebastian@utexas.edu>

%% FOVEA 
if(strcmp(expTypeStr, 'fovea'))
    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    % Contrast range for each level
    targetLvls = repmat(linspace(0.2, 0.05, 5), [size(binIndex,1) , 1]);    

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
 
    %% Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];

    nSubjects = size(subjectStr, 1);
    
    ExpSettings.targetTypeStr = {'gabor', 'dog'};
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            
            fpOut = [fpSubjects '/' expTypeStr '/' ExpSettings.targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
%% FOVEA PILOT
elseif(strcmp(expTypeStr, 'fovea_pilot'))
    % Experimental bins
    binIndex = [5 1 5; 5 5 5; 5 10 5; 5 5 1; 5 5 10];
 
    nLevels = 5;
    
    % Contrast range for each level
    lumVal = ImgStats.Settings.binCenters.L(5)/100;
    
    targetLvls(1,:) = linspace(0.06, 0.01, nLevels)*lumVal;
    targetLvls(2,:) = linspace(0.15, 0.01, nLevels)*lumVal;
    targetLvls(3,:) = linspace(0.25, 0.05, nLevels)*lumVal;
    targetLvls(4,:) = linspace(0.13, 0.003, nLevels)*lumVal;
    targetLvls(5,:) = linspace(0.2 , 0.01, nLevels)*lumVal;

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
 
    %% Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];  
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
%% PERIPHERY
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
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];  
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
    
    ftemp = fopen('experiment_files/README.txt', 'w');  % Date stamp file generation.
    fprintf(ftemp, 'Date Created: %s', date);
    fclose(ftemp);    
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
    nTargets = size(ImgStats.Settings.targets, 3);
    
    ImgStats.Settings.imgFilePathExperiment = '/data/masking/natural_images/pixel_space/';    
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['rcw'];  
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
    
    ftemp = fopen('experiment_files/README.txt', 'w');  % Date stamp file generation.
    fprintf(ftemp, 'Date Created: %s', date);
    fclose(ftemp);    

%% Phase Noise
elseif(strcmp(expTypeStr, 'phase-noise'))    
    % Experimental bins
    binIndex    = [1 1 1; 1 2 1; 1 3 1; 1 4 1;1 5 1];  
     
    % Eccentricity range for each level
    eLvls = repmat(linspace(2, 10, 5), [size(binIndex,1) , 1]);    

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    ImgStats.Settings.imgFilePathExperiment = '/data/masking/natural_images/pixel_space/';
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['rcw'];  
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
    
    ftemp = fopen('experiment_files/README.txt', 'w');  % Date stamp file generation.
    fprintf(ftemp, 'Date Created: %s', date);
    fclose(ftemp);    
    
    
end
