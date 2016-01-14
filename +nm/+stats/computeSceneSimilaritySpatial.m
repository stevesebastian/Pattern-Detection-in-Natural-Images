function Sstats = computeSceneSimilaritySpatial(imIn, tarIn, wWin, sampleCoords)
%%COMPUTESCENCESIMILARITYSPATIAL Computes the similarity of the image to a target in the space domain
%
% Example:
%   Sstats = COMPUTESCENESIMILARITYSPATIAL(imIn, tarIn, wWin, sampleCoords)
%
% Output:
%   Sstats.S:         similarity
%   Sstats.Smag:      magnitude of similarity
%   Sstats.tMatch     spatial template match
%
%   See also BINIMAGESTATS, COMPUTESCENESTATS.
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

%% Variable set up
iWin = wWin > 0;

%% Compute Similarity
lumBar  = nm.lib.fftconv2(imIn, wWin);
diffImg = imIn - lumBar;
templateMatch = nm.lib.fftconv2(diffImg, lumBar);

diffImgAve = nm.lib.fftconv2(diffImg, iWin);

tarInNorm = sqrt(sum(tarIn(:).^2));
diffImgNorm = sqrt(sum(diffImgAve(:).^2));

S = templateMatch./(tarInNorm.*diffImgNorm);
Smag = abs(S);

%% output
if(isempty(sampleCoords))
    Sstats.S = S;
    Sstats.Smag = Smag;
else
    inds = sub2ind(size(imIn), sampleCoords(:,1), sampleCoords(:,2));
    Sstats.S = S(inds);
    Sstats.Smag = Smag(inds);
end
