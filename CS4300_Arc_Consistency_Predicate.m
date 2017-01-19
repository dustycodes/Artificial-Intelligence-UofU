function ok = CS4300_Arc_Consistency_Predicate(index1, label1, index2, label2)
% CS4300_Arc_Consistency_Predicate - Decides if 1 supports 2
% On input:
% index1 (int): start node index
% label1 (int): start node domain value
% index2 (int): end node index
% label2 (int): end node domain value
% On output:
% ok (1 or 0): 1 if the arc follows the rules, 0 if it fails
% Call:
% Author:
% Dusty Argyle
% UU
% Fall 2016
% 

    ok = 1;
    if label1 == label2
        ok = 0;
        return
    end
    
    r = abs(index1 - index2);
    c = abs(label1 - label2);
    
    if r == c
        ok = 0;
        return
    end
end