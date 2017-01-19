function bad_coordinates = CS4300_Get_Wumpus_Properties(stench)
% CS4300_Get_stench_Properties - Gets the coordinates that cannot contain
%   a Wumpus
% On input:
%   stench (4x4 Boolean array): presence of stench percept at cell
%       -1: no knowledge
%       0: no breeze detected
%       1: breeze detected
% On output:
%   bad_coordinates (2xN matrix of x,y pairs): returns the x,y locations
%       cells that cannot contain a wumpus
% Call:
%   bad_coordinates = CS4300_Get_Wumpus_Properties(ones(4,4)*-1);
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%
    bad_coordinates = [];
    
    [t,ty] = find(stench==-1);
    if length(t) == 1
            for x = 1:4
                for y = 1:4
                    if t == 5-y && ty == x
                        continue
                    end
                    bad_coordinates = [x, y; bad_coordinates];
                end
            end
            return;
    end
    
    for x = 1:4
       for y = 1:4
           c = x;
           r = 5-y;
           
           if stench(r,c) == 0
               % We know there is not a stench, so we add all neighbors to
               % the bad_coordinates
               neighbors = CS4300_Get_Neighbors(x, y);
               rn = 1;
               cn = 1;
               while rn <= length(neighbors)
                    n_x = neighbors(rn,cn);
                    cn = cn + 1;
                    n_y = neighbors(rn,cn);
                    ROW = 5 - n_y;
                    COL = n_x;
                    
                    % We don't know what it is, could be a wumpus
                    if stench(ROW,COL) == -1 || stench(ROW,COL) == 1
                        bad_coordinates = [n_x, n_y; bad_coordinates];
                    end

                    rn = rn + 1;
                    cn = 1;
               end
               bad_coordinates = [x, y; bad_coordinates];
           end
       end
    end
end