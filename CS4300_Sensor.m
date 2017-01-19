function z = CS4300_Sensor(c,x,Q)
% CS4300_KF - one step in Kalman Filter
% On input:
%     C_t (nxn matrix): linear transform for measurement equation
%     Q_t (nxn matrix): noise covariance matrix
% On output:
%     mu_t (nx1 vector): next state estimate
% Call:
%     [x,Sigma2] = CS4300_KF(x,Sigma2,u,z,A,B,R,C,Q);
% Author:
%     Scott Hoge
%     UU
%     Fall 2016

z = c * x + [sqrt(Q(1,1))*randn; sqrt(Q(2,2))*randn];
