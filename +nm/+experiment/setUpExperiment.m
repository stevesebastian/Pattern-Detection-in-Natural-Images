function setUpExperiment(ImgStats, expTypeStr)

%% 

if(strcmp(expTypeStr, 'fovea'))
    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    % Contrast range for each level
    cLvls = repmat(linspace(0.05, 0.25, 5), [size(binIndex,1) , 1]);
    
    % Session files
    for iBin = 1:size(binIndex, 1)
        SessionSettings = nm.experiment.sessionSettings(ImgStats, expTypeStr, binIndex(iBin,:), cLvls(iBin,:)); 
        fpOut = [fpSettings '/' expTypeStr '_L' num2str(binIndex(iBin,1)) ...
            '_C' num2str(binIndex(iBin,2)) '_S' num2str(binIndex(iBin,3)) '.mat'];
        save(fpOut, SessionSettings);
    end
    
    % Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];
   
    for iSubject = 1:size(subjectStr,1)
        SubjectExpFile.binIndex = binIndex;
        SubjectExpFile.bCompleted = zeroes(size(binIndex,1), 2);
        fpOut = [fpSubject '/' expTypeStr '_' subjectStr(:,iSubject) '.mat'];
        save(fpOut, SubjectExpFile);
    end
end