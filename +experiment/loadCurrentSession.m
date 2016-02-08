function SettingsOut = loadCurrentSession(subjectStr, expTypeStr, targetTypeStr, binIndex, sessionNumber, levelNumber)
%LOADCURRENSESSIONS Load the stimuli and experiment info for the next
%session. Called only during experiment.
%
% v1.0, 1/26/2016, Steve Sebastian <sebastian@utexas.edu>

%% Determine current session

filePathSubject = ['experiment_files/subject_out/' expTypeStr '/' targetTypeStr '/' subjectStr '.mat'];
load(filePathSubject);

if(nargin < 4)
    nLevels = size(SubjectExpFile.targetAmplitude,2);

    % Check for experiment files that have not been completed
    [notCompletedBin, notCompletedSession] = ...
        find(SubjectExpFile.levelCompleted < nLevels);

    if(isempty(notCompletedBin) && isempty(notCompletedSession))
        error('Error: All bins, sessions, and levels have been completed');
    end

    currentBin     = notCompletedBin(1);
    currentSession = notCompletedSession(1);
    binIndex = SubjectExpFile.binIndex(notCompletedBin(1), :);
    
    levelCompleted = SubjectExpFile.levelCompleted(currentBin, currentSession);
    levelStartIndex = levelCompleted + 1;
else
    currentSession = sessionNumber; 
    currentBin = find(ismember(SubjectExpFile.binIndex, binIndex, 'rows') == 1);
    levelStartIndex = levelNumber;
end


disp(['Loading bin: L' num2str(binIndex(1)) ' C' num2str(binIndex(2)) ' S' num2str(binIndex(3))]);
disp(['Session number: ' num2str(currentSession) ' Level number: ' num2str(levelStartIndex)]);

%% Load settings

filePathSession = ['experiment_files/experiment_settings/' expTypeStr '/' targetTypeStr '/' ...
    'L' num2str(binIndex(1)) '_C' num2str(binIndex(2)) '_S' num2str(binIndex(3)) '.mat'];
load(filePathSession);

save(filePathSubject, 'SubjectExpFile');

SettingsOut = ExpSettings;
SettingsOut.subjectStr = subjectStr;
SettingsOut.expTypeStr = expTypeStr;
SettingsOut.targetTypeStr = targetTypeStr;
SettingsOut.levelStartIndex = levelStartIndex;
SettingsOut.currentBin = currentBin;
SettingsOut.currentSession = currentSession;

