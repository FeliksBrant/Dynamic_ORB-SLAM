function [ Mx ] = crossMx( m )
% CROSSMX Returns the skew-symmetric cross-operator matrix.
%
% [ Mx ] = crossMx( m ) 
%
% if m = [m1 m2 m3]', Mx = [   0  -m3   m2 ]
%                          [  m3   0   -m1 ]
%                          [ -m2   m1   0  ]
%


Mx = [ 0    -m(3)  m(2) ;
       m(3)   0   -m(1) ;
      -m(2)  m(1)    0   ];
  