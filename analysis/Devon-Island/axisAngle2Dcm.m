function [ C ] = axisAngle2Dcm( a, r )
%AXISANGLE2DCM convert an axis and r to a rotation matrix
% 
%  [ C ] = axisAngle2Dcm( a, r )
%
% Input:
% a - a 3x1 unit-length rotation axis
% r - a scalar rotation r in radians.
%
% Output:
% C - the rotation matrix corresponding the the axis/r rotation
%
% See also DCM2AXISANGLE

if (sum(size(a)' == [3; 1]) ~= 2)
    error('a must be a 3x1 vector. a was %dx%d',size(a,1), size(a,2));
end

na = norm(a);


if(abs(na) < 1e-15)
    error('The input axis length is close to zero. Length, %f, should be 1.0',na);
end

if (abs(1 - na) > 1e-6)
    warning('The input axis, a, was not normalized. Length, %f, should be 1.0. The axis will be normalized to create the rotation matrix.', na);
end

a = a/na;

C = a*(a') + (eye(3) - a*(a'))*cos(r) - crossMx(a) * sin(r);



end

