function CS4300_Completely_Contains_Test()
% CS4300_Completely_Contains - 
% On input:
% On output:
% CS4300_Completely_Contains_Test();
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    subset(1).clauses = [4];
    set(1).clauses = [4];
    contains = CS4300_Completely_Contains(subset, set);
    
    if contains ~= 1
        display('FAILURE');
    end
    
    subset(1).clauses = [4, 2, -1];
    set(1).clauses = [4];
    set(2).clauses = [4, 2, 1];
    set(3).clauses = [4, 2, -1];
    set(4).clauses = [2];
    contains = CS4300_Completely_Contains(subset, set);
    
    if contains ~= 1
        display('FAILURE');
    end
    
    subset(1).clauses = [4, 2, -1];
    set(1).clauses = [4];
    set(2).clauses = [4, 2, 1];
    set(3).clauses = [2];
    contains = CS4300_Completely_Contains(subset, set);
    
    if contains ~= 0
        display('FAILURE');
    end
end