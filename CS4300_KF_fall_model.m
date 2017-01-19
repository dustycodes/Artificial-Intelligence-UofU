function [yat,yt,sigma2t,zt] = CS4300_KF_fall_model(sigma2_p,sigma2_z)
% CS4300_KF_fall_model - Kalman Filter estimates of state of falling ball
% On input:
%     sigma2_p (float): process variance
%     sigma2_z (float): sensor variance
% On output:
%     yat (nx1 vector): trace of y actual
%     yt (nx1 vector): trace of y estimate
%     sigma2t (nx1 vector): trace of state estimate variance
%     zt (nx1 vector): trace of sensor values
% Call:
%     [yat,yt,s2t,zt] = CS4300_KF_fall_model(0.1,1);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

y0 = 80;
dt = 0.1;
g = -9.8;
max_time = 10;
C = 1;
yat = [y0];
yt = [];
sigma2t = [0];
zt = [];
sigma2 = 0;
t_vals = [0:dt:max_time];
num_steps = length(t_vals);
y = y0;
z0 = CS4300_fall_sensor(y0,C,sigma2);
yt = z0;
zt = [z0];
v = 0;
ya = y0;

A = 1;
B = dt;
R = sigma2_p;
Q = sigma2_z;

for s = 1:num_steps
    v = v + g*dt;
    ya = CS4300_fall_model(ya,v,dt);
    if ya<0
        ya = abs(ya);
        v = -v;
    end
    yat = [yat;ya];
    z = CS4300_fall_sensor(ya,C,sigma2_z);
    zt = [zt;z];
    [y,sigma2] = CS4300_KF(y,sigma2,v,z,A,B,R,C,Q);
    yt = [yt;y];
    sigma2t = [sigma2t;sigma2];
end