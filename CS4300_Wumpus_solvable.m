function b = CS4300_Wumpus_solvable(board)
% CS4300_Wumpus_solvable - test if a Wumpus board has a solution
% On input:
%     board (4x4 array): Wumpus board
%       0: empty cell
%       1: pit
%       2: gold
%       3: Wumpus
% On output:
%     b (Boolean): 1 if solution exists; else 0
% Call:
%     board = [0,1,2,0;1,0,0,0;0,0,1,1;0,0,0,0];
%     CS4300_Wumpus_solvable(board);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

b = 0;

PIT = 1;
GOLD = 2;
WUMPUS = 3;

[goal_row,goal_col] = find(board==GOLD);
if isempty(goal_row)
     error('Error in CS4300_WUMPUS_solvable: ---> No Gold on Board');
     return
end

board_sol = (board==0)|(board==GOLD);
board_sol_cc = bwlabel(board_sol,4);
if board_sol_cc(4,1)==board_sol_cc(goal_row,goal_col)
    b = 1;
end
