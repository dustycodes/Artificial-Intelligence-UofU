function board = CS4300_gen_board_A1(p)
% CS4300_gen_board_A1 - generate a Wumpus board
% On input:
%     p (float): number of pits in room
% On output:
%     board (4x4 int array): Wumpus board
%       0: nothing in room
%       1: pit in room
%       2: gold in room
%       3: Wupmus in room
% Call:
%     b = CS4300_gen_board_A1(2);
% Author:
%     T. Henderson
%     UU
%     Summer 2015
%

PIT = 1;
GOLD = 2;
WUMPUS = 3;

locs = [1,1;2,1;3,1;4,1;...
    1,2;2,2;3,2;4,2;...
    1,3;2,3;3,3;4,3;...
    1,4;2,4;3,4;4,4];

board = zeros(4,4);
r_locs = randperm(16);
for c = 1:p
    board(locs(r_locs(c),1),locs(r_locs(c),2)) = PIT;
end
board(locs(r_locs(p+1),1),locs(r_locs(p+1),2)) = GOLD;
board(locs(r_locs(p+2),1),locs(r_locs(p+2),2)) = WUMPUS;
