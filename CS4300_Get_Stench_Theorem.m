function theorem = CS4300_Get_Stench_Theorem(x, y)
% CS4300_Get_Stench_Theorem - returns the theorem for asking if there is
%   stench at the position
% On input:
%   x(integer): x location on the board
%   y(integer): y location on the board
% On output:
%   theorem (integer): the agent's position theorem to ask if it is stinky
% Call:  
%   theorem = CS4300_Get_Stench_Theorem(1, 2);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    offset = x + 4 * (y-1);
    STENCH_BASE = 48;
    theorem = STENCH_BASE + offset; 
end