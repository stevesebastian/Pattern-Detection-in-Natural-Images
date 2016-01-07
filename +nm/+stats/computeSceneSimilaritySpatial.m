function StatsOut = computeSceneSimilaritySpatial(imIn, tarIn, wWin, sampleCoords)
%%COMPUTESCENCESIMILARITYSPATIAL Computes the similarity of the image to a target in the space domain
%
% Example:
%   StatsOut = COMPUTESCENESIMILARITYSPATIAL(imIn, tarIn, wWin, sampleCoords)
%
% Output:
%   StatsOut.S:         similarity
%   StatsOut.Smag:      magnitude of similarity
%   StatsOut.tMatch     spatial template match
%
%   See also BINIMAGESTATS, COMPUTESCENESTATS.
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

%% Variable set up
iWin = wWin > 0;
cosWin = lib.cosWindowFlattop2(size(imIn), 90, 10, 0, 0);

%% Compute Similarity
lumBar  = lib.fftconv2(imIn, wWin);
diffImg = imIn - lumBar;
templateMatch = lib.fftconv2(diffImg, lumBar);

diffImgAve = lib.fftconv2(diffImg, iWin);

tarInNorm = sqrt(sum(tarIn(:).^2));
diffImgNorm = sqrt(sum(diffImgAve(:).^2));


StatsOut.S = templateMatch./(tarInNorm.*diffImgNorm);
StatsOut.Smag = abs(StatsOut.S);

StatsOut.tMatch = lib.fftconv2(imIn, tarIn);

