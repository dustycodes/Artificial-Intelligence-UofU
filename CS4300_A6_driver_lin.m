function [x_trace,a_trace,z_trace,Sigma2_trace] = ...
    CS4300_A6_driver_lin(x0,y0,vx0,vy0,max_time,del_t,theta)
% CS4300_A6_driver_lin - driver function for linear Kalman Filter
% On input:
%     x0 (float): initial x location
%     y0 (float): initial y location
%     vx0 (float): initial x velocity
%     vy0 (float): initial y velocity
%     max_time (float): max time for tracking
%     del_t (float): time step size
%     theta (float): angle of line (in radians)
% On output:
%     x_trace (nx2 array): each row has estimated pose (x,y vals)
%     a_trace (nx2 array): actual location at each time step
%     z_trace (nx2 array): sensed location at each time step
%     Sigma2_trace (struct array): covariance of estimated location
%       (i).Sigma2 (2x2 array): covariance matrix for i_th step
% Call:
%     [xt,at,zt,St] = CS4300_A6_driver_lin(0,0,1,1,1,0.1,pi/4);
% Author:
%     Scott Hoge
%     UU
%     Fall 2016

C = [1 0 0 0; 0 1 0 0];

Q = [.5 0; 0 5];% noise for sensor

B = [del_t^(2)*.5 0; 0 del_t^(2)*.5; del_t 0; 0 del_t];

ax = 0;
ay = 0;

A = [1 0 del_t 0; 0 1 0 del_t; 0 0 1 0; 0 0 0 1];

R = [.25 0 0 0; 0 .25 0 0; 0 0 0 0; 0 0 0 0];

xa = [x0;y0;vx0;vy0];

a_trace = xa';

z_trace = CS4300_Sensor(C,xa,Q)';

u = [ax;ay];

x = [z_trace(1); z_trace(2); 0; 0];

sigma = zeros(4,4);

Sigma2_trace(1).Sigma2 = zeros(2,2);

num_steps = length([0:del_t : max_time]);

for s = 1 : num_steps
    xa = A * xa + B * u;
    noise = [sqrt(R(1,1))*randn;sqrt(R(2,2))*randn;...
        sqrt(R(3,3))*randn;sqrt(R(4,4))*randn];
    xa = xa + noise;
    a_trace(s+1,:) = xa';
    z = CS4300_Sensor(C,xa,Q);
    z_trace(s+1,:) = z';
    [x, sigma] = CS4300_KF(x,sigma,u,z,A,R,B,C,Q);
    x_trace(s+1,:) = x';
    Sigma2_trace(s+1).Sigma2 =  sigma; 
end






















