function spot = spot(spotParams)



spotRadPx     = floor(spotParams.spotWidth/2);
ppd           = spotParams.ppd;
widthIntDeg    = spotRadPx/ppd * .75;

[XX, YY] = meshgrid(-spotRadPx:spotRadPx);

dGrid = sqrt(XX.^2 + YY.^2) ./ ppd;

spot = zeros(size(dGrid));

spot(dGrid > widthIntDeg) = -1;
spot(dGrid < widthIntDeg) = 1;
end