function y_t = CS4300_fall_model(y_tm1,u_t,dt)
% CS4300_fall_model - calculates one step in falling object trajectory
% On input:
%     y_tm1 (float): height at previous time
%     u_t (float): control parameter at this step
%     dt (float): time step
% On output:
%     y_t (float): height at next time
% Call:
%     y(s+1) = CS4300_fall_model(y(s),v(s+1),dt);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

y_t = y_tm1 + u_t*dt;