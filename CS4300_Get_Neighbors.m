function neighbors = CS4300_Get_Neighbors(x, y)
% CS4300_Get_Neighbors - Gets the accessible board locations
% On input:
%   x (integer): x coordinate 1..4
%   y (integer): y coordinate 1..4
% On output:
%   neighbors (2xN matrix of x,y pairs): returns the x,y locations of fringe
%       squares
% Call:
%   neighbors = CS4300_Get_Neighbors(1, 1);
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%
    neighbors = [];
    
    if x > 1
        neighbors = [neighbors; x-1, y];
    end
    if y > 1
        neighbors = [neighbors; x, y-1];
    end
    if y < 4
        neighbors = [neighbors; x, y+1];
    end
    if x < 4
        neighbors = [neighbors; x+1, y];
    end 
end
