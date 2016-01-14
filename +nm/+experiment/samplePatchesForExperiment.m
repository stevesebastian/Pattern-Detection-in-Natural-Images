function pIndex = samplePatchesForExperiment(ImgStats, targetKeyStr, binIndex, nLevels, nRuns, nTrials)
%SAMPLEPATCHESFOREXPERIMENT Sample patches for use in the detection experiment
% 
% Example: 
%   pIndex = SAMPLEPATCHESFOREXPERIMENT(IgStats, [5 5 5], 'gabor', fpIn, fpOut); 
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

%% Set up

if(sum(binIndex > 10 | binIndex < 1))
    error('binIndex out of range. Use 1-10');
end

numPatches = numRuns*numLvls*numTrials;
patchIndexBin = patchIndex{binIndex(1), binIndex(2), binIndex(3)};

%% Sample patches uniformly across all bins, 
% keep image order, but randomize the coordinates


patchIndexBin = patchIndexBin(randperm(length(patchIndexBin)));

nCoords = size(ImgStats.L,1);
nImages = size(ImgStats.L,2)
[~, iIndexRand] = ind2sub([nCoords nImages], patchIndexBin);

[~, sortedIndex] = sort(iIndexRand);

patchIndexBin = patchIndexBin(sortedIndex);

pIndex = patchIndexBin(round(linspace(1, length(patchIndexBin), numPatches)));

pIndex = pIndex(randperm(length(pIndex)));

pIndex = reshape(pIndex, [numLvls, numTrialsPerLvl numRuns]);

%% Load, crop and save images
stimuli = zeroes(ImgStats.surroundSizePix, ImgStats.surroundSizePix, nTrials, nLevels, nRuns);

for iTrials = 1:nTrials
    for iLevels = 1:nLevels
        for iRuns = 1:nRuns
            frames(:,:, iTrials, iLevels, iRuns) = ...
                nm.lib.getPatchFromStatStruct(ImgStats, pIndex(iTrials, iLevels, iRuns), filePathIn, 0, 0);
        end
    end
end

