function [iter M AOA Beta CL CDo CDi CDtot CS L_D E CFx CFy CFz CMx CMy CMz T_QS skin_drag] = parse_history(folder,name)
% ======================================================================= %
% Parses the vspAero history file to get a number of coefficients at each
% iteration
% =============================== INPUTS ================================ %
% folder:   The folder containing the history file
% name:     The name of the geometry (this does not include the history file)
% =============================== OUTPUTS =============================== %
% iter:         The number of iterations
% M:            The mach number at which the simulation was run
% AOA:          The angle of attack at which the simulation was run
% Beta:         The Sideslipe angle
% CL:           Total Integrated Lift Coefficient
% CDo:          Skin Friction Drag Coefficient (Estimated parasite drag)
% CDi:          Integrated Induced Drag Coefficient
% CDtot:        Total Drag Coefficient (sum of CDo and CDi)
% CS:           Side Force Coefficient
% L_D:          Lift to Drag Ratio (CL/CDtot)
% E:            Oswald Efficiency Factor (Span Efficiency)
% CFx:          X Direction Force Coefficient
% CFy:          Y Direciton Force Coefficient
% CFz:          Z Direction Force Coefficient
% CMz:          X-Axis Moment Coefficient
% CMy:          Y-Axis Moment Coefficient
% CMz:          Z-Axis Moment Coefficient
% T_QS:         Thurst/(Dynamic Pressure * Ref. Area)
% skin_drag:    A structure containing the skin friction drag coefficient
%               for each geometry.
% ======================================================================= %

% Open file
filename=[folder name '_DegenGeom.history'];
fileID = fopen(filename);

% Skip first line
tline = fgetl(fileID);
tline = fgetl(fileID);

% Get Single point information
split = strsplit(tline,' ');
M = str2num(split{3});
AOA = str2num(split{4});
Beta = str2num(split{5});

i=0;
% Loop Through iterations
while length(tline)>1
    i=i+1;
    % Split at spaces
    split = strsplit(tline,' ');
    % Grab data for each iteration
    CL(i) = str2num(split{6});
    CDo(i) = str2num(split{7});
    CDi(i) = str2num(split{8});
    CDtot(i) = str2num(split{9});
    CS(i) = str2num(split{10});
    L_D(i) = str2num(split{11});
    E(i) = str2num(split{12});
    CFx(i) = str2num(split{13});
    CFy(i) = str2num(split{14});
    CFz(i) = str2num(split{15});
    CMx(i) = str2num(split{16});
    CMy(i) = str2num(split{17});
    CMz(i) = str2num(split{18});
    T_QS(i) = str2num(split{19});
    % Get next line
    tline = fgetl(fileID);
end
iter = i;

% Loop unitl Skin Friction Drag Breakdown
while length(tline)~=49
    tline=fgetl(fileID);
end

% Jump Another 2 lines
tline=fgetl(fileID);
tline=fgetl(fileID);

j=0;
while ischar(tline)==1
    j=j+1;
    % Split via spaces
    split = strsplit(tline,' ');
    skin_drag.name{j} = split{1};
    skin_drag.CDo{j}=str2num(split{3});
    % Get next line
    tline=fgetl(fileID);
end

end