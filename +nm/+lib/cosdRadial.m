function Z = cosdRadial(Xdeg,Ydeg,freqCycDeg,amp,dc,bPLOT)

% function cosdRadial(Xdeg,Ydeg,freqCycDeg,bPLOT)
% 
%   example call: [X Y ] = meshgrid(linspace(-180,180));
%                 Z = cosdRadial(X,Y,3,1);
%
% radially symmetric cosine with specified frequency at locations Xdeg, Ydeg
%
% Xdeg:
% Ydeg:
% freqCycDeg:
% amp: amplitude
% bPLOT:
% %%%%%%%%%%%%%%%%%
% Z: height of cosine


if ~exist('bPLOT')
   bPLOT = 0; 
end

phi = 0;
Z = amp.*cosd(360.*freqCycDeg.*sqrt(Xdeg.^2 + Ydeg.^2) + phi) + dc; 


if bPLOT == 1
    figure('position',[193   944   646   338]); subplot(1,2,1);
    imagesc(Xdeg(1,:),Ydeg(:,1)',Z); 
    axis square;
    
    subplot(1,2,2); 
    surf(Xdeg(1,:),Ydeg(:,1)',Z,'edgecolor','none');
%     axis off;
    axis square; box on 
    
    colormap gray
end