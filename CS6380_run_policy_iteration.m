function [S,A,R,P,U,Ut] = CS6380_run_policy_iteration(max_iter)
% CS6380_run_policy_iteration - compute policy using value iteration
% On input:
%   max_iter (int): max number of iterations
% On output:
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk struct array): transition model
%       (s,a).probs (a vector with n transition probabilities from s to 
%           s_prime, given action a)
%   R (vector): state rewards
%   U (vector): state utilities
%   U_t (iterxn): trace of utility values during iteration
% Call:
%   Chapter 17 Russell and Norvig (Table p. 651)
%   [S,A,R,P,U,Ut] = CS6380_run_policy_iteration(0.999999,1000)
%
% U’ =  0.7053 0.6553 0.6114 0.3879 0.7616 0 0.6600 -1.0000
%       0.8116 0.8678 0.9178 1.0000
%
%   Layout:             1
%                       ˆ
%   9 10 11 12          |
%   5  6  7  8      2 <- -> 4
%   1  2  3  4          |
%                       V
%                       3
% Author:
%   Dusty Argyle & Scott Hoge
%   UU
%   Fall 2016
S = [1:12];
A = [1:4];
R = -.04*ones(12,1);
R(6) = 0;
R(8) = -1;
R(12) = 1;

%set P
% for s = 1:12
%     for a = 1:4
%         P(s,a).probs=zeros(1,12);
%     end
% end

% State 1 actions 1:4
P(1, 1).probs = [.1, .1, 0, 0, .8, 0, 0, 0, 0, 0, 0, 0];
P(1, 2).probs = [.9, 0, 0, 0, .1, 0, 0, 0, 0, 0, 0, 0];
P(1, 3).probs = [.9, .1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
P(1, 4).probs = [.1, .8, 0, 0, .1, 0, 0, 0, 0, 0, 0, 0];
% State 2 actions 1:4
P(2, 1).probs = [.1, .8, .1, 0, 0, 0, 0, 0, 0, 0, 0, 0];
P(2, 2).probs = [.8, .2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
P(2, 3).probs = [.1, .8, .1, 0, 0, 0, 0, 0, 0, 0, 0, 0];
P(2, 4).probs = [0, .2, .8, 0, 0, 0, 0, 0, 0, 0, 0, 0];
% State 3 actions 1:4
P(3, 1).probs = [0, .1, 0, .1, 0, 0, .8, 0, 0, 0, 0, 0];
P(3, 2).probs = [0, .8, .1, 0, 0, 0, .1, 0, 0, 0, 0, 0];
P(3, 3).probs = [0, .1, .8, .1, 0, 0, 0, 0, 0, 0, 0, 0];
P(3, 4).probs = [0, 0, .1, .8, 0, 0, .1, 0, 0, 0, 0, 0];
% State 4 actions 1:4
P(4, 1).probs = [0, 0, .1, .1, 0, 0, 0, .8, 0, 0, 0, 0];
P(4, 2).probs = [0, 0, .8, .1, 0, 0, 0, .1, 0, 0, 0, 0];
P(4, 3).probs = [0, 0, .1, .9, 0, 0, 0, 0, 0, 0, 0, 0];
P(4, 4).probs = [0, 0, 0, .9, 0, 0, 0, .1, 0, 0, 0, 0];
% State 5 actions 1:4
P(5, 1).probs = [0, 0, 0, 0, .2, 0, 0, 0, .8, 0, 0, 0];
P(5, 2).probs = [.1, 0, 0, 0, .8, 0, 0, 0, .1, 0, 0, 0];
P(5, 3).probs = [.8, 0, 0, 0, .2, 0, 0, 0, 0, 0, 0, 0];
P(5, 4).probs = [.1, 0, 0, 0, .8, 0, 0, 0, .1, 0, 0, 0];
% State 6 actions 1:4 CANT GET HERE
P(6, 1).probs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
P(6, 2).probs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
P(6, 3).probs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
P(6, 4).probs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
% State 7 actions 1:4
P(7, 1).probs = [0, 0, 0, 0, 0, 0, .1, .1, 0, 0, .8, 0];
P(7, 2).probs = [0, 0, .1, 0, 0, 0, .8, 0, 0, 0, .1, 0];
P(7, 3).probs = [0, 0, .8, 0, 0, 0, .1, .1, 0, 0, 0, 0];
P(7, 4).probs = [0, 0, .1, 0, 0, 0, 0, .8, 0, 0, .1, 0];
% State 8 actions 1:4
P(8, 1).probs = [0, 0, 0, 0, 0, 0, .1, .1, 0, 0, 0, .8];
P(8, 2).probs = [0, 0, 0, .1, 0, 0, .8, 0, 0, 0, 0, .1];
P(8, 3).probs = [0, 0, 0, .8, 0, 0, .1, .1, 0, 0, 0, 0];
P(8, 4).probs = [0, 0, 0, .1, 0, 0, 0, .8, 0, 0, 0, .1];
% State 9 actions 1:4
P(9, 1).probs = [0, 0, 0, 0, 0, 0, 0, 0, .9, .1, 0, 0];
P(9, 2).probs = [0, 0, 0, 0, .1, 0, 0, 0, .9, 0, 0, 0];
P(9, 3).probs = [0, 0, 0, 0, .8, 0, 0, 0, .1, .1, 0, 0];
P(9, 4).probs = [0, 0, 0, 0, .1, 0, 0, 0, .1, .8, 0, 0];
% State 10 actions 1:4
P(10, 1).probs = [0, 0, 0, 0, 0, 0, 0, 0, .1, .8, .1, 0];
P(10, 2).probs = [0, 0, 0, 0, 0, 0, 0, 0, .8, .2, 0, 0];
P(10, 3).probs = [0, 0, 0, 0, 0, 0, 0, 0, .1, .8, .1, 0];
P(10, 4).probs = [0, 0, 0, 0, 0, 0, 0, 0, 0, .2, .8, 0];
% State 11 actions 1:4
P(11, 1).probs = [0, 0, 0, 0, 0, 0, 0, 0, 0, .1, .8, .1];
P(11, 2).probs = [0, 0, 0, 0, 0, 0, .1, 0, 0, .8, .1, 0];
P(11, 3).probs = [0, 0, 0, 0, 0, 0, .8, 0, 0, .1, 0, .1];
P(11, 4).probs = [0, 0, 0, 0, 0, 0, .1, 0, 0, 0, .1, .8];
% State 12 actions 1:4
P(12, 1).probs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, .1, .9];
P(12, 2).probs = [0, 0, 0, 0, 0, 0, 0, .1, 0, 0, .8, .1];
P(12, 3).probs = [0, 0, 0, 0, 0, 0, 0, .8, 0, 0, .1, .1];
P(12, 4).probs = [0, 0, 0, 0, 0, 0, 0, .1, 0, 0, 0, .9];

gamma = .999999;

[policy,U,Ut] = CS6380_MDP_policy_iteration(S,A,P,R,max_iter,gamma);
UtilityTracePlotter(Ut, 1:length(S));

end