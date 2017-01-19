function [mean1, mean2, var1, var2, ci1, ci2] = CS4300_A_star_Test(trials)
%CS4300_h_function A heuristic function for Wumpus World
% On input:
%   trials (int): The number of trials
% On output:
%   mean1 (float): mean of the number of nodes returned using option1
%   mean2 (float): mean of the number of nodes returned using option2
%   var1 (float): variance of the number of nodes returned using option1
%   var2 (float): variance of the number of nodes returned using option2
%   ci1 (1x2 vector): confidence interval of using option 1, index 1 is
%                     is the lower bound
%   ci2 (1x2 vector): confidence interval of using option 2, index 1 is
%                     is the lower bound
% Call:
%   [mean1,mean2,var1,var2,ci1,ci2] = CS4300_A_star_Test(2000)
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    number_of_nodes1 = [];
    solutions1 = 0;
    number_of_nodes2 = [];
    solutions2 = 0;
    
    for it = 1:trials
        
        found = false;
        goal_state = zeros(1,3);
        while found == false
            board = CS4300_gen_board(.20);
            for x = 1:4
                for y = 1:4
                    if board(x,y) == 3
                        goal_state(1) = x;
                        goal_state(2) = y;
                        found = true;
                        break;
                    end
                end
                if found == true
                   break; 
                end
            end
        end
        
        
        [so1,no1] = CS4300_Wumpus_A_star1(board,[1,1,0],goal_state,'CS4300_A_star_Man',1);
        [so2,no2] = CS4300_Wumpus_A_star1(board,[1,1,0],goal_state,'CS4300_A_star_Man',2);
        if length(so1)
            solutions1 = solutions1 + 1;
        end
        if length(so2)
            solutions2 = solutions2 + 1;
        end
        
        number_of_nodes1 = [number_of_nodes1, length(no1)];
        number_of_nodes2 = [number_of_nodes2, length(no2)];
    end
    mean1 = mean(number_of_nodes1);
    mean2 = mean(number_of_nodes2);
    var1 = var(number_of_nodes1);
    var2 = var(number_of_nodes2);
    ci1 = zeros(1,2);
    ci1(1) = mean1 - 1.645*sqrt(var1/trials);
    ci1(2) = mean1 + 1.645*sqrt(var1/trials);
    ci2 = zeros(1,2);
    ci2(1) = mean2 - 1.645*sqrt(var2/trials);
    ci2(2) = mean2 + 1.645*sqrt(var2/trials);
    
    % The percentage of boards that were able to be solved
    solved = solutions1/trials
end

