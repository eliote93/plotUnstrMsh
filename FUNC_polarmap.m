function FUNC_polarmap(lErr)

% default parameters
m = 64; % number of colors
c = 1;  % exponent of shading factor (1 = linear)

% blue-red
z   = zeros([0,3]);
m2  = m/2;
map = [repmat([0,0,1],[m2,1]);z;repmat([1,0,0],[m2,1])];

% linear shading from min/max (colormap value) to center (white)
r   = repmat(abs(linspace(1,-1,m)).^c,[3,1])';
map = map.*r + 1 - r;

% print
if lErr
    colormap(map)
else
    colormap(map(m2+1:m,:))
end

end