function [dist] = route_2dplot(lat1,lon1,lat2,lon2)
% ======================================================================= %
% Plots the shortest distance between two locations given in lattitude and
% longitude coordinates, on a preloaded map.
% =============================== INPUTS ================================ %
% lat1: The lattitude of the start point, where N is positive and S is
%       negative.
% lon1: The longitude of the start point, where E is positive and W is
%       negative.
% lat2: The lattitude of the end point, where N is positive and S is
%       negative.
% lon2: The longitude of the end point, where E is positive and W is
%       negative.
% =============================== OUTPUTS =============================== %
% dist: The shortest distance between the two points
% ======================================================================= %

% Plot endpoints (Airport)
plotm(lat1,lon1,'r.','MarkerSize',25);
plotm(lat2,lon2,'r.','MarkerSize',25);

% Calculate distance
arclen = distance('gc',[lat1,lon1],[lat2,lon2]);
dist = deg2nm(arclen,'earth');

% Calculate the great circle track.
[lattrkgc,lontrkgc] = track2(lat1,lon1,lat2,lon2);

% Plot Great Circle Track
plotm(lattrkgc,lontrkgc,'r')'

end