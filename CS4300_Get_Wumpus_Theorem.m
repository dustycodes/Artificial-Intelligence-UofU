function theorem = CS4300_Get_Wumpus_Theorem(x, y)
% CS4300_Get_Wumpus_Theorem - returns the theorem for asking if there is
%   wumpus at the position
% On input:
%   x(integer): x location on the board
%   y(integer): y location on the board
% On output:
%   theorem (integer): the agent's position theorem to ask old wumpy is there
% Call:  
%   theorem = CS4300_Get_Wumpus_Theorem(1, 2);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    offset = x + 4 * (y-1);
    WUMPUS_BASE = 0;
    theorem = WUMPUS_BASE + offset; 
end