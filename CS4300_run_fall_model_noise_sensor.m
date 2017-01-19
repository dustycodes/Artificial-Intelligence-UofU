function [ya,y,v,z,M] = CS4300_run_fall_model_noise_sensor(y0,v0,g,...
    t_max,dt,sigma2_p,sigma2_z)
% CS4300_run_fall_model_noise_sensor - calculates object trajectory
%    with noise and sensor data
% On input:
%     y0 (float): initial height of object
%     v0 (float): initial velocity of object
%     g (float): acceleration
%     t_max (float): max time to run simulation
%     dt (float): time step
%     sigma2_p (float): process variance of Gaussian noise
%     sigma2_z (float): sensor variance of Gaussian noise
% On output:
%     ya (nx1 vector): ideal height trajectory of object
%     y (nx1 vector): actual height trajectory of object
%     v (nx1 vector): velocity trajectory of object
%     z (nx1 vector): sensed height of object
%     M (movie): movie of falling object
% Call:
%     [ya,y,v,z,M] = CS4300_run_fall_model_noise_sensor(100,0,-9.8,...
%            100,0.1,0.01,1);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

t_vals = [0:dt:t_max];
num_t_vals = length(t_vals);
ya = zeros(num_t_vals,1);
ya(1) = y0;
y = zeros(num_t_vals,1);
y(1) = y0;
v = zeros(num_t_vals,1);
v(1) = v0;
z = zeros(num_t_vals,1);
z(1) = CS4300_fall_sensor(y0,1,sigma2_z);
plot([-10,10],[0,0]);
hold on
plot([0,0],[-1,100]);
plot(2,y0,'r+');
plot(3,y0,'ko');
plot(4,z(1),'g*');
M(1) = getframe;
for s = 1:num_t_vals
    v(s+1) = v(s) + g*dt;
    ya(s+1) = CS4300_fall_model(y(s),v(s+1),dt); % ideal y
    y(s+1) = ya(s+1) + sqrt(sigma2_p)*randn;  % actual y
    if y(s+1)<0
        y(s+1) = abs(y(s+1));
        v(s+1) = -v(s+1);
    end
    z(s+1) = CS4300_fall_sensor(y(s+1),1,sigma2_z);
    clf
    plot([-10,10],[0,0]);
    hold on
    plot([0,0],[-1,100]);
    plot(2,ya(s+1),'r+');
    plot(3,y(s+1),'ko');
    plot(4,z(s+1),'g*');
    M(s+1) = getframe;
end