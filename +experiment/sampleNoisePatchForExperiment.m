function [stimuli, pIndex] = sampleNoisePatchForExperiment(ImgStats, targetKeyStr, binIndex, nTrials, nLevels, nBlocks, sampleMethod)
%SAMPLEPATCHESFOREXPERIMENT Sample patches for use in the detection experiment
% 
% Example: 
%  [stimiuli pIndex] = SAMPLEPATCHESFOREXPERIMENT(ImgStats, 'gabor', [5 5 5], 'uniform'); 
%
% v1.0, 1/5/2016, R. Calen Walshe <calen.walshe@utexas.edu>

%% Set up

if(nargin < 7)
    sampleMethod = 'uniform';
end

if(sum(binIndex > 10 | binIndex < 1))
    error('binIndex out of range. Use 1-10');
end

targetKeyIndex = lib.getTargetIndexFromString(ImgStats.Settings, targetKeyStr);
nPatches = nBlocks*nLevels*nTrials;

switch binIndex(2)
    case 1
        maskContrast = .03;
    case 2
        maskContrast = .1;
    case 3
        maskContrast = .17;
    case 4
        maskContrast = .31;
    case 5
        maskContrast = .45;
    otherwise
        maskContrast = 0;
            
end
        
binIndex(2);

%% Sample patches across all bins, 
% keep image order, but randomize the coordinate order

if(strcmp(sampleMethod, 'uniform'))
    patchIndexBin = patchIndexBin(randperm(length(patchIndexBin)));

    nCoords = size(ImgStats.L,1);
    nImages = size(ImgStats.L,2);

    [~, iIndexRand] = ind2sub([nCoords nImages], patchIndexBin);
    [~, sortedIndex] = sort(iIndexRand);

    patchIndexBin = patchIndexBin(sortedIndex);
    pIndex = patchIndexBin(round(linspace(1, length(patchIndexBin), nPatches)));
    pIndex = pIndex(randperm(length(pIndex)));
else
    pIndex = randsample(patchIndexBin, nPatches);
end

pIndex = reshape(pIndex, [nTrials, nLevels nBlocks]);

%% Load, crop and save images
stimuli = zeros(ImgStats.Settings.surroundSizePix, ImgStats.Settings.surroundSizePix, nTrials, nLevels, nBlocks);

for iTrials = 1:nTrials
    for iLevels = 1:nLevels
        for iBlocks = 1:nBlocks           
                                              
            nPatch = lib.pink_noise_2d(241, 241, 60);
            nPatch = nPatch ./ std(nPatch(:)) .* .17 .* floor((2^16 - 1)/2) + floor((2^16 - 1)/2);
            
            stimuli(:,:, iTrials, iLevels, iBlocks) = ...
                nPatch;
            
        end
    end
end

