clc; close all; clear;
fn = 'RX000 Nodal 00_TPN';
%% READ & INIT
[nmsh, nang, ngrp, istr, igcf, fgca, lbrad, imod] = READ_info(fn);
[grdrad] = READ_grid(fn, nmsh, nang);
[XX, YY, xymx] = SET_grid(nmsh, nang, grdrad);
%% PLOT : Rad.
for igrp = 1:ngrp
    str = sprintf('%.3d', igrp);
    gn  = strcat(fn, '_', str, '.out');
    fid = fopen(gn);
    PLOT_xy(fid, fn, nmsh, nang, igrp, istr, igcf, fgca, xymx, lbrad, imod, XX, YY);
    fclose(fid);
end

return