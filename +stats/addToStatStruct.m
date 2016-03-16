function Sarray = addToStatStruct(ImgStats, statFunction)
%ADDTOSTATSTRUCT Computes statistics for each image in filepath
%
% Example: 
%
%   Sarray = ADDTOSTATSTRUCT(ImgStats, @statFunction);
%   ImgStats.NameOfStatistic = Sarray;
%
%   See also BINIMAGESTATS, COMPUTESCENESTATS.
%
% v1.0, 3/14/2016, Steve Sebastian <sebastian@utexas.edu>

%% Variable set up.
surroundSizePix = ImgStats.Settings.surroundSizePix;
spacingPix      = ImgStats.Settings.spacingPix;
imgSizePix      = ImgStats.Settings.imgSizePix;

filePathStr = ImgStats.Settings.imgFilePath;

targets = ImgStats.Settings.targets;
envelope = ImgStats.Settings.envelope;

pixelMax = ImgStats.Settings.pixelMax;

sampleCoords    = lib.samplePatchCoordinates(imgSizePix, [surroundSizePix surroundSizePix], spacingPix);

D = dir([filePathStr '/*.mat']);

nSamples = size(sampleCoords,1);
nImages = size(D,1);

%% Compute statistics.

Sarray  = zeros(nSamples, nImages);

parfor iImg = 1:nImages
    disp(['Image: ' num2str(iImg) '/' num2str(nImages)]);
    
    % Load the image.
    I = load([filePathStr '/' D(iImg).name]);
    
    scene = I.I_PPM;
    
    StatsOut = statFunction(scene, targets, ...
        envelope, sampleCoords, pixelMax);
    
    % Save output
    Sarray(:,iImg)        = StatsOut;

end


