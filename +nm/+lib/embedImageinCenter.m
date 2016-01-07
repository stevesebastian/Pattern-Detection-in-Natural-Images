function [I_out, percentClipped] = embedImageinCenter(I_in, I_target, bAdditive, bitsIn, offsetPix, bClip)
%% Purpose: Places a I_target in the center of I_in
%Input
%       I_in        - input image
%       I_target    - image to place in I_in
%       bAdditive   - boolean, 1 if I_embed should be added to I_in
%       bitsIn      - size of the input image in bits
%       offsetPix   - offset from center in pixels
%Output
%       I_out           - image with target embedded
%       percentClipped  - if additive is selected, the percentage of pixels that
%                           were clipped on either end

%% 

% set bAdditive to 0 as default
if(~exist('bAdditive', 'var'))
    bAdditive = 0;
end;
    
% set bitsIn to 16 as default
if(~exist('bitsIn', 'var') || isempty(bitsIn))
    bitsIn = 16;
end;

% set bitsIn to 16 as default
if(~exist('offsetPix', 'var'))
    offsetPix = 0;
end;

% set clipping to 0
if(~exist('bClip', 'var'))
    bClip = 0;
end;


percentClipped = 0;

% set the max pixel value
maxPixVal = 2^bitsIn - 1;

%% 

% get the patch sizes
inSize = size(I_in);
tgSize = size(I_target);

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
    I_in(targetRangeX, targetRangeY) = I_in(targetRangeX, targetRangeY) + I_target;
    % check for clipping
    percentClipped = (sum(I_in(:) > maxPixVal) + sum(I_in(:) < 0))./(length(I_target(:)))*100;
    % clip the image
    if(bClip)
        I_in(I_in < 0) = 0;
        I_in(I_in > maxPixVal) = maxPixVal;
    end
else
    I_in(targetRangeX, targetRangeY) = I_target;
end;

I_out = I_in;



