function [haar, envelope] = haar2D(Parameters)
%% haar2D.m
%
%       [gabor, envelope] = gabor2D(X,Y,Parameters)
%
%  Create gabor with the given parameters. Parameters is a struct with the
%  following fields:
%       Parameters.pixperdeg    
%       Parameters.size       (deg) (default: 6*std)
%       Parameters.dc         DC value (default: 0)
%       Parameters.contrast   Michelson contrast (default (100%): 1)
%       Parameters.type       Type of Haar (default: Horizontal)
%
%  October 2, 2015, R. Calen Walshe <calen.walshe@utexas.edu>
%/

%% Check input
if (nargin < 1)
    Parameters.pixperdeg    = 60;
    Parameters.size         = .35;
    Parameters.dc           = 0;
    Parameters.type         = 'vertical';
    Parameters.contrast     = 1;
else
    HAAR_PARAMS     = {'pixperdeg','size','dc','contrast','type'};
    param_fields    = fieldnames(Parameters);
    has_params      = ismember(HAAR_PARAMS, param_fields);
    if(any(~has_params))
        error('Poorly specified haar parameter set');
    end    
end

%% Create Haar grid XX and YY and transform it
sizeRadPx   = floor(Parameters.size/2*Parameters.pixperdeg);
r           = Parameters.size/2; %radius of Haar

X = (-sizeRadPx:sizeRadPx) / Parameters.pixperdeg;
Y = (-sizeRadPx:sizeRadPx) / Parameters.pixperdeg;

[XX YY]     = meshgrid(X,Y);
haarGrid    = XX.^2 + YY.^2 < r^2;

%Luminance of Haar
t       = [0,255];
t_mean  = Parameters.dc;
t_norm  = (t - mean(t)) ./ std(t); % calculate contrast of target like contrast of mask.
t_norm  = t_norm .* Parameters.contrast .* 127;
t_norm  = t_norm + t_mean;


switch Parameters.type
    case('horizontal')
        haar    = [repmat(t_norm(1),sizeRadPx,2*sizeRadPx+1);repmat(t_mean,1,2*sizeRadPx+1);repmat(t_norm(2),sizeRadPx,2*sizeRadPx+1)];
    case('vertical')
        haar    = [repmat(t_norm(1),2*sizeRadPx+1,sizeRadPx),repmat(t_mean,2*sizeRadPx+1,1),repmat(t_norm(2),2*sizeRadPx+1,sizeRadPx)]; % vertical edge haar        
    case('bowtie')
        hwR   = YY./XX;    
        angle = atan(hwR);
        angle(isnan(angle(:))) = 0; % middle pixel is NaN. We want it to be 0.
        
        haar = ones(sizeRadPx*2 + 1) * Parameters.dc;
        
        haar(abs(angle) <= pi/4 + pi/180)   = t_norm(1);
        haar(abs(angle) > pi/4 + pi/180)    = t_norm(2);
    otherwise
        error('Haar type error');
end

haar            = haarGrid .* haar;
haar(haar == 0) = Parameters.dc; % make the surround mean luminance.

%%Envelope
X = (-sizeRadPx*3:sizeRadPx*3) / Parameters.pixperdeg;
Y = (-sizeRadPx*3:sizeRadPx*3) / Parameters.pixperdeg;

[XX YY]     = meshgrid(X,Y);
envelope    = haarGrid;
