function [ knownOrientations ] = readKnownOrientations( datalogDir )
%READKNOWNORIENTATIONS reads the file of known orientations
%   
% [ knownOrientations ] = readKnownOrientations( datalogDir )
%
%
% Input:
% datalogDir - the directory containting the rover traverse logs
%
% Output:
% knownOrientations - A struct array containing the known orientations.
%                     Each struct has the following fields:
%                     C_tc     - the rotation matrix that takes vectors from
%                                the camera frame to the topocentric frame
%                     imageIdx - the image index this orientation is
%                                associated with


ko = str2num(fileread(fullfile(datalogDir,'known-orientations.txt')));

knownOrientations = struct();

for i = 1:size(ko,1)
   knownOrientations(i).C_tc = axisAngle2Dcm(ko(i,2:4)',ko(i,5));
   knownOrientations(i).imageIdx = ko(i,1);
end


end

