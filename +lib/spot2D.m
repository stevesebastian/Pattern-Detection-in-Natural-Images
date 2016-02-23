function spot = spot2D(stimulusParams)
% SPOT2D Create a pedestal stimulus. /----\
%                                   |  __  | 
%                                   | |__| |
%                                    \____/                 
% R. Calen Walshe 02/12/2016 (calen.walshe@utexas.edu)

if nargin < 1
    stimulusParams.pixperdeg = 60;
    stimulusParams.size        = .35;
    stimulusParams.dc          = 0;    
    stimulusParams.contrast    = 1;
    stimulusParams.type        = 'spot';
end

paramNames      =  {'pixperdeg','size','dc','contrast','type'};
param_fields    = fieldnames(stimulusParams);
has_params      = ismember(paramNames,param_fields);
if(any(~has_params))
    error('Poorly specified haar parameter set');
end    

spotRadPx       = floor((stimulusParams.size/2)*stimulusParams.pixperdeg);

interiorRadDeg  = stimulusParams.size/2 * 1/sqrt(2);

[XX, YY] = meshgrid(-spotRadPx:spotRadPx);

dGrid       = sqrt(XX.^2 + YY.^2) ./ stimulusParams.pixperdeg;
envelope    = dGrid < stimulusParams.size/2;

spot = ones(size(dGrid)) * -1;

spot(dGrid < interiorRadDeg) = 1;

spot = (spot - mean(spot(envelope(:)))) .* envelope;

end
