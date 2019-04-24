function [ gps ] = readGpsTopocentric( datalogDir )
%READGPSTOPOCENTRIC Reads the GPS file containing topocentric x,y,z
%
% [ gps ] = readGpsTopocentric( datalogDir )
%
% Input:
% datalogDir - the directory containting the rover traverse logs
%
% Output:
% gps - a struct array with the gps measurements. Each
%                element of the array has the following fields:
%       x - the platform's easting in meters
%       y - the platform's northing in meters
%       z - the platform's elevation in meters
%       imageIdx  - the image index that this GPS point is associated with

g = str2num(fileread(fullfile(datalogDir,'gps-topocentric.txt')));

gps = struct();

for i = 1:size(g,1)
   gps(i).imageIdx = g(i,1);
   gps(i).x = g(i,2);
   gps(i).y = g(i,3);
   gps(i).z = g(i,4);
end


end

