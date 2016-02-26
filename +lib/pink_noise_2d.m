function pink_noise = pink_noise_2d(x,y,degreesPerImage)
%pink_noise_2d creates 1/f noise with a specified pixels per degree.

display = false;
if ~exist('x','var')
    x = 250;
    y = 250;
    degreesPerImage = 4;
    display = true;
end  

noise = rand(x,y)-0.5;
fft_noise = fftshift(fft2(noise));
u = lib.freqSpace(x);
v = lib.freqSpace(y);
u = u./degreesPerImage;
v = v./degreesPerImage;
[meshv,meshu] = meshgrid(v,u);
browner = sqrt(meshu.^2+meshv.^2).^(-1);
browner(isinf(browner(:))) = 0; % remove DC
brown_noise = fft_noise.*browner;
unclipped_noise = ifft2(ifftshift(brown_noise),'symmetric');

%We clip the noise at 2 std above and below.
std_UN = std(unclipped_noise(:));
clipped_noise = unclipped_noise;
clipped_noise(unclipped_noise >= 2*std_UN) = 2*std_UN;
clipped_noise(unclipped_noise <= -2*std_UN) = -2*std_UN;

%output
pink_noise = clipped_noise;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DISPLAY
if display
    figure(1)
    imshow(out.pink_noise,[min(out.pink_noise(:)) max(out.pink_noise(:))])
end