function [y,v,M] = CS4300_run_fall_model(y0,v0,g,t_max,dt)
% CS4300_run_fall_model - calculates falling object trajectory
% On input:
%     y0 (float): initial height of object
%     v0 (float): initial velocity of object
%     g (float): acceleration
%     t_max (float): max time to run simulation
%     dt (float): time step
% On output:
%     y (nx1 vector): height trajectory of object
%     v (nx1 vector): velocity trajectory of object
%     M (movie): movie of falling object
% Call:
%     [y,v,M] = CS4300_run_fall_model(100,0,-9.8,100,0.1);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

t_vals = [0:dt:t_max];
num_t_vals = length(t_vals);
y = zeros(num_t_vals,1);
y(1) = y0;
v = zeros(num_t_vals,1);
v(1) = v0;
plot([-10,10],[0,0]);
hold on
plot([0,0],[-1,100]);
plot(3,y0,'ko');
M(1) = getframe;
for s = 1:num_t_vals
    v(s+1) = v(s) + g*dt;
    y(s+1) = CS4300_fall_model(y(s),v(s+1),dt);
    if y(s+1)<0
        y(s+1) = abs(y(s+1));
        v(s+1) = -v(s+1);
    end
    clf
    plot([-10,10],[0,0]);
    hold on
    plot([0,0],[-1,100]);
    plot(3,y(s+1),'ko');
    M(s+1) = getframe;
end