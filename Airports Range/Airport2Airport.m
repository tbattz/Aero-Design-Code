% Plots the paths between a given list of airpots on a worldmap
clear all
close all
clc

% Load Airport data
load('airports.mat')

% ============================== SETTINGS =============================== %
start_list = {'KINGFORD SMITH' 'JAN SMUTS' 'DUBAI' 'DALLAS FORT WORTH'...
    'DUBAI' 'DUBAI' 'JOHN F. KENNEDY' 'NEWARK INTL' 'DOHA' 'DUBAI' 'JAN SMUTS'...
    'LOS ANGELES INTL' 'TORONTO' 'JOHN F. KENNEDY' 'JAWAHARIAL NEHRU INTL' 'CHICAGO O''HARE'...
    'VANCOUVER' 'DUBAI' 'DUBAI' 'BEN GURION INTL.'};
end_list = {'DALLAS FORT WORTH' 'WM. B. HARTSFIELD' 'LOS ANGELES INTL' 'BRISBANE' 'HOUSTON INTL'...
    'SAN FRANCISCO' 'KAI TAK' 'KAI TAK' 'HOUSTON INTL' 'DALLAS FORT WORTH'...
    'JOHN F. KENNEDY' 'MELBOURNE INTL.' 'KAI TAK' 'CHIANG KAI SHEK' 'NEWARK INTL'...
    'KAI TAK' 'KINGFORD SMITH' 'WM. B. HARTSFIELD' 'GUARULHAS' 'LOS ANGELES INTL'};

% ======================================================================= %

% Load map
figure('units','normalized','outerposition',[0 0 1 1])
worldmap world

% Load Coastline
load coast

% Plot Coastline
plotm(lat,long)

% Preallocate dist
dist = zeros(length(start_list),1);

% Plot routes
for k=1:length(start_list)
    % Find Location of First Airport
    found=0;
    i=0;
    while found==0
        i=i+1;
        if strcmp(AirportName{i},start_list{k})==1
            % Found airport
            found=1;
        end
    end
    % Find Location fo Second Airport
    found=0;
    j=0;
    while found==0
        j=j+1;
        if strcmp(AirportName{j},end_list{k})==1
            % Found airport
            found=1;
        end
    end
    % Get lat and lon for current two airports
    lat1 = alat(i);
    lon1 = alon(i);
    lat2 = alat(j);
    lon2 = alon(j);
    
    % Find distance and plot   
    [dist(k)] = route_2dplot(lat1,lon1,lat2,lon2);
end