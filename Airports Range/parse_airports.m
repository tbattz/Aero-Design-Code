% Parses airport data and saves the lat and lon to file.

% Parse Lat and long
len = length(GeographicLocation);
alat = zeros(len,1);
alon = zeros(len,1);
for i=1:len
    space = strfind(GeographicLocation(i),' ');
    if strcmp(GeographicLocation{i}(space{1}-1),'N')==1
        sign1 = 1;
    else
        sign1 = -1;
    end
    if strcmp(GeographicLocation{i}(end),'E')==1
        sign2 = 1;
    else
        sign2 = -1;
    end
    alat(i) = sign1*(str2num(GeographicLocation{i}(1:space{1}-4))+(str2num(GeographicLocation{i}(space{1}-3:space{1}-2))/60));
    alon(i) = sign2*(str2num(GeographicLocation{i}(space{1}+1:end-3))+(str2num(GeographicLocation{i}(end-2:end-1))/60));
end

% Save to file
save('airports.mat');