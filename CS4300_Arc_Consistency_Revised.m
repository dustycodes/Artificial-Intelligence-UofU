function [changed, D] = CS4300_Arc_Consistency_Revised(D, P, arc)
% CS4300_Arc_Consistency_Revised - Checks the domain if the arc is
% consistent. Returns the revised domain and if the domain was revised.
% On input:
% D (nxm array): m domain values for each of n nodes
% P (string): predicate function name; P(i,a,j,b) takes as
% arc (2x1 vector): x, y component of the arc we are checking
% On output:
% changed (1 or 0): 1 if the domain was revised, otherwise 0
% D (nxm array): revised m domain values for each of n nodes
% Call: 
% D = [0,0,0;1,0,1;1,0,0];
% P = 'CS4300_Arc_Consistency_Predicate';
% arc = [1, 2];
% [changed, D] = CS4300_Arc_Consistency_Revised(D, P, arc)
% Author:
% Dusty Argyle
% UU
% Fall 2016
% 
    [N,M] = size(D);
    node1 = arc(1);
    node2 = arc(2);
    changed = 0;
    
    ok = 0;
    for label1 = 1:N
        counter = N;
        if D(node1, label1) == 1
            for label2 = 1:N
                if D(node2,label2) == 1
                    ok = feval(P, node1, label1, node2, label2);
                    if ok == 1
                        break
                    else
                        counter = counter - 1;
                    end
                else
                    counter = counter - 1;
                end
            end
        end
        if counter == 0
            D(node1, label1) = 0;
            changed = 1;
        end
    end
end