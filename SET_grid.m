function [XX, YY, xymx] = SET_grid(nmsh, nang, grdrad)

XX = [];
YY = [];
X  = zeros(1, nang);
Y  = zeros(1, nang);

for ixy = 1:nmsh
    X(1:nang) = grdrad(ixy, 1:nang);
    Y(1:nang) = grdrad(ixy, nang+1:2*nang);
    
    XX = [XX;X];
    YY = [YY;Y];
end

xymx(1, 1) = min(min(XX)); xymx(1, 2) = max(max(XX));
xymx(2, 1) = min(min(YY)); xymx(2, 2) = max(max(YY));

end