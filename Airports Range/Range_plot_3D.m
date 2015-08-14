% Plots the location of a single airport and a circle representing the
% furtherst points that an aircraft with the specified range could reach.
% This is plotted on a 3D globe.
clear all
close all
clc

% ============================== Settings =============================== %
% Define Lat/lon
lat = 0;
lon = 0;
% Define Range
range_km = 12000;
% Points to use in drawing the circle
npoints = 60;
% Required Airport
my_airport='MELBOURNE INTL.';
% ======================================================================= %

% ========================== Get Airport Data =========================== %
load('airports.mat')

% Find required airport
len = length(GeographicLocation);
found=0;
i=0;
while found==0
    i=i+1;
    if strcmp(AirportName{i},my_airport)==1
        % Found airport
        found=1;
    end
end

% Parse Lat and long
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
lat = sign1*(str2num(GeographicLocation{i}(1:space{1}-4))+(str2num(GeographicLocation{i}(space{1}-3:space{1}-2))/60));
lon = sign2*(str2num(GeographicLocation{i}(space{1}+1:end-3))+(str2num(GeographicLocation{i}(end-2:end-1))/60));


% Find Required Airport


% Display Earth
satglobe4
[x,y,z] = camtargm(lat,lon,1);
view([x y z])
hold on

% Convert Range
range_deg = km2deg(range_km);

% Plot center point
plot3m(lat,lon,0.01,'r.', 'MarkerSize', 20)

% Generate surrounding points
circ = linspace(0,360,npoints);
[latout, lonout] =reckon(lat,lon,range_deg,circ);

% Plot circle
plot3m(latout,lonout,0.01,'g-', 'MarkerSize', 20)

% Plot shading
