function ImgStats = binImageStats(ImgStats)
%BINIMAGESTATS Bin image statistics and add to structure
%
% Example: 
%   ImgStats = BINIMAGESTATS(ImgStats)
%   
%   See also COMPUTEIMAGESTATS.
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

nBins = size(ImgStats.Settings.binEdges,2) - 1;
nTargets = size(ImgStats.Settings.targets,3);

patchIndex = cell(nTargets,1);

for iTar = 1:nTargets
    patchIndex{iTar} = cell(nBins,nBins,nBins);
    for iLum = 1:nBins    
        for iCon = 1:nBins
            for iSim = 1:nBins
                patchIndexG{iLum,iCon,iSim} = ...
                 find(ImgStats.L(:) > ImgStats.Settings.binEdges.L(iLum) & ImgStats.L(:) <= ImgStats.Settings.binEdges.L(iLum+1) ...
                    & ImgStats.C(:) > ImgStats.Settings.binEdges.C(iCon) & ImgStats.C(:) <= ImgStats.Settings.binEdges.C(iCon+1) ...
                    & ImgStats.Sa(:) > ImgStats.Settings.binEdges.Sa(iSim,iTar) & ImgStats.Sa(:) <= ImgStats.Settings.binEdges.Sa(iSim+1,iTar));

            end
        end
    end
end

ImgStats.patchIndex = patchIndex;
    