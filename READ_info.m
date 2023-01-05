function [nmsh, nang, ngrp, istr, igcf, fgca, lbrad, imod] = READ_info(fn)
% ASSUME : Only Rad.

gn    = strcat(fn, '.info');
fid   = fopen(gn);
ncard = 9;
%% SKIP : Echo
while 1
    tline = fgetl(fid);
    nLgh  = length(tline);
    
    if (nLgh < 6)
        continue;
    elseif (tline(1:6) == "$ Rad.")
        break;
    end
end
%% READ : Rad.
while 1
    tline = fgetl(fid);
    nLgh  = length(tline);
    
    if (nLgh < 1)
        continue;
    elseif (tline(1:1) == '.')
        fclose(fid);
        return;
    elseif (tline(1:5) == "$ Ax.")
        break;
    end
    
    Intro = textscan(tline(ncard+1:nLgh), '%s', 100);
    
    switch tline(1:ncard)
        case "     Mod."
            ltmp = tline(ncard+2:nLgh);
            
            if ltmp == 'TPN'
                imod = 1;
            elseif ltmp == 'FDM'
                imod = 2;
            elseif ltmp == 'HEX'
                imod = 3;
            else
                error("WRONG MOD");
            end
        case "# of Dat."
            nmsh = sscanf(Intro{1}{1}, '%d');
            nang = sscanf(Intro{1}{2}, '%d');
            ngrp = sscanf(Intro{1}{3}, '%d');
        case "   String"
            istr(1, 1) = sscanf(Intro{1}{1}, '%f');
            istr(1, 2) = sscanf(Intro{1}{2}, '%f');
            istr(1, 3) = sscanf(Intro{1}{3}, '%f');
        case "      GCF"
            igcf(1, 1) = sscanf(Intro{1}{1}, '%d');
            igcf(1, 2) = sscanf(Intro{1}{2}, '%d');
            igcf(1, 3) = sscanf(Intro{1}{3}, '%d');
            igcf(1, 4) = sscanf(Intro{1}{4}, '%d');
        case "      GCA"
            fgca(1, 1) = sscanf(Intro{1}{1}, '%f');
            fgca(1, 2) = sscanf(Intro{1}{2}, '%f');
            fgca(1, 3) = sscanf(Intro{1}{3}, '%f');
            fgca(1, 4) = sscanf(Intro{1}{4}, '%f');
         case "    Label"
             lbrad = tline(ncard+2:nLgh);
        otherwise
            error("WRONG CARD");
    end
end
end