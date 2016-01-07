function C = fftconv2(A,B)
% if(size(A,1) < size(B,1))
%     tmp = A;
%     B = A;
%     A = tmp;
% end
% 
% C = conv2(A,B);
% C = C(floor(size(B,1)/2):floor(size(B,1)/2)+size(A,1)-1,...
%     floor(size(B,2)/2):floor(size(B,2)/2)+size(A,2)-1);

%% function C = fftconv2(A,B)
% Calculate 2D convolution of A and B
%
% Use fft2, so much faster than conv2 in matlab
% A and B must be 2D
% C has same size as bigger input (A or B)
%  
%  Convolution needs to be associative
%
% YC at ES lab
% Created on Sep. 29, 2009
% Last modified on Oct. 1, 2009

%% Check inputs and/or outputs
[nYA,nXA] = size(A);
[nYB,nXB] = size(B);

%% Convolution
tFFTA = zeros(nYA+nYB-1,nXA+nXB-1);
tFFTB = zeros(nYA+nYB-1,nXA+nXB-1);

tFFTA(1:nYA,1:nXA) = A;
tFFTB(1:nYB,1:nXB) = B;

tConv = ifft2(fft2(tFFTA).*fft2(tFFTB));

% return region size from larger input
% 1. Y dimension
if(nYA > nYB)
    y_range = (1:nYA) + floor(nYB/2);
else
    y_range = (1:nYB) + floor(nYA/2);
end
% 2. X dimension
if(nXA > nXB)
    x_range = (1:nXA) + floor(nXB/2);
else
    x_range = (1:nXB) + floor(nXA/2);
end

C = tConv(y_range, x_range);


