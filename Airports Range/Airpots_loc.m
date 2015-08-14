% Plots the location of 936 Airports stored in Airports.mat on a 3D Globe
clear all
close all
clc

% Load Data
load('airports.mat')

% Plot Earth
max_size = 20;
ratio = max_size/max(Lengthft);
marksize = Lengthft*ratio;

satglobe4
h=plot3m(lat,lon,0.01,'r.', 'MarkerSize', 20);