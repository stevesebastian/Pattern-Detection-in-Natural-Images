function [S, P, P_envelope] = getPatchFromStatStruct(statStruct, patchIndex, filePath, bDisp, envelope)
%Purpose: Given a patch number, returns a surround (S) and target patch (P)
%image
%input: 
%           statStruct  - stat structure
%           patchIndex  - patch number
%           filePath    - path where the image file is stored (optional)
%           bDisp       - boolean for displaying the image and statistics (optional)
%output: 
%           S           - image surround patch
%           P           - image background
%           S255        - 255x255 background surround patch

% get row and column index of patches
[coordIndex, imgIndex]    = ind2sub(size(statStruct.C), patchIndex);

% if the file path is not specified, set it to a default
if(~exist('filePath', 'var'))
   % disp('Warning: file path not specified, setting to default');
    filePath = 'D:\sebastian\natural_images\images_stats';
end;

% if the display boolean is not set, default to 0
if(~exist('bDisp', 'var'))
    bDisp = 0;
end;

if(~exist('envelope', 'var'))
    envelope = [];
end;

imName = statStruct.imgDir(imgIndex).name;
load([filePath '/' imName]);

% crop out the surround patch
S = cropImage(I_PPM, statStruct.smpCoords(coordIndex,:), statStruct.surroundSizePix, [], 1);

% crop out the patch
B_location = ceil(statStruct.surroundSizePix/2);
P = cropImage(S, [B_location B_location], statStruct.targetSizePix, [], 1);

if(~isempty(envelope))
    P = double(P);
    P_envelope = ((P-mean(P(:))).*envelope) + mean(P(:));
else
    P_envelope = [];
end

% plot and display statistics
if(bDisp) 
    
    if(isempty(envelope))
        bitsIn = 8;
        subplot(1, 2, 1);
        imagesc(S, [0 2^bitsIn-1]); colormap gray; axis square; % display the image 
        formatFigure('', '', '', 0, 0, 20, 24);
        axis square;
        set(gca, 'xtick', []); set(gca, 'ytick', []);

        subplot(1, 2, 2);
        imagesc(P, [0 2^bitsIn-1]); colormap gray; axis square; % display the image 
        formatFigure('', '', '', 0, 0, 20, 24);
        axis square;
        set(gca, 'xtick', []); set(gca, 'ytick', []);
    else
        bitsIn = 8;
%         envelope = envelope./max(envelope(:));
%         
%         subplot(2, 2, 1);
%         imagesc(S, [0 2^bitsIn-1]); colormap gray; axis square; % display the image 
%         formatFigure('', '', '', 0, 0, 20, 24);
%         axis square;
%         set(gca, 'xtick', []); set(gca, 'ytick', []);
% 
%         subplot(2, 2, 2);
%         imagesc(P, [0 2^bitsIn-1]); colormap gray; axis square; % display the image 
%         formatFigure('', '', '', 0, 0, 20, 24);
%         axis square;
%         set(gca, 'xtick', []); set(gca, 'ytick', []);

%         subplot(1, 2, 3);
        pEnv = double(P);
        pEnv = (pEnv-mean(pEnv(:))).*envelope + mean(pEnv(:));
        imagesc(pEnv, [0 2^bitsIn-1]); colormap gray; axis square; % display the image 
        formatFigure('', '', '', 0, 0, 20, 24);
        axis square;
        set(gca, 'xtick', []); set(gca, 'ytick', []);
    end
        
end;