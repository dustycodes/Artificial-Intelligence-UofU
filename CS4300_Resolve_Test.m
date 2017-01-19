function CS4300_Resolve_Test()
% CS4300_Resolve - Tests the clauses and return the resolvents
% On input:
% On output:
% call:
% CS4300_Resolve_Test();
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    clause1.clauses = [1, 2];
    clause2.clauses = [-1];
    resolvents = CS4300_Resolve(clause1, clause2);
    if resolvents(1).clauses ~= 2
        disp('FAILURE');
    end
    
    clause3.clauses = [1,2,3];
    clause4.clauses = [-2];
    resolvents = CS4300_Resolve(clause3, clause4);
    if resolvents(1).clauses ~= [1,3]
        disp('FAILURE');
    end
    
    clause3.clauses = [-1,2,1];
    clause4.clauses = [3];
    resolvents = CS4300_Resolve(clause3, clause4);
    if ~isempty(resolvents)
        disp('FAILURE');
    end
    
    clause3.clauses = [1];
    clause4.clauses = [3];
    resolvents = CS4300_Resolve(clause3, clause4);
    if ~isempty(resolvents)
        disp('FAILURE');
    end
    
end