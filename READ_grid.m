function [grdrad] = READ_grid(fn, nmsh, nang)
% ASSUME : Fixed Format

gn     = strcat(fn, '.grid');
fid    = fopen(gn);
ncard  = 4;
grdrad = zeros(nmsh, 2*nang);
%% READ : Rad.
tline = fgetl(fid);
tline = fgetl(fid);

for ibdy = 1:nmsh
    tline = fgetl(fid);
    nLgh  = length(tline);
    Intro = textscan(tline(ncard+1:nLgh), '%s', 100);
    
    for ii = 1:2*nang
        grdrad(ibdy, ii) = sscanf(Intro{1}{1+ii}, '%f');
    end
end

fclose(fid);
end