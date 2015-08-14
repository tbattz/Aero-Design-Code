% Plots the paths between a given list of airpots on a 3D globe and saves
% movie of the globe rotating
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
satglobe4

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
    [dist(k)] = route_3dplot(lat1,lon1,lat2,lon2);
end

% Create movie
writerObj = VideoWriter('Paths.mp4');
writeObj.Quality = 100;
open(writerObj);

% Generate angles
max_el = 45; % Maximum elevation angle in degrees
d_az = 2; % Shift in azimuthal angle
az = 0:d_az:720; % 2 rotations
el = max_el*sind(az/1.5)+25;

% Generate and save frames
for i=1:length(az)
    view(az(i),el(i))
    frame = getframe;
    writeVideo(writerObj,frame);
end

% Close video file
close(writerObj);




