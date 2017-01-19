function D_revised = CS4300_AC3(G,D,P)
% CS4300_AC3 - AC3 function from Mackworth paper 1977
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
% G = 1 - eye(3, 3);
% D = [1,1,1;1,1,1;1,1,1];
% Dr = CS4300_AC3(G, D, 'CS4300_Arc_Consistency_Predicate');
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
    
    while ~isempty(queue)
        arc = [queue(1,1), queue(1,2)];
        queue = queue(2:end, :);
        
        [changed, D] = CS4300_Arc_Consistency_Revised(D, P, arc);
        if changed == 1
            if isempty(D)
                return
            else
                i = arc(1);
                for k = 1:n
                    if G(k,i) == 1
                        queue = [queue; k, i];
                    end
                end
            end
        end
    end
    
    D_revised = D;
end
