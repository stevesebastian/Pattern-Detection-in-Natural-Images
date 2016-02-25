function out = freqSpace(nx)
% Output frequency space for matlab discrete fourier transforms
  negativeHalf = ceil((nx-1)/2);
  positiveHalf = nx-negativeHalf-1;
  out = [-negativeHalf:positiveHalf]./(2*negativeHalf);