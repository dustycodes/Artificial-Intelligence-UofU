function contains = CS4300_Completely_Contains(subset, set)
% CS4300_Union - Does a union of the new and resolvents, then returns the
% set
% On input:
%   subset (CNF datastructure): a disjunctive clause that will be unioned
%       with set
%   set (CNF datastructure): a disjunctive clause that will be unioned with
%       subset
% On output:
%   contains: 1 if subset is completely contained, 0 otherwise
% Call:
%   subset(1).clauses = [4];
%   set(1).clauses = [4];
%   contains = CS4300_Completely_Contains(subset, set);
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%
    contains = 1;
    for x = subset
        contains = 0;
        
        for y = set
            if isequal(y.clauses, x.clauses)
                contains = 1;
                break;
            end
        end
        
        if contains == 0
            return
        end
    end
end