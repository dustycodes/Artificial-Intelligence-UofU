function D_revised = CS4300_AC1(G,D,P)
% CS4300_AC1 - AC1 function from Mackworth paper 1977
% On input:
% G (nxn array): neighborhood graph for n nodes
% D (nxm array): m domain values for each of n nodes
% P (string): predicate function name; P(i,a,j,b) takes as
% arguments:
% i (int): start node index
% a (int): start node domain value
% i (int): end node index
% i (int): end node domain value
% On output:
% D_revised (nxm array): revised domain labels
% Call:
% G = [0,0,0,0,0;0,0,0,0,0;1,1,0,1,1;0,0,0,0,0;0,0,0,1,0];
% D = [1,1,1;1,1,1;1,1,0;1,1,0;1,1,0];
% Dr = CS4300_AC1(G,D,?CS4300_P_Fig1?);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    queue = [];
    [n,m] = size(G);
    for x = 1:n
        for y = 1:m
            if (G(x, y) == 1)
                queue = [queue; x, y];
            end
        end
    end
    
    changed = 1;
    while changed == 1
        changed = 0;
        %while size(queue) > 0
        f = 1;
        [v,r] = size(queue);
        v = v + 1;
        while f < v
            %arc = [queue(1,1), queue(1,2)];
            arc = [queue(f,1), queue(f,2)];
            %queue(1,:) = [];
            [changed, D] = CS4300_Arc_Consistency_Revised(D, P, arc);
            f = f + 1;
        end
    end
    
    f = 1;
    [v,r] = size(queue);
    v = v + 1;
    while f < v
    	arc = [queue(f,1), queue(f,2)];
        [changed, D] = CS4300_Arc_Consistency_Revised(D, P, arc);
        f = f + 1;
    end
    
    D_revised = D;
end

