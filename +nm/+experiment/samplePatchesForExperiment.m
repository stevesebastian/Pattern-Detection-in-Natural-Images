function pIndex = samplePatchesForExperiment(ImgStats, binIndex, targetTypeStr, filePathIn, filePathOut)
%SAMPLEPATCHESFOREXPERIMENT Sample and save image frames for use in the detection experiment
% 
% Example: 
%   pIndex = SAMPLEPATCHESFOREXPERIMENT(IgStats, [5 5 5], 'gabor', fpIn, fpOut); 
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

%% Set up

numRuns = 2;
numLvls = 5;
numTrialsPerLvl = 30;

numPatches = numRuns*numLvls*numTrialsPerLvl;

if(sum(binIndex > 10 | binIndex < 1))
    error('binIndex out of range. Use 1-10');
end

if(strcmp(targetTypeStr, 'G'))
    pIndexAll = ImgStats.patchIndexG{binIndex(1), binIndex(2), binIndex(3)};
elseif(strcmp(targetTypeStr, 'D'))
    pIndexAll = ImgStats.patchIndexD{binIndex(1), binIndex(2), binIndex(3)};
else
    error(['Target type: ' targetTypeStr ' not supported. Use ''G'' or ''D''. ']);
end

%% Sample patches uniformly across all bins, 
% keep image order, but randomize the coordinates

pIndexAll = pIndexAll(randperm(length(pIndexAll)));

[~, iIndexRand] = ind2sub([59332 1491], pIndexAll);

[~, sortedIndex] = sort(iIndexRand);

pIndexAll = pIndexAll(sortedIndex);

pIndex = pIndexAll(round(linspace(1, length(pIndexAll), numPatches)));

pIndex = pIndex(randperm(length(pIndex)));

pIndex = reshape(pIndex, [numLvls, numTrialsPerLvl numRuns]);

%% Load, crop and save images

for rItr = numRuns
    
    frames = zeros(513, 513, numLvls, numTrialsPerLvl);
    
    for lItr = 1:numLvls        
        for tItr = 1:numTrialsPerLvl

            frames(:,:, lItr, tItr, rItr) = nm.getPatchFromStatStruct(ImgStats, pIndex(lItr, tItr, rItr), filePathIn, 0, 0);

        end
    end
end

save([filePathOut '/' targetTypeStr '_' num2str(binIndex(1)) num2str(binIndex(2)) num2str(binIndex(3)) '.mat'], 'frames', 'pIndex');
