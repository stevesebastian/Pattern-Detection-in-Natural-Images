function [binEdges, binCenters] = computeBinEdges(xMin, xMax, nBins)
%COMPUTEBINSPACING Compute non-linear stat bin edges and centers
%
% Example
%	[binEdges, binCenters] = computeBinEdges(6, 62, 10);
%
% Steve Sebastian 2016, University of Texas, sebastian@utexas.edu

	a = (xMax/xMin).^(1/nBins);

	binEdges = xMin.*a.^(0:nBins);

	binCenters = mean([binEdges(1:end-1);binEdges(2:end)]);