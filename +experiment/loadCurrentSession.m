function [SettingsOut, sessionNumber] = loadCurrentSession(subjectStr, expTypeStr, targetTypeStr)
%LOADCURRENSESSIONS Load the stimuli and experiment info for the next
%session. Called only during experiment.
%
% v1.0, 1/26/2016, Steve Sebastian <sebastian@utexas.edu>

%% Determine current session

filePathSubject = ['experiment_files/subject_out/' expTypeStr '/' targetTypeStr '/' subjectStr '.mat'];
load(filePathSubject);

% Check for experiment files that have not been started
[notCompletedBin, notCompletedSession] = find(SubjectExpFile.bCompleted == 0);

% Check for experiment files that have been started but not completed
if(isempty(notCompletedBin) && isempty(notCompletedSession))
    [notCompletedBin, notCompletedSession] = find(SubjectExpFile.bCompleted == 2);
end

if(isempty(notCompletedBin) && isempty(notCompletedSession))
    error('Error: All bins and sessions have been completed');
end

binIndex = SubjectExpFile.binIndex(notCompletedBin(1), :);
sessionNumber = notCompletedSession(1);

disp(['Loading bin: L' num2str(binIndex(1)) ' C' num2str(binIndex(2)) ' S' num2str(binIndex(3))]);

%% Load settings

filePathSession = ['experiment_files/experiment_settings/' expTypeStr '/' targetTypeStr '/' ...
    'L' num2str(binIndex(1)) '_C' num2str(binIndex(2)) '_S' num2str(binIndex(3)) '.mat'];
load(filePathSession);

save(filePathSubject, 'SubjectExpFile');

SettingsOut = ExpSettings;
SettingsOut.currentBin = notCompletedBin(1);
SettingsOut.currentSession = notCompletedSession(1);
