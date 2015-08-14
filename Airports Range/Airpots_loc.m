% Plots the location of 936 Airports stored in Airports.mat on a 3D Globe
clear all
close all
clc
load('airports.mat')

% Parse Lat and long
len = length(GeographicLocation);
lat = zeros(len,1);
lon = zeros(len,1);
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
    lat(i) = sign1*(str2num(GeographicLocation{i}(1:space{1}-4))+(str2num(GeographicLocation{i}(space{1}-3:space{1}-2))/60));
    lon(i) = sign2*(str2num(GeographicLocation{i}(space{1}+1:end-3))+(str2num(GeographicLocation{i}(end-2:end-1))/60));
end

% Plot Earth
max_size = 20;
ratio = max_size/max(Lengthft);
marksize = Lengthft*ratio;

satglobe4
h=plot3m(lat,lon,0.01,'r.', 'MarkerSize', 20);