function [policy,U,Ut] = CS6380_MDP_policy_iteration(S,A,P,R,k,gamma)
% CS4300_MDP_policy_iteration - policy iteration
% Chapter 17 Russell and Norvig (Table p. 657)
% On input:
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk array): transition model
%   R (vector): state rewards
%   k (int): number of iterations
%   gamma (float): discount factor
% On output:
%   p (nx1 vector): policy
% Call:
%
%   Layout:            1
%                      ?
%   9 10 11 12         |
%   5  6  7  8    2  <- -> 4
%   1  2  3  4         |
%                      V
%                      3
%   [S,A,R,P,U,Ut] = CS4300_run_value_iteration(0.999999,1000);
%   p = CS4300_MDP_policy_iteration(S,A,P,R,10,0.999)
%   p?
%
%   ans =
%
%   1       corrresponds to:
%   2
%   2           ->  -> -> X
%   2           ?   X  ?  X
%   1           ?  <- <- <-
%   1
%   1
%   1
%   4
%   4
%   4
%   1
%
% Author:
%   Dusty Argyle & Scott Hoge
%   UU
%   Fall 2016
%

m = median(R);
U = (R~=m).*R;
Ut = [];

% Select random actions
policy = randi(length(A),1,length(S));
r = 1;
while true
    Ut = [Ut;U'];
    
    % Evaluate the policy
    for step = 1:k
        for s = S
            if R(s) == m
                % Foreach state
                val = 0;
                for s_prime = S
                    val = val + P(s, policy(s)).probs(s_prime)*U(s_prime);
                    r = r + 1;
                end
                U(s) = R(s) + gamma * val;
            end
        end
    end
    
    unchanged = true;
    % Foreach state
    for s = S   
        if R(s) == m
        
            % Foreach Action
            best_action = 1;
            best_val = 0;
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
            
            if best_action ~= policy(s)
                policy(s) = best_action;
                unchanged = false;
            end
        else
            % TODO: Can we scrub states that are predetermined? ie) 6, 8, 12
            policy(s) = 1;
        end
    end
    
    
    if unchanged == true
        break;
    end
end

