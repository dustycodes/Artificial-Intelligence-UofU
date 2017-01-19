function [S,A,R,P,U,Ut] = CS6380_run_policy_iteration_Wumpus(eta, max_iter)
% CS6380_MDP_value_policy_Wumpus - compute policy using value iteration
% On input:
%   eta (float): termination threshold
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
%   [S,A,R,P,U,Ut] = CS6300_run_policy_iteration_Wumpus(0.999999,1000)
%
% U? =  0.7053 0.6553 0.6114 0.3879 0.7616 0 0.6600 -1.0000
%       0.8116 0.8678 0.9178 1.0000
%
%   Layout:             1
%   13 14 15 16                   ?
%   9  10 11 12          |
%   5  6  7  8      2 <- -> 4
%   1  2  3  4          |
%                       V
%                       3
% Author:
%   Dusty Argyle & Scott Hoge
%   UU
%   Fall 2016
S = [1:16];
A = [1:4];
R = -1*ones(16,1);
R(7) = -1000;
R(11) = -1000;
R(12) = -1000;
R(16) = 1000;

% State 1 actions 1:4
% State 1 actions 1:4
P(1, 1).probs = zeros(1,16);
P(1, 1).probs(2) = .1;
P(1, 1).probs(5) = .8;
P(1, 1).probs(1) = .1;

P(1, 2).probs = zeros(1,16);
P(1, 2).probs(1) = .9;
P(1, 2).probs(5) = .1;

P(1, 3).probs = zeros(1,16);
P(1, 3).probs(1) = .9;
P(1, 3).probs(2) = .1;

P(1, 4).probs = zeros(1,16);
P(1, 4).probs(1) = .1;
P(1, 4).probs(2) = .8;
P(1, 4).probs(5) = .1;

% State 2 actions 1:4
P(2, 1).probs = zeros(1,16);
P(2, 1).probs(1) = .1;
P(2, 1).probs(6) = .8;
P(2, 1).probs(3) = .1;

P(2, 2).probs = zeros(1,16);
P(2, 2).probs(1) = .8;
P(2, 2).probs(6) = .1;
P(2, 2).probs(2) = .1;

P(2, 3).probs = zeros(1,16);
P(2, 3).probs(1) = .1;
P(2, 3).probs(3) = .1;
P(2, 3).probs(2) = .8;

P(2, 4).probs = zeros(1,16);
P(2, 4).probs(6) = .1;
P(2, 4).probs(3) = .8;
P(2, 4).probs(2) = .1;

% State 3 actions 1:4
P(3, 1).probs = zeros(1,16);
P(3, 1).probs(2) = .1;
P(3, 1).probs(7) = .8;
P(3, 1).probs(4) = .1;

P(3, 2).probs = zeros(1,16);
P(3, 2).probs(2) = .8;
P(3, 2).probs(3) = .1;
P(3, 2).probs(7) = .1;

P(3, 3).probs = zeros(1,16);
P(3, 3).probs(4) = .1;
P(3, 3).probs(2) = .1;
P(3, 3).probs(3) = .8;

P(3, 4).probs = zeros(1,16);
P(3, 4).probs(7) = .1;
P(3, 4).probs(4) = .8;
P(3, 4).probs(3) = .1;

% State 4 actions 1:4
P(4, 1).probs = zeros(1,16);
P(4, 1).probs(4) = .1;
P(4, 1).probs(8) = .8;
P(4, 1).probs(3) = .1;

P(4, 2).probs = zeros(1,16);
P(4, 2).probs(3) = .8;
P(4, 2).probs(8) = .1;
P(4, 2).probs(4) = .1;

P(4, 3).probs = zeros(1,16);
P(4, 3).probs(3) = .1;
P(4, 3).probs(4) = .9;

P(4, 4).probs = zeros(1,16);
P(4, 4).probs(8) = .1;
P(4, 4).probs(4) = .9;

% State 5 actions 1:4
P(5, 1).probs = zeros(1,16);
P(5, 1).probs(5) = .1;
P(5, 1).probs(9) = .8;
P(5, 1).probs(6) = .1;

P(5, 2).probs = zeros(1,16);
P(5, 2).probs(5) = .8;
P(5, 2).probs(9) = .1;
P(5, 2).probs(1) = .1;

P(5, 3).probs = zeros(1,16);
P(5, 3).probs(5) = .1;
P(5, 3).probs(6) = .1;
P(5, 3).probs(1) = .8;

P(5, 4).probs = zeros(1,16);
P(5, 4).probs(9) = .1;
P(5, 4).probs(6) = .8;
P(5, 4).probs(1) = .1;

% State 6 actions 1:4
P(6, 1).probs = zeros(1,16);
P(6, 1).probs(5) = .1;
P(6, 1).probs(10) = .8;
P(6, 1).probs(7) = .1;

P(6, 2).probs = zeros(1,16);
P(6, 2).probs(5) = .8;
P(6, 2).probs(10) = .1;
P(6, 2).probs(2) = .1;

P(6, 3).probs = zeros(1,16);
P(6, 3).probs(5) = .1;
P(6, 3).probs(7) = .1;
P(6, 3).probs(2) = .8;

P(6, 4).probs = zeros(1,16);
P(6, 4).probs(10) = .1;
P(6, 4).probs(7) = .8;
P(6, 4).probs(2) = .1;

% State 7 actions 1:4
P(7, 1).probs = zeros(1,16);
P(7, 1).probs(6) = .1;
P(7, 1).probs(11) = .8;
P(7, 1).probs(8) = .1;

P(7, 2).probs = zeros(1,16);
P(7, 2).probs(6) = .8;
P(7, 2).probs(11) = .1;
P(7, 2).probs(3) = .1;

