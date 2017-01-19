function [pits,Wumpus] = CS4300_WP_estimates(breezes,stench,num_trials)
% CS4300_WP_estimates - estimate pit and Wumpus likelihoods
% On input:
%   breezes (4x4 Boolean array): presence of breeze percept at cell
%       -1: no knowledge
%       0: no breeze detected
%       1: breeze detected
%   stench (4x4 Boolean array): presence of stench in cell
%       -1: no knowledge
%       0: no stench detected
%       1: stench detected
%   num_trials (int): number of trials to run (subset will be OK)
% On output:
%   pits (4x4 [0,1] array): likelihood of pit in cell
%   Wumpus (4x4 [0 to 1] array): likelihood of Wumpus in cell
% Call:
%   breezes = -ones(4,4);
%   breezes(4,1) = 1;
%   stench = -ones(4,4);
%   stench(4,1) = 0;
%   [pts,Wumpus] = CS4300_WP_estimates(breezes,stench,10000)
%   pts =
%       0.2021 0.1967 0.1956 0.1953
%       0.1972 0.1999 0.2016 0.1980
%       0.5527 0.1969 0.1989 0.2119
%       0      0.5552 0.1948 0.1839
%
%   Wumpus =
%       0.0806  0.0800  0.0827  0.0720
%       0.0780  0.0738  0.0723  0.0717
%       0       0.0845  0.0685  0.0803
%       0       0       0.0741  0.0812
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%
pit_probability = .2;
pits = zeros(4,4);
Wumpus = zeros(4,4);
bad_pit_coordinates = CS4300_Get_Pit_Properties(breezes);
bad_wumpus_coordinates = CS4300_Get_Wumpus_Properties(stench);

[a,b] = find(stench~=0);
killed = 0;
if length(a) == 0
    killed = 1;
end


total = 0;
while total < num_trials
    %       0: nothing in room
    %       1: pit in room
    %       2: gold in room
    %       3: Wupmus in room
    %       4: both gold and Wumpus in room
    b = CS4300_gen_board(pit_probability);
    good_board = 1;
    
    
    for x = 1:4
        for y = 1:4
            col = x;
            row = 5-y;
            
            if isequal(b(row,col), 3) || isequal(b(row,col), 4)
                
                if ~killed
                    % Check if b contains a wumpus @ x,y and shouldn't
                    r = 1;
                    c = 1;
                    [m,n] = size(bad_wumpus_coordinates);
                    while r <= m
                        b_x = bad_wumpus_coordinates(r,c);
                        c = c + 1;
                        b_y = bad_wumpus_coordinates(r,c);
                        
                        if (isequal(x, b_x) && isequal(y, b_y))
                            good_board = 0;
                            break;
                        end
                        
                        r = r + 1;
                        c = 1;
                    end
                end
            elseif isequal(b(row,col), 1) && good_board
                % Check if b contains a pit @ x,y and shouldn't
                r = 1;
                c = 1;
                [m,n] = size(bad_pit_coordinates);
                while r <= m
                    b_x = bad_pit_coordinates(r,c);
                    c = c + 1;
                    b_y = bad_pit_coordinates(r,c);
                    
                    if (isequal(x, b_x) && isequal(y, b_y))
                        good_board = 0;
                        break;
                    end
                    
                    r = r + 1;
                    c = 1;
                end
            end
            
            if ~good_board
                break;
            end
            
        end
        
        if ~good_board
            break;
        end
    end
    
    if ~good_board
        continue;
    end
    
    for x = 1:4
        for y = 1:4
            col = x;
            row = 5-y;
            
            % Add a wumpus probability
            if b(row,col) == 3 || b(row,col) == 4
                Wumpus(row,col) = Wumpus(row,col) + 1;
            elseif b(row,col) == 1
                pits(row,col) = pits(row,col) + 1;
            end
        end
    end
    
    total = total + 1;
end

if ~killed
    Wumpus = Wumpus/num_trials;
else
	Wumpus = zeros(4,4);
end

pits = pits/num_trials;
end