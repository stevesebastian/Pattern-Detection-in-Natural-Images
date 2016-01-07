function Settings = experimentSettings(typeStr)
% EXPERIMENTSETTINGS Returns structure with experimental values (e.g. targets)
% 
% Example: 
% 	Settings = experimentSettings('fovea')
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

	% Statistic parameters
	surroundSizePix = 513;
	targetSizePix = size(gabor,1);
	spacingPix = 10;
	imgSizePix = [2844 4284];

	lumMax = 2^14-1;

	% Binning parameters
	[binEdges.L, binCenters.L] = stats.computeBinSpacing(6, 62, 10);
	[binEdges.C, binCenters.C] = stats.computeBinSpacing(0.03, 0.47, 10);
	[binEdges.G, binCenters.G] = stats.computeBinSpacing(0.13, 0.35, 10);
	[binEdges.D, binCenters.D] = stats.computeBinSpacing(0.45, 0.75, 10);

	Settings = struct('gabor', gabor, 'dog', dog, 'envelope', envelope, 'gaborParams', gaborParams, 'dogParams', dogParams, ...
					  'surroundSizePix', surroundSizePix, 'targetSizePix', targetSizePix, 'spacingPix', spacingPix, ...
					  'imgSizePix', imgSizePix, 'lumMax', lumMax, 'binEdges', binEdges, 'binCenters', binCenters);
else
	error('Error: Unsupported experiment type')
end