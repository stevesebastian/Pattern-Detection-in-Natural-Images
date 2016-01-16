function Settings = loadExperimentSettings(typeStr)
%LOADEXPERIMENTSETTINGS Returns structure with experimental values (e.g. targets)
% 
% Example: 
% 	Settings = LOADEXPERIMENTSETTINGS('fovea')
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

	[gabor, envelope] = nm.lib.gabor2D(gaborParams, 0);
	[dog, ~] =  nm.lib.differenceOfGaussians2D(dogParams, 0);

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
	[binEdges.L, binCenters.L]  = nm.stats.computeBinSpacing(6, 62, 10);
	[binEdges.C, binCenters.C]  = nm.stats.computeBinSpacing(0.03, 0.47, 10);
	[binEdges.Sa(:,1), binCenters.Sa(:,1)] = nm.stats.computeBinSpacing(0.13, 0.35, 10);
	[binEdges.Sa(:,2), binCenters.Sa(:,2)] = nm.stats.computeBinSpacing(0.45, 0.75, 10);

    imgFilePath = 'D:\sebastian\natural_images\images_stats';

	Settings = struct('imgFilePath', imgFilePath, 'targets', targets, 'targetKey', targetKey, 'envelope', envelope, 'gaborParams', gaborParams, 'dogParams', dogParams, ...
					  'surroundSizePix', surroundSizePix, 'targetSizePix', targetSizePix, 'spacingPix', spacingPix, ...
					  'imgSizePix', imgSizePix, 'pixelMax', pixelMax, 'binEdges', binEdges, 'binCenters', binCenters);
else
	error('Error: Unsupported experiment type')
end