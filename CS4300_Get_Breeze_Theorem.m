function theorem = CS4300_Get_Breeze_Theorem(x, y)
% CS4300_Get_Breeze_Theorem - returns the theorem for asking if there is
%   pit at the position
% On input:
%   x(integer): x location on the board
%   y(integer): y location on the board
% On output:
%   theorem (integer): the agent's position theorem to ask if pit is there
% Call:  
%   theorem = CS4300_Get_Breeze_Theorem(1, 2);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    offset = x + 4 * (y-1);
    BREEZE_BASE = 64;
    theorem = BREEZE_BASE + offset; 
end