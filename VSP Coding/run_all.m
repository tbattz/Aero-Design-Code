clear all
close all
clc

% Location of files
folder = '/home/bcub3d/Desktop/Uni/2015 Sem 2/MAE3402 - Aerospace Design Project/B777/'; % Requires trailing slash
% Aircraft Name
name = 'B-777';

% Parse History File
[iter M AOA Beta CL CDo CDi CDtot CS L_D E CFx CFy CFz CMx CMy CMz T_QS skin_drag] = parse_history(folder,name);

% Parse LOD File - Spanwise Lift
[comp_span comp_tot] = parse_lod(folder,name);


% Summary Table