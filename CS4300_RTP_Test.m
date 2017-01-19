function CS4300_RTP_Test()
% CS4300_RTP_Test - Setup for testing the RTP functionality
% On input:
% 
% On output:
% 
% CS4300_RTP_Test();
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    % Test 1: Class example
    DP(1).clauses = [-1,2,3,4];
    DP(2).clauses = [-2];
    DP(3).clauses = [-3];
    DP(4).clauses = [1];
    thm(1).clauses = [4];
    vars = [1,2,3,4];
    
    Sr = CS4300_RTP(DP, thm, vars);
    if ~isempty(Sr)
        disp('FAILURE');
    end
    
    % Test 2: Quiz Example
    DP(1).clauses = [1,2,3];
    DP(2).clauses = [-1];
    DP(3).clauses = [1,-2];
    DP(4).clauses = [-3,4];
    thm(1).clauses = [4];
    vars = [1,2,3,4];
    
    Sr = CS4300_RTP(DP, thm, vars);
    if ~isempty(Sr)
        disp('FAILURE');
    end
    
    % Test3: a V ~a tautology
    DP3 = [];
    thm(1).clauses = [1, -1];
    vars = [1];
    
    Sr = CS4300_RTP(DP3, thm, vars);
    if ~isempty(Sr)
        disp('FAILURE');
    end
    
    % Test4: 
    DP3 = [];
    thm(1).clauses = [1, -1];
    vars = [1];
    
    Sr = CS4300_RTP(DP3, thm, vars);
    if ~isempty(Sr)
        disp('FAILURE');
    end
    
    % Test5: 
    DP5(1).clauses = [-1];
    thm1(1).clauses = [1];
    Sr = CS4300_RTP(DP5, thm1, vars);
    if isempty(Sr)
       disp('FAILURE'); 
    end
    
    % Test 6: large test
    vars = [1,2,3,4, 6, 7, 8];
    DP6(1).clauses = [-1, 2];
    DP6(1).clauses = [-1, 3];
    DP6(1).clauses = [4, 2];
    DP6(1).clauses = [1, 8];
    DP6(1).clauses = [-1, 4];
    DP6(1).clauses = [2, 7];
    DP6(1).clauses = [-1, -7];
    DP6(1).clauses = [5];
    DP6(1).clauses = [-6, 2];
    DP6(1).clauses = [-6, 5];
    thm6(1).clauses = [2];
    Sr = CS4300_RTP(DP6, thm6, vars);
    if isempty(Sr)
       disp('FAILURE'); 
    end
    
    KB(1).clauses = [-1];
    KB(2).clauses = [-17];
    KB(3).clauses = [-33];
    KB(4).clauses = [-49];
    KB(5).clauses = [-65];
    KB(6).clauses = [-18];
    KB(7).clauses = [-21];
    KB(8).clauses = [-69];
    KB(9).clauses = [-66];
    thm7(1).clauses = [70];
    
    Sr = CS4300_RTP(KB, thm7, vars);
    if isempty(Sr)
       disp('FAILURE'); 
    end
end