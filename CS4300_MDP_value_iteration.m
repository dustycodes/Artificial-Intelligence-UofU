function [U,U_trace] = CS4300_MDP_value_iteration(S,A,P,R,gamma,eta,max_iter)
% CS4300_MDP_value_iteration - compute policy using value iteration
% On input:
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk struct array): transition model
%       (s,a).probs (a vector with n transition probabilities from s to 
%           s_prime, given action a)
%   R (vector): state rewards
%   gamma (float): discount factor
%   eta (float): termination threshold
%   max_iter (int): max number of iterations
% On output:
%   U (vector): state utilities
%   U_trace (iterxn): trace of utility values during iteration
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
    m = median(R);
    U = (R~=m).*R;
    
    U_prime = U;
    U_trace = [];
    
    iter = 0;
    while true
        U_trace = [U_trace;U'];
        U = U_prime;
        delta = 0;
        
        
        % Foreach state
        for s = S
            % change only if median
            if R(s) == m
                best_action = 0;
                best_val = -inf;
                % Foreach Action
                for a = A
                    a_val = dot(P(s, a).probs', U);
                    if a_val > best_val
                        best_val = a_val;
                        best_action = a;
                    end
                end
                
                U_prime(s) = R(s) + gamma * best_val;
                delta = max(delta, abs(U_prime(s) - U(s)));
            end
        end
        
        if delta < eta*(1 - gamma)/gamma
            break;
        elseif iter > max_iter
            break;
        end
        iter = iter + 1;
    end
    
    U_s = U;
    U_t = U_trace;
end
