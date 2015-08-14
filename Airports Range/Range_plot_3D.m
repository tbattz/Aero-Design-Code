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

% Get correct lat and lon values
latt = lat(i);
lonn = lon(i);

% Display Earth
satglobe4
[x,y,z] = camtargm(latt,lonn,1);
view([x y z])
hold on

% Convert Range
range_deg = km2deg(range_km);

% Plot center point
plot3m(latt,lonn,0.01,'r.', 'MarkerSize', 20)

% Generate surrounding points
circ = linspace(0,360,npoints);
[latout, lonout] =reckon(latt,lonn,range_deg,circ);

% Plot circle
plot3m(latout,lonout,0.01,'g-', 'MarkerSize', 20)

% Plot shading
