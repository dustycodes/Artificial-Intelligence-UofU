function [x_trace,a_trace,z_trace,Sigma2_trace] = CS4300_A5_driver_lin(x0,y0,vx0,vy0,max_time,del_t,theta)
% CS4300_A5_driver_lin - driver function for linear Kalman Filter
% On input:
%   x0 (float): initial x location
%   y0 (float): initial y location
%   vx0 (float): initial x velocity
%   vy0 (float): initial y velocity
%   max_time (float): max time for tracking
%   del_t (float): time step size
%   theta (float): angle of line (in radians)
% On output:
%   x_trace (nx2 array): each row has estimated pose (x,y vals)
%   a_trace (nx2 array): actual location at each time step
%   z_trace (nx2 array): sensed location at each time step
%   Sigma2_trace (struct array): covariance of estimated location
%   (i).Sigma2 (2x2 array): covariance matrix for i_th step
% Call:
%   [xt,at,zt,St] = CS4300_A5_driver_lin(0,0,1,1,1,0.1,pi/4);
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%

end