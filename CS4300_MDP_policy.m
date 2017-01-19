function policy = CS4300_MDP_policy(S,A,P,U)
% CS4300_MDP_policy - generate a policy from utilities
% See p. 648 Russell & Norvig
% On input:
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk array): transition model
%   U (vector): state utilities
% On output:
%   policy (vector): actions per state
% Call:
%   p = CS4300_MDP_policy(S,A,P,U);
% Author:
%   Dusty Argyle & Scott Hoge
%   UU
%   Fall 2016
%
for s = S
    
    % Foreach Action
    best_action = 1;
    best_val = -inf;
    for a = A
        % Foreach state
        val = 0;
        for s_prime = S
            val = val + P(s, a).probs(s_prime) * U(s_prime);
        end
        
        if best_val < val
            best_action = a;
            best_val = val;
        end
        
    end
    policy(s) = best_action;
end