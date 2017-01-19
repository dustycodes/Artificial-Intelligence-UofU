function negatedThm = CS4300_Negate(thm)
% CS4300_Negate - negates the CNF datastructure
% On input:
% thm (CNF datastructure): a disjunctive clause to be negated
% On output:
% thm (CNF datastructure): a set of disjunctive clauses from the negated
% theorem
% thm(1).clauses = [4];
% negatedThm = CS4300_Negate(thm);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    negatedThm = [];
    x = 1;
    for d = thm(1).clauses
        % swap thms sign
        neg_d = d * -1;
        negatedThm(x).clauses = [neg_d];
        x = x + 1;
    end
end