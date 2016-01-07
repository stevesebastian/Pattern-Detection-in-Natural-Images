function PcoordsRC = samplePatchCoordinates(Isize,Psize,patchSpacing,numPatches)

% example call: % TO RETURN ALL COORDS WITH 128 SPACING BETWEEN THEM
%                 samplePatchCoordinates(size(I),size(P),128)
%
%               % TO RETURN TEN COORDS SAMPLED FROM ALL PATCHES WITH 128 PIXEL SPACING     
%                 samplePatchCoordinates(size(I),size(P),128,10)
% 
% Isize:        image size
% Psize:        patch size
% patchSpacing: patch spacing in pixels
% numPatches:   number of patches to randomly sample from all patches
%               if empty, defaults to all patches
%%%%%%%%%%%%%
% PcoordsRC:    row and column indices corresponding to patch location

% 1/2 patch width zone in which images are not selected
PcrdsRlims = [1+round(Psize(1)/2) Isize(1)-ceil(3*Psize(1)/2)+1]; 
PcrdsClims = [1+round(Psize(2)/2) Isize(2)-ceil(3*Psize(2)/2)+1];
[PcrdsR, PcrdsC] = meshgrid(PcrdsRlims(1):patchSpacing:PcrdsRlims(2), ...
                           PcrdsClims(1):patchSpacing:PcrdsClims(2));

% PATCH COORDINATES                       
PcoordsRC = [PcrdsR(:) PcrdsC(:)];


if exist('numPatches','var') && ~isempty(numPatches)
   indP      = randsample(size(PcoordsRC,1),numPatches); 
   PcoordsRC = PcoordsRC(indP,:);
end