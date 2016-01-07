function ImgStats = binImageStats(ImgStats)
%BINIMAGESTATS Bin image statistics and add to structure
%
% Example: 
%   ImgStats = BINIMAGESTATS(ImgStats)
%   
%   See also COMPUTEIMAGESTATS.
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

patchIndexG = cell(10,10,10);
patchIndexD = cell(10,10,10);

parfor iLum = 1:10    
    for iCon = 1:10
        for iSim = 1:10
            for iTar = 1:10
                patchIndexG{iLum,iCon,iSim} = ...
                 find(ImgStats.L(:) > binEdges.L(iLum) & ImgStats.L(:) <= binEdges.L(iLum+1) ...
                    & ImgStats.C(:) > binEdges.C(iCon) & ImgStats.C(:) <= binEdges.C(iCon+1) ...
                    & ImgStats.Sa(:) > binEdges.Sa(iSim,iTar) & ImgStats.Sa(:) <= binEdges.Sa(iSim+1,iTar));

            end
        end
    end
end

ImgStats.patchIndexG = patchIndexG;
ImgStats.patchIndexD = patchIndexD;
    