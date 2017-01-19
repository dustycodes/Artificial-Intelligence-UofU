function resolvents = CS4300_Resolve(clause1, clause2)
% CS4300_Resolve - Tests the clauses and return the resolvents
% On input:
%   clause1 (CNF datastructure): a disjunctive clause to be tested against
%   clause2 (CNF datastructure): a disjunctive clause to be tested against
% On output:
%   resolvents (an array of CNF datastructures): the 
% call:
%   clause1.clauses = [1, 2];
%   clause2.clauses = [-1];
%   resolvents = CS4300_Resolve(clause1, clause2);
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%
    resolvents = [];
    y = 1;
    for literal1 = clause1.clauses
       x = 1;
       for literal2 = clause2.clauses
           if literal1 == (literal2*(-1))
               temp1 = clause1;
               temp2 = clause2;
               
               r = size(temp1.clauses);
               f = size(temp2.clauses);
               if r(1) == 1 && r(2) == 1
                    temp1 = [];
               else
                    temp1.clauses(y) = [];
               end
               if f(1) == 1 && f(2) == 1
                    temp2 = [];
               else
                    temp2.clauses(x) = [];
               end
               resolvents = [resolvents; CS4300_Union(temp1, temp2)];
               if isempty(resolvents)
                   resolvents(1).clauses = [];
               end
           end
           x = x + 1;
       end
       y = y + 1;
    end
end