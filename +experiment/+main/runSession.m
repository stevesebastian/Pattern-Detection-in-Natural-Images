function SessionData = runSession(SessionSettings)
%RUNEXPERIMENTBLOCK Runs a single block of an experiment.
% Description: 
%   A session consists of N levels. Each level contains M trials. The
%   experiment protocol is agnostic to what visual content define the
%   sessions and levels. stimulusArray defines what is present and is setup prior to
%   the experiment (see +stats).
%
% Example: 
%   [response, responseOnsetMs] = SINGLETRIALDETECTION(ExperimentStruct, stimulus, block, trial);
%   
%   See also SINGLETRIALDETECTION
%
% v2.0, 1/27/2016, Steve Sebastian, R. C. Walshe <calen.walshe@utexas.edu>

nTrials     = SessionSettings.nTrials;
nLevels     = SessionSettings.nLevels;

levelStartIndex = SessionSettings.levelStartIndex;

responseMatrix = zeros(nTrials, nLevels);
rtMatrix = zeros(nTrials, nLevels);

for iLevel = levelStartIndex:nLevels

      experiment.main.displayLevelStart(SessionSettings, iLevel);  
    
    for iTrial = 1:nTrials

        [response, RT] = experiment.main.runTrial(SessionSettings, iTrial, iLevel);

        responseMatrix(iTrial, iLevel) = response;
        rtMatrix(iLevel, iLevel) = RT;

    end
    
    experiment.saveCurrentLevel(SessionSettings, responseMatrix(:,iLevel), iLevel);
    
    Screen('FillRect', SessionSettings.window, SessionSettings.bgPixValGamma)
    Screen('TextSize', SessionSettings.window, 25);
    DrawFormattedText(SessionSettings.window, 'End of the block', 'center', 'center');
    Screen('Flip', SessionSettings.window);
  
end

SessionData.response = responseMatrix;
SessionData.rt = rtMatrix;