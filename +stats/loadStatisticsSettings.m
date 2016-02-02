function Settings = loadStatisticsSettings(typeStr)
%LOADSTATISTICSSETTINGS Returns structure with experimental values (e.g. targets)
% 
% Example: 
% 	Settings = LOADSTATISTICSSETTINGS('fovea')
%
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

%%

if(strcmp(typeStr,'fovea'))

	% Target set up
	gaborParams.std        = .14;
	gaborParams.sf         = 4;
	gaborParams.ori        = 90;
	gaborParams.phase      = 0;
	gaborParams.pixperdeg  = 120;
	gaborParams.odd_even   = 'odd';
	gaborParams.envelope   = 'coswin';

	dogParams.stdSurround  = .14;
	dogParams.stdCenter    = 0.07;
	dogParams.pixperdeg    = 120;
	dogParams.envelope     = 'coswin';

	[gabor, envelope] = lib.gabor2D(gaborParams, 0);
	[dog, ~] =  lib.differenceOfGaussians2D(dogParams, 0);

	gabor = gabor./max(gabor(:));
	dog = dog./max(dog(:));

	targets(:,:,1) = gabor;
	targets(:,:,2) = dog;

	targetKey = {{'gabor', 'dog'}};

	% Statistic parameters
	surroundSizePix = 513;
	targetSizePix = size(gabor,1);
	spacingPix = 10;
	imgSizePix = [2844 4284];

	pixelMax = 2^14-1;

	% Binning parameters
    nBins = 10;
	[binEdges.L, binCenters.L]  = stats.computeBinSpacing(6, 62, nBins);
	[binEdges.C, binCenters.C]  = stats.computeBinSpacing(0.03, 0.47, nBins);
	[binEdges.Sa(:,1), binCenters.Sa(:,1)] = stats.computeBinSpacing(0.13, 0.35, nBins);
	[binEdges.Sa(:,2), binCenters.Sa(:,2)] = stats.computeBinSpacing(0.45, 0.75, nBins);

    imgFilePath = 'D:\sebastian\natural_images\images_stats';

	Settings = struct('imgFilePath', imgFilePath, 'targets', targets, 'targetKey', targetKey, 'envelope', envelope, 'gaborParams', gaborParams, 'dogParams', dogParams, ...
					  'surroundSizePix', surroundSizePix, 'targetSizePix', targetSizePix, 'spacingPix', spacingPix, ...
					  'imgSizePix', imgSizePix, 'pixelMax', pixelMax, 'binEdges', binEdges, 'binCenters', binCenters);

elseif(strcmp(typeStr, 'periphery'))
    
	% Target set up
    haarParams.pixperdeg    = 60;
    haarParams.size         = .35;
    haarParams.dc           = 0;
    haarParams.contrast     = 1;

    haarParams.type         = 'vertical';   
	[vertical, envelope] = lib.haar2D(haarParams);
 
    haarParams.type         = 'horizontal';
    [horizontal, envelope]  = lib.haar2D(haarParams);
    
    haarParams.type         = 'bowtie';
    [bowtiehaar, envelope]  = lib.haar2D(haarParams);
	
    vertical    = vertical./max(vertical(:));
    horizontal  = horizontal./max(horizontal(:));
    bowtiehaar      = bowtiehaar./max(bowtiehaar(:));
	targets(:,:,1)  = vertical;
    targets(:,:,2)  = horizontal;
    targets(:,:,3)  = bowtiehaar;
    
	targetKey = {{'vertical','horizontal','bowtie'}};
    
	% Statistic parameters
	surroundSizePix = 241;
	targetSizePix = size(targets(:,:,1));
	spacingPix = 10;
	imgSizePix = [2844 4284];

	pixelMax = 2^14-1;

	% Binning parameters
    nBins = 10;
	[binEdges.L, binCenters.L]  = stats.computeBinSpacing(6, 70, nBins);
	[binEdges.C, binCenters.C]  = stats.computeBinSpacing(0.03, 1.5, nBins);
	[binEdges.Sa(:,1), binCenters.Sa(:,1)] = stats.computeBinSpacing(0.5, 0.9, nBins);
	[binEdges.Sa(:,2), binCenters.Sa(:,2)] = stats.computeBinSpacing(0.5, 0.9, nBins);
	[binEdges.Sa(:,3), binCenters.Sa(:,3)] = stats.computeBinSpacing(0.5, 0.9, nBins);
    
    imgFilePath = '~/occluding/natural_images/pixel_space/';

	Settings = struct('imgFilePath', imgFilePath, 'targets', targets, 'targetKey', targetKey, 'envelope', envelope, 'haarParams', haarParams,...
                      'surroundSizePix', surroundSizePix, 'targetSizePix', targetSizePix, 'spacingPix', spacingPix, ...
					  'imgSizePix', imgSizePix, 'pixelMax', pixelMax, 'binEdges', binEdges, 'binCenters', binCenters);
    
else
	error('Error: Unsupported experiment type')
end
