function ImgStats = buildStatStructure(filePathStr, Settings)
%BUILDSTATSTRUCTURE Computes statistics for each image in filepath
%
% Example: 
%   Settings = stats.EXPERIMENTSETTINGS('fovea');
%   ImgStats = BUILDSTATSTRUCTURE('./images', Settings);
%   
%   See also BINIMAGESTATS, COMPUTESCENESTATS.
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

%% Variable set up.
envelope = Settings.envelope;

surroundSizePix = Settings.surroundSizePix;
targetSizePix   = Settings.targetSizePix;
spacingPix      = Settings.spacingPix;
imgSizePix      = Settings.imgSizePix;

pixelMax = Settings.pixelMax;

sampleCoords    = lib.samplePatchCoordinates(imgSizePix, [surroundSizePix surroundSizePix], spacingPix);

nSamples = size(sampleCoords,1);
nTargets = length(Settings.targetKey);

D = dir([filePathStr '/*.mat']);

%% Compute statistics.
nImages = size(D,1);
L       = zeros(nSamples, nImages);
C       = zeros(nSamples, nImages);
Sa      = zeros(nSamples, nImages, nTargets);
Ss      = zeros(nSamples, nImages, nTargets);

tMatch = zeros(nSamples, nImages, nTargets);
pClipped     = zeros(nSamples, nImages);

for iImg = 1:nImages;

    disp('Image: ' num2str(iImg) '/' num2str(nImages)]);
    
    % Load the image.
    I = load([filePathStr '/' D(iImg).name]);
    
    scene = I.I_PPM;
    
    StatsOut = stats.computeSceneStats(scene, targets, envelope, sampleCoords, pixelMax);
    
    % Save output
    L(:,iImg)        = StatsOut.L;
    C(:,iImg)        = StatsOut.C;
    pClipped(:,iImg) = StatsOut.pClipped;

    for iTarget = 1:size(A,2)
        Sa(:,iImg,iTarget)     = StatsOut.Sa(iTarget);
        Ss(:,iImg,iTarget)     = StatsOut.Ss(iTarget);
        tMatch(:,iImg,iTarget) = StatsOut.tMatch(iTarget);
    end

end

%% Save output.
ImgStats = struct('L', L, 'C', C, 'Sa', Sa, 'Sa', 'Sa', 'tMatch', tMatch, 'pClipped', pClipped,  ...
                  'sampleCoords', sampleCoords, 'imgDir' D, 'Settings', Settings);


