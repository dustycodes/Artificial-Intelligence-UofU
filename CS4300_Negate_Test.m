function CS4300_Negate_Test()
% CS4300_Negate_Test - Check if negate works
% On input:
% On output:
% CS4300_Negate_test;
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    thm(1).clauses = [4];
    negatedThm = CS4300_Negate(thm);
    
    if negatedThm.clauses ~= [-4]
       disp('FAILURE'); 
    end
    
    thm(1).clauses = [4, -1, 3];
    negatedThm = CS4300_Negate(thm);
    answer(1).clauses = [-4];
    answer(2).clauses = [1];
    answer(3).clauses = [-3];
    
    f = 1;
    for r = negatedThm
        if answer(f).clauses ~= r.clauses
            disp('Failure');
            return
        end
        f = f + 1;
    end

end