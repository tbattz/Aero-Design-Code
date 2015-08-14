% Plots the paths between a given list of airpots on a worldmap
clear all
close all
clc


% Load map
figure('units','normalized','outerposition',[0 0 1 1])
worldmap world

% Load Coastline
load coast

% Plot Coastline
plotm(lat,long)

% Define Airport 1
lat1 = -33.8650;
lon1 = 151.2094;

% Define Airport 2
lat2 = 32.7767;
lon2 = -96.7970;

% Calculate the great circle track.
[lattrkgc,lontrkgc] = track2(lat1,lon1,lat2,lon2);

% Plot endpoints (Airport)
plotm(lat1,lon1,'r.','MarkerSize',25);
plotm(lat2,lon2,'r.','MarkerSize',25);

plotm(lattrkgc,lontrkgc,'r')