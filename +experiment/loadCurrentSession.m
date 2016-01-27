function [SettingsOut, sessionNumber] = loadCurrentSession(subjectStr, expTypeStr, targetTypeStr)
%LOADCURRENSESSIONS Load the stimuli and experiment info for the next
%session. Called only during experiment.
%
% v1.0, 1/26/2016, Steve Sebastian <sebastian@utexas.edu>

%% Determine current session

filePathSubject = ['../subject_out/' expTypeStr '/' targetTypeStr '/' subjectStr '.mat'];
load(filePathSubject);

[notCompletedBin, notCompletedSession] = find(~SubjectExpFile.bCompleted);

binIndex = SubjectExpFile.binIndex(notCompletedBin(1), :);
sessionNumber = notCompletedSession(1);

%% Load settings

filePathSession = ['../experiment_settings/' expTypeStr '/' targetTypeStr '/' ...
    'L' binIndex(1) '_C' binIndex(2) '_S' binIndex(3) '.mat'];
load(filePathSession);

SettingsOut = BlockSettings;
