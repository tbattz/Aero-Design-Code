function [comp_span comp_tot] = parse_lod(folder,name)
% ======================================================================= %
% Parses the vspAero history file to get a number of coefficients at each
% iteration
% =============================== INPUTS ================================ %
% folder:   The folder containing the history file
% name:     The name of the geometry (this does not include the history file)
% =============================== OUTPUTS =============================== %
% -------------------------------------------------------------------------
% comp_span:         Properties given at varying locations across span
% -------------------------------------------------------------------------
% comp_span.name:    Component name
% comp_span.Yavg:    Vector of average y position from centerline
% comp_span.Chord:   Chord Yavg locations
% comp_span.Cl:      Local Lift Coefficient for Yavg vector
% comp_span.Cd:      Local Drag Coefficient for Yavg vector
% comp_span.Cs:      Local Side Force Coefficient for Yavg vector
% comp.CDi:          Integrated Induced Drag Coefficient
% -------------------------------------------------------------------------
% comp_tot:          Properties given as a total for the component
% -------------------------------------------------------------------------
% comp_tot.name:     Component name
% comp_tot.CL:       Component integrated lift coefficient
% comp_tot.CDi:      Component integrated induced drag coefficient
% comp_tot.CS:       Component integrated side force coefficient
% comp_tot.CFx:      Component integrated X force coefficient
% comp_tot.CFy:      Component integrated Y force coefficient
% comp_tot.CFz:      Component integrated Z force coefficient
% comp_tot.Cmx:      Component integrated X moment coefficient
% comp_tot.Cmy:      Component integrated Y moment coefficient
% comp_tot.Cmz:      Component integrated Z moment coefficient
% ======================================================================= %

% Open file
filename=[folder name '_DegenGeom.lod'];
fileID = fopen(filename);

% Skip first line
tline = fgetl(fileID);
tline = fgetl(fileID);

no=0;
old_no=0;
i=0;
% Loop through spanwise information
while length(tline)>1
    % Split at spaces
    split = strsplit(tline,' ');
    % Get Component number
    no = str2num(split{2});
    % Check if new part
    if no==old_no
        i=i+1;
    else
        % New Component
        i=1;
    end
    % Parse Data at current location
    comp_span{no}.Yavg(i) = str2num(split{3});
    comp_span{no}.Chord(i) = str2num(split{4});
    comp_span{no}.Cl(i) = str2num(split{5});
    comp_span{no}.Cd(i) = str2num(split{6});
    comp_span{no}.Cs(i) = str2num(split{7});
    
    % Get next line
    tline = fgetl(fileID);
    old_no = no;
end

% Jump 4 lines
for a=1:4
    tline = fgetl(fileID);
end

% Loop through total information
while ischar(tline)==1
    % Split at spaces
    split = strsplit(tline,' ');
    no = str2num(split{1}); % Component number
    % Get Component Name
    comp_span{no}.name = split{2};
    comp_tot{no}.name = split{2};
    % Get Data
    comp_tot{no}.CL = str2num(split{6});
    comp_tot{no}.CDi = str2num(split{7});
    comp_tot{no}.CS = str2num(split{8});
    comp_tot{no}.CFx = str2num(split{9});
    comp_tot{no}.CFy = str2num(split{10});
    comp_tot{no}.CFz = str2num(split{11});
    comp_tot{no}.Cmx = str2num(split{12});
    comp_tot{no}.Cmy = str2num(split{13});
    comp_tot{no}.Cmz = str2num(split{14});
    % Get next line
    tline = fgetl(fileID);
end

end