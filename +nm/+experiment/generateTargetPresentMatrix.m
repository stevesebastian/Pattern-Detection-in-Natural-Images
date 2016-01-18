function bPresent = generateTargetPresentMatrix(nTrials, nLevels, nBlocks, pTarget)
%GENERATETARGETPRESENTMATRIX Returns a matrix of target present values
% 
% Example: 
%	bPresent = nm.stats.GENERATETARGETPRESENTMATRIX(30, 5, 2, 0.5);
%
% Output:
%   bPresent Matrix of target present 1 or absent 0, values
%
% v1.0, 1/14/2016, Steve Sebastian <sebastian@utexas.edu>


%% Check input

if(nargin < 4)
	pTarget = 0.5;
end

%% Create the matrix in the format nTrials x nLevels x nBlocks
bPresent = zeros(nTrials, nLevels, nBlocks);
nTargetPresent = round(nTrials*pTarget);
bPresent(1:nTargetPresent,:,:) = 1;

%% Shuffle each column of the matrix
for iLevels = 1:nLevels
    for iBlocks = 1:nBlocks
        bPresent(:,iLevels,iBlocks) = bPresent(randperm(nTrials),iLevels,iBlocks);
    end
end