P(7, 3).probs = zeros(1,16);
P(7, 3).probs(6) = .1;
P(7, 3).probs(8) = .1;
P(7, 3).probs(3) = .8;

P(7, 4).probs = zeros(1,16);
P(7, 4).probs(11) = .1;
P(7, 4).probs(8) = .8;
P(7, 4).probs(3) = .1;

% State 8 actions 1:4
P(8, 1).probs = zeros(1,16);
P(8, 1).probs(8) = .1;
P(8, 1).probs(12) = .8;
P(8, 1).probs(7) = .1;

P(8, 2).probs = zeros(1,16);
P(8, 2).probs(7) = .8;
P(8, 2).probs(12) = .1;
P(8, 2).probs(4) = .1;

P(8, 3).probs = zeros(1,16);
P(8, 3).probs(8) = .1;
P(8, 3).probs(7) = .1;
P(8, 3).probs(4) = .8;

P(8, 4).probs = zeros(1,16);
P(8, 4).probs(12) = .1;
P(8, 4).probs(8) = .8;
P(8, 4).probs(4) = .1;

% State 9 actions 1:4
P(9, 1).probs = zeros(1,16);
P(9, 1).probs(9) = .1;
P(9, 1).probs(10) = .1;
P(9, 1).probs(13) = .8;

P(9, 2).probs = zeros(1,16);
P(9, 2).probs(9) = .8;
P(9, 2).probs(13) = .1;
P(9, 2).probs(5) = .1;

P(9, 3).probs = zeros(1,16);
P(9, 3).probs(10) = .1;
P(9, 3).probs(9) = .1;
P(9, 3).probs(5) = .8;

P(9, 4).probs = zeros(1,16);
P(9, 4).probs(13) = .1;
P(9, 4).probs(10) = .8;
P(9, 4).probs(5) = .1;

% State 10 actions 1:4
P(10, 1).probs = zeros(1,16);
P(10, 1).probs(9) = .1;
P(10, 1).probs(11) = .1;
P(10, 1).probs(14) = .8;

P(10, 2).probs = zeros(1,16);
P(10, 2).probs(9) = .8;
P(10, 2).probs(14) = .1;
P(10, 2).probs(6) = .1;

P(10, 3).probs = zeros(1,16);
P(10, 3).probs(11) = .1;
P(10, 3).probs(9) = .1;
P(10, 3).probs(6) = .8;

P(10, 4).probs = zeros(1,16);
P(10, 4).probs(6) = .1;
P(10, 4).probs(11) = .8;
P(10, 4).probs(14) = .1;

% State 11 actions 1:4
P(11, 1).probs = zeros(1,16);
P(11, 2).probs = zeros(1,16);
P(11, 3).probs = zeros(1,16);
P(11, 4).probs = zeros(1,16);

% State 12 actions 1:4
P(12, 1).probs = zeros(1,16);
P(12, 2).probs = zeros(1,16);
P(12, 3).probs = zeros(1,16);
P(12, 4).probs = zeros(1,16);

% State 13 actions 1:4
P(13, 1).probs = zeros(1,16);
P(13, 1).probs(13) = .9;
P(13, 1).probs(14) = .1;

P(13, 2).probs = zeros(1,16);
P(13, 2).probs(13) = .9;
P(13, 2).probs(14) = .1;

P(13, 3).probs = zeros(1,16);
P(13, 3).probs(13) = .1;
P(13, 3).probs(9) = .8;
P(13, 3).probs(14) = .1;

P(13, 4).probs = zeros(1,16);
P(13, 4).probs(13) = .1;
P(13, 4).probs(9) = .1;
P(13, 4).probs(14) = .8;

% State 14 actions 1:4
P(14, 1).probs = zeros(1,16);
P(14, 1).probs(13) = .1;
P(14, 1).probs(15) = .1;
P(14, 1).probs(14) = .8;

P(14, 2).probs = zeros(1,16);
P(14, 2).probs(13) = .8;
P(14, 2).probs(14) = .1;
P(14, 2).probs(10) = .1;

P(14, 3).probs = zeros(1,16);
P(14, 3).probs(13) = .1;
P(14, 3).probs(15) = .1;
P(14, 3).probs(10) = .8;

P(14, 4).probs = zeros(1,16);
P(14, 4).probs(14) = .1;
P(14, 4).probs(15) = .8;
P(14, 4).probs(10) = .1;

% State 15 actions 1:4
P(15, 1).probs = zeros(1,16);
P(15, 1).probs(16) = .1;
P(15, 1).probs(14) = .1;
P(15, 1).probs(15) = .9;

P(15, 2).probs = zeros(1,16);
P(15, 2).probs(15) = .8;
P(15, 2).probs(11) = .1;
P(15, 2).probs(14) = .1;

P(15, 3).probs = zeros(1,16);
P(15, 3).probs(14) = .1;
P(15, 3).probs(16) = .1;
P(15, 3).probs(11) = .8;

P(15, 4).probs = zeros(1,16);
P(15, 4).probs(15) = .1;
P(15, 4).probs(16) = .8;
P(15, 4).probs(11) = .1;

% State 16 actions 1:4
P(16, 1).probs = zeros(1,16);
P(16, 2).probs = zeros(1,16);
P(16, 3).probs = zeros(1,16);
P(16, 4).probs = zeros(1,16);

%P(1,1).probs =
gamma = .999999;

[policy,U,Ut] = CS6380_MDP_policy_iteration(S,A,P,R,max_iter,gamma);
UtilityTracePlotter(Ut, 1:length(S));


