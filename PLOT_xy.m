function PLOT_xy(fid, fn, nmsh, nang, igrp, istr, igcf, fgca, xymx, lbrad, imod, XX, YY)
if nmsh == 0
    return;
end

xstr  = istr(1, 1);
ystr  = istr(1, 2);
nsize = istr(1, 3);
%% READ
CC = [];
kk = zeros(1, nang);

if imod == 2 % FDM
    mang = 1;
else
    mang = 3;
end

for ibdy = 1:nmsh
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', mang+1);
    
    for iang = 1:mang
        kk(iang) = sscanf(Intro{1}{1+iang}, '%f');
    end
    
    for iang = mang+1:nang
        kk(iang) = kk(1);
    end
    
    CC = [CC;kk];
end

ymxrad = max(max(CC));
ymnrad = min(min(CC));
%% PLOT
f1 = figure;
figure(f1);

patch(XX',YY',CC','LineStyle','None');
%% CNTL : Text
c = colorbar;
set(c, 'FontSize', 30);
xlabel('Distance from Center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from Center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')
c.Label.String = lbrad;

str = sprintf('%d G', igrp);
%text(xstr, ystr, str, 'FontWeight', 'bold', 'FontSize', nsize);
caxis([ymnrad, ymxrad]);
%% CNTL : Layout
xlim([xymx(1, 1) xymx(1, 2)]);
ylim([xymx(2, 1) xymx(2, 2)]);

axis equal
set(gcf, 'Position', igcf(1, 1:4))
set(gca, 'Position', fgca(1, 1:4))

FUNC_polarmap(true);
%% SAVE : PNG
str = sprintf('%d', igrp);
gn = strcat(fn, "_", str, ".png");
saveas(f1, gn);
close(f1);
end