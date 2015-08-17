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
% worldmap world
% ax = axesm('MapProjection', 'eqdcylin','grid','on', ...
%     'frame', 'on', 'maplonlimit', [0 360]);
ax = axesm('MapProjection', 'robinson','grid','on', ...
    'frame', 'on', 'maplonlimit', [0 360]);
% tightmap
% load satglobe4
% latlim = [-90  90];
% lonlim = [0 360];
% gratsize = 1 + [diff(latlim), diff(wrapTo360(lonlim))]/6;
% [lat, lon] = meshgrat(latlim, lonlim, gratsize);
% lon(:,1) = 0;
% % Adjusting image c
% center = floor(size(c,2)/2); 
% d(size(c,1),size(c,2),size(c,3)) = uint8(0);
% d(:,1:center+1,:) = c(:,center+1:end,:);
% d(:,center+2:end,:) = c(:,1:center,:);
% surfacem(lat, lon, flipud(d));

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
    
    % Fixing labels manually
    if (strcmp(CityName{i},'BRISBANE') || strcmp(CityName{i},'SYDNEY') || strcmp(CityName{i},'MELBOURNE'))==1
        textm(lat1,lon1,[CityName{i} '   '],'Color','k','FontSize',12,'HorizontalAlignment','right');
    end
    if (strcmp(CityName{j},'BRISBANE') || strcmp(CityName{j},'SYDNEY') || strcmp(CityName{j},'MELBOURNE'))==1
        textm(lat2,lon2,[CityName{j} '   '],'Color','k','FontSize',12,'HorizontalAlignment','right');
    end
    if (strcmp(CityName{i},'JOHANNESBURG INTL')==1)
        textm(lat1,lon1,['   ' 'JOHANNESBURG'],'Color','k','FontSize',12,'HorizontalAlignment','left');
    end
    if (strcmp(CityName{j},'JOHANNESBURG INTL')==1)
        textm(lat2,lon2,['   ''JOHANNESBURG'],'Color','k','FontSize',12,'HorizontalAlignment','left');
    end    
    if (strcmp(CityName{j},'HONG KONG') ==1)
        textm(lat2,lon2,[CityName{j}],'Color','k','FontSize',12,'HorizontalAlignment','center','VerticalAlignment','top');
    end    
    if (strcmp(CityName{j},'TAIPEI INTL.')==1)
        textm(lat2,lon2,['  TAIPEI'],'Color','k','FontSize',12,'HorizontalAlignment','left');
    end
    if (strcmp(CityName{i},'BOMBAY') ==1 || strcmp(CityName{i},'DUBAI'))
        textm(lat1,lon1,[CityName{i}],'Color','k','FontSize',12,'HorizontalAlignment','center','VerticalAlignment','top');
    end    
    if (strcmp(CityName{i},'DOHA') || strcmp(CityName{i},'TEL AVIV') )==1
        textm(lat1,lon1,[CityName{i} '   '],'Color','k','FontSize',12,'HorizontalAlignment','right');
    end
    if (strcmp(CityName{j},'SAO PAULO') ==1)
        textm(lat2,lon2,[CityName{j}],'Color','k','FontSize',12,'HorizontalAlignment','center','VerticalAlignment','top');
    end    
    if (strcmp(CityName{j},'HOUSTON') ==1)
        textm(lat2,lon2,[CityName{j}],'Color','k','FontSize',12,'HorizontalAlignment','center','VerticalAlignment','top');
    end
    if (strcmp(CityName{i},'DALLAS') || strcmp(CityName{i},'LOS ANGELES'))==1
        textm(lat1,lon1,[CityName{i} ' '],'Color','k','FontSize',12,'HorizontalAlignment','right','VerticalAlignment','top');
    end
    if (strcmp(CityName{j},'SAN FRANCISCO')==1)
        textm(lat2,lon2,[CityName{j} ' '],'Color','k','FontSize',12,'HorizontalAlignment','right','VerticalAlignment','bottom');
    end
    if (strcmp(CityName{i},'VANCOUVER'))
        textm(lat1,lon1,[CityName{i}],'Color','k','FontSize',12,'HorizontalAlignment','right','VerticalAlignment','bottom');
    end    
    if (strcmp(CityName{i},'TORONTO')==1)
        textm(lat1,lon1,[CityName{i}],'Color','k','FontSize',12,'HorizontalAlignment','left','VerticalAlignment','bottom');
    end
    if (strcmp(CityName{i},'CHICAGO')==1)
        textm(lat1,lon1,[CityName{i}],'Color','k','FontSize',12,'HorizontalAlignment','right','VerticalAlignment','bottom');
    end
    if (strcmp(CityName{i},'NEWARK'))
        textm(lat1,lon1,[CityName{i}],'Color','k','FontSize',12,'HorizontalAlignment','left','VerticalAlignment','bottom');
    end
    if (strcmp(CityName{i},'NEW YORK JOHN F. KENNEDY'))
        textm(lat1,lon1,['JFK'],'Color','k','FontSize',12,'HorizontalAlignment','left','VerticalAlignment','top');
    end
    if (strcmp(CityName{j},'ATLANTA')==1)
        textm(lat2,lon2,[' ATLANTA'],'Color','k','FontSize',12,'HorizontalAlignment','left');
    end
end

% Save Figure
% saveas(gcf,'Routes.png');