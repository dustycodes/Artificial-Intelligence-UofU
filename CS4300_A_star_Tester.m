function [goalStates, option1Nodes, option2Nodes] = CS4300_A_star_Tester()
%CS4300_h_function A heuristic function for Wumpus World
% On input:
%    No input.
% On output:
%   outputArray (16x1 vector): contains the information for the 16
%   different board states
%       goalState (int): Gold Location enumerated 1:16 from the origin
%                        moving right then up. i.e. 1 = [1,1] 15 = [3,4]
%       Option1Nodes (int): Number of nodes returned using option1
%       Option2Nodes (int): Number of nodes returned using option2
% Call:
%   outputArray = CS4300_A_star_Tester()
% Author:
% Scott Hoge
% UU
% Fall 2016
%
    goalStates = [];
    option1Nodes = [];
    option2Nodes = [];

    
    for it = 1:16
       %generate boards
       switch it
           case 1
               board = [2,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
               goal_state(1) = 1;
               goal_state(2) = 1;
           case 2
               board = [0,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
               goal_state(1) = 2;
               goal_state(2) = 1;
           case 3
               board = [0,0,2,0;0,0,0,0;0,0,0,0;0,0,0,0];
               goal_state(1) = 3;
               goal_state(2) = 1;
           case 4
               board = [0,0,0,2;0,0,0,0;0,0,0,0;0,0,0,0];
               goal_state(1) = 4;
               goal_state(2) = 1;
           case 5
               board = [0,0,0,0;2,0,0,0;0,0,0,0;0,0,0,0];
               goal_state(1) = 1;
               goal_state(2) = 2;
           case 6
               board = [0,0,0,0;0,2,0,0;0,0,0,0;0,0,0,0];
               goal_state(1) = 2;
               goal_state(2) = 2;
           case 7
               board = [0,0,0,0;0,0,2,0;0,0,0,0;0,0,0,0];
               goal_state(1) = 3;
               goal_state(2) = 2;
           case 8
               board = [0,0,0,0;0,0,0,2;0,0,0,0;0,0,0,0];
               goal_state(1) = 4;
               goal_state(2) = 2;
           case 9
               board = [0,0,0,0;0,0,0,0;2,0,0,0;0,0,0,0];
               goal_state(1) = 1;
               goal_state(2) = 3;
           case 10
               board = [0,0,0,0;0,0,0,0;0,2,0,0;0,0,0,0];
               goal_state(1) = 2;
               goal_state(2) = 3;
           case 11
               board = [0,0,0,0;0,0,0,0;0,0,2,0;0,0,0,0];
               goal_state(1) = 3;
               goal_state(2) = 3;
           case 12
               board = [0,0,0,0;0,0,0,0;0,0,0,2;0,0,0,0];
               goal_state(1) = 4;
               goal_state(2) = 3;
           case 13
               board = [0,0,0,0;0,0,0,0;0,0,0,0;2,0,0,0];
               goal_state(1) = 1;
               goal_state(2) = 4;
           case 14
               board = [0,0,0,0;0,0,0,0;0,0,0,0;0,2,0,0];
               goal_state(1) = 2;
               goal_state(2) = 4;
           case 15
               board = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,2,0];
               goal_state(1) = 3;
               goal_state(2) = 4;
           case 16
               board = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,2];
               goal_state(1) = 4;
               goal_state(2) = 4;
       end
       
        [so1,no1] = CS4300_Wumpus_A_star1(board,[1,1,0],goal_state,'CS4300_A_star_Man',1);
        [so2,no2] = CS4300_Wumpus_A_star1(board,[1,1,0],goal_state,'CS4300_A_star_Man',2);       
        option1Nodes(it) = length(no1);
        option2Nodes(it) = length(no2);
        goalStates(it) = it;
    end
    
end

