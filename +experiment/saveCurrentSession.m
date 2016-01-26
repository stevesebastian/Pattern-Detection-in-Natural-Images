function saveCurrentSession(subjectStr, expTypeStr, targetTypeStr, SessionSettings, response)
%LOADCURRENSESSIONS Saves the stimuli and experiment info for the next
%session. Called only during experiment.
%
% v1.0, 1/26/2016, Steve Sebastian <sebastian@utexas.edu>

%% Determine current session and update to completed

filePathSubject = ['../subject_out/' expTypeStr '/' targetTypeStr '/' subjectStr '.mat'];
load(filePathSubject);

[notCompletedBin, notCompletedSession] = find(~SubjectExpFile.bCompleted);

binNumber     = notCompletedBin(1);
sessionNumber = notCompletedSession(1);

SubjectExpFile.bCompleted(binNumber, sessionNumber) = 1;

SubectExpFile.targetAmplitude(:,:,sessionNumber, binNumber) = ...
    SessionSettings.targetAmplitude(:,:,sessionNumber);
SubectExpFile.targetPosDeg(:,:,sessionNumber, binNumber) = ...
    SessionSettings.targetPosDeg(:,:,sessionNumber);
SubectExpFile.fixPosDeg(:,:,sessionNumber, binNumber) = ...
    SessionSettings.fixPosDeg(:,:,sessionNumber);
SubectExpFile.bTargetPresent(:,:,sessionNumber, binNumber) = ...
    SessionSettings.bTargetPresent(:,:,sessionNumber);
SubectExpFile.response(:,:,sessionNumber, binNumber) = response;
SubectExpFile.stimuliIndex(:,:,sessionNumber, binNumber) = ...
    SessionSettings.stimuliIndex(:,:,sessionNumber);

filePathSubject = ['../subject_out/' expTypeStr '/' targetTypeStr '/' subjectStr '.mat'];

save(filePathSubect, SubjectExpFile);