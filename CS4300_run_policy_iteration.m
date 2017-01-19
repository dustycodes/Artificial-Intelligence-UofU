function [S,A,R,P,U,Ut] = CS4300_run_policy_iteration(eta, max_iter)
% CS4300_MDP_policy_iteration - compute policy using policy iteration
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
%   [S,A,R,P,U,Ut] = CS4300_run_value_iteration(0.999999,1000)
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