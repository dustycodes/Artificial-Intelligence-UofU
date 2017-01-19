function CS4300_Union_Test()
% CS4300_Union_Test - Tests the union function
% On input:
% On output:
% negatedThm = CS4300_Union_Test(thm);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    current_new(1).clauses = [4];
    current_new(2).clauses = [4,2];
    current_new(3).clauses = [1,-3];
    resolvents(1).clauses = [4];
    resolvents(2).clauses = [4,3];
    resolvents(3).clauses = [-6];
    unioned_new = CS4300_Union(current_new, resolvents);
    m = size(unioned_new);
    
    ind = m(2);
    if ind ~= 5
       disp('FAILURE');
    end
    
end