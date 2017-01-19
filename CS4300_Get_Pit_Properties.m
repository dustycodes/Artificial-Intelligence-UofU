function bad_coordinates = CS4300_Get_Pit_Properties(breezes)
% CS4300_Get_Pit_Properties - Gets the coordinates that cannot contain pits
% On input:
%   breezes (4x4 Boolean array): presence of breeze percept at cell
%       -1: no knowledge
%       0: no breeze detected
%       1: breeze detected
% On output:
%   bad_coordinates (2xN matrix of x,y pairs): returns the x,y locations
%       cells that cannot contain pits
% Call:
%   bad_coordinates = CS4300_Get_Pit_Properties(ones(4,4)*-1);
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%
    bad_coordinates = [];
    for x = 1:4
       for y = 1:4
           c = x;
           r = 5-y;
           
           if breezes(r,c) == 0
               % We know there is not a breeze, so we add all neighbors to
               % the bad_coordinates if we don't know what is there already
               neighbors = CS4300_Get_Neighbors(x, y);
               rn = 1;
               cn = 1;
               while rn <= length(neighbors)
                    n_x = neighbors(rn,cn);
                    cn = cn + 1;
                    n_y = neighbors(rn,cn);
                    ROW = 5 - n_y;
                    COL = n_x;
                    
                    % We don't know what it is, could be a pit
                    if breezes(ROW,COL) == -1 || breezes(ROW,COL) == 1
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
