function unioned_new = CS4300_Union(current_new, resolvents)
% CS4300_Union - Does a union of the new and resolvents, then returns the
% set
% On input:
% current_new (CNF datastructure): a set of disjunctive clauses
% resolvents (CNF datastructure): a set of disjunctive clauses
% On output:
% unioned_new (CNF datastructure): the union of the two inputs
% current_new(1).clauses = [4];
% current_new(2).clauses = [4,2];
% current_new(3).clauses = [1,-3];
% resolvents(1).clauses = [4];
% resolvents(2).clauses = [4,3];
% resolvents(3).clauses = [-6];
% unioned_new = CS4300_Union(current_new, resolvents);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    m = size(current_new);
    n = size(resolvents);
    if m(2) == 0
        unioned_new = resolvents;
        return
    elseif n(2) == 0
        unioned_new = current_new;
        return
    end
    
    unioned_new = current_new;
    
    for x = resolvents
        contains = 0;
        
        for y = unioned_new
            if isequal(y.clauses, x.clauses)
                contains = 1;
            end
        end
        
        if contains == 0
            m = size(unioned_new);
            ind = m(2)+1;
            unioned_new(ind).clauses = x.clauses;
        end
    end
end