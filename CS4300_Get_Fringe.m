function fringes = CS4300_Get_Fringe(x, y, visited_board)
% CS4300_Get_Fringe - Gets the accessible board locations
% On input:
%   x (integer): x coordinate 1..4
%   y (integer): y coordinate 1..4
%   visited_board (4x4): board of boolean values - 1 if visited, 0 if not
% On output:
%   fringes (2xN matrix of x,y pairs): returns the x,y locations of fringe
%       squares
% Call:
%   fringes = CS4300_Get_Fringe(1, 1, zeros(4));
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    fs = [];
    
    if x > 1
        fs = [fs; x-1, y];
    end
    if y > 1
        fs = [fs; x, y-1];
    end
    if y < 4
        fs = [fs; x, y+1];
    end
    if x < 4
        fs = [fs; x+1, y];
    end
    
    % Prioritize undiscovered fringes
    fringes = [];
    
    r = 1;
    c = 1;
    while r <= length(fs)
        x = fs(r,c);
        c = c + 1;
        y = fs(r,c);
        ROW = 5 - y;
        COL = x;
        
        if isequal(visited_board(ROW,COL), 0)
           fringes = [x,y; fringes];
        else
           fringes = [fringes; x,y];
        end


        
        r = r + 1;
        c = 1;
    end
    
%     for f = fs)
%         ROW = 5 - f(2);
%         COL = f(1);
%         if isequal(visited_board(ROW,COL), 0)
%            fringes = [f(1),f(2); fringes];
%         else
%            fringes = [fringes; f(1),f(2)];
%         end
%     end
end
