function [imgOut, percentClipped] = embedImageinCenter(imgIn, target, bAdditive, bitsIn, offsetPix, bClip)
%EMBEDIMAGEINCENTER Embeds a target in the center of the input image
%
% Example: 
%   [imgOut, percentClupped] = lib.EMBEDIMAGEINCENTER(I, T, 1, 8, 0, 0);
% 
% Output:
%   imgOUt:         imput with target embedded
%   percentClipped: If bAdditive == 1, the % of clipped pixels
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

%% Set defaults
if(~exist('bAdditive', 'var'))
    bAdditive = 0;
end;
    
if(~exist('bitsIn', 'var') || isempty(bitsIn))
    bitsIn = 16;
end;

if(~exist('offsetPix', 'var'))
    offsetPix = 0;
end;

if(~exist('bClip', 'var'))
    bClip = 0;
end;

percentClipped = 0;

maxPixVal = 2^bitsIn - 1;

% get the patch sizes
inSize = size(imgIn);
tgSize = size(target);

if(tgSize(1) > inSize(1) || tgSize(2) > inSize(2))
    error('ERROR: Target is larger than image');
end;

% get the location of the center of the image
centerLocation = floor(inSize./2) + 1;

centerLocation(2) = centerLocation(2) + offsetPix;

% get the x and y areas over which to embed the target
targetRangeX = (centerLocation(1) - floor(tgSize(1)./2)):(centerLocation(1) + ceil(tgSize(1)./2) - 1);
targetRangeY = (centerLocation(2) - floor(tgSize(2)./2)):(centerLocation(2) + ceil(tgSize(2)./2) - 1);

% embed the target
if(bAdditive)
    imgIn(targetRangeX, targetRangeY) = imgIn(targetRangeX, targetRangeY) + target;
    % check for clipping
    percentClipped = (sum(imgIn(:) > maxPixVal) + sum(imgIn(:) < 0))./(length(target(:)))*100;
    % clip the image
    if(bClip)
        imgIn(imgIn < 0) = 0;
        imgIn(imgIn > maxPixVal) = maxPixVal;
    end
else
    imgIn(targetRangeX, targetRangeY) = target;
end;

imgOut = imgIn;



