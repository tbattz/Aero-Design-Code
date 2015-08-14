function [dist] = route_3dplot(lat1,lon1,lat2,lon2)
% ======================================================================= %
% Plots the shortest distance between two locations given in lattitude and
% longitude coordinates, on a preloaded globe.
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
plot3m(lat1,lon1,0.01,'r.','MarkerSize',25);
plot3m(lat2,lon2,0.01,'r.','MarkerSize',25);

% Calculate distance
arclen = distance('gc',[lat1,lon1],[lat2,lon2]);
dist = deg2nm(arclen,'earth');

% Calculate the great circle track.
[lattrkgc,lontrkgc] = track2(lat1,lon1,lat2,lon2);

% Plot Great Circle Track
plot3m(lattrkgc,lontrkgc,0,'r');

end