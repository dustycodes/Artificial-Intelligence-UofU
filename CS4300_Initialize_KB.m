function KB = CS4300_Initialize_KB()
% CS4300_Initialize_KB - Initialized KB with rules
% On input:
%   None
% On output:
%   KB (Custom Data Structure): knowledge of the wumpus world state.
%       KB.sentences (CNF data structure): array of conjuctive clauses
%           KB.sentences(i).clauses each clause is a list of integers (- for negated literal)
%       KB.agent (agent data structure): agent current state - x, y, dir
%       KB.visited_board (4x4 array): board of boolean values for the
%           visited status.
%       KB.gold_board (4x4 array): board of integer values for the
%           gold status (-1 is unknown) (0 is no) (1 is yes).
%       KB.pit_board (4x4 array): board of integer values for the
%           pit status (-1 is unknown) (0 is no) (1 is yes).
%       KB.wumpus_board (4x4 array): board of integer values for the
%           wumpus status (-1 is unknown) (0 is no) (1 is yes).
%       KB.safe_board (4x4 array): board of integer values for the
%           safe status (-1 is unknown) (0 is no) (1 is yes).
%       KB.action (integer): The last action of the agent, initially null
%       KB.plan (Array of integers): an action sequence, initially empty
%       KB.board (4x4 int array): Wumpus board layot
%           0: means empty cell
%           1: means a pit in cell
%           2: means gold (only) in cell
%           3: means Wumpus (only) in cell
%           4: means gold and Wumpus in cell
% Call:
%   KB = CS4300_Initialize_KB();
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    KB.agent.x = 1;
    KB.agent.y = 1;
    KB.agent.alive = 1;
    KB.agent.gold = 0; % grabbed gold in same room
    KB.agent.dir = 0; % facing right
    KB.agent.succeed = 0; % has gold and climbed out
    KB.agent.climbed = 0; % climbed out
    
    KB.visted_board = zeros(4);
    
    KB.plan = [];
    KB.action = [];
    
    KB.sentences(1).clauses = [-1*CS4300_Get_Pit_Theorem(1,1)];
    KB.sentences(2).clauses = [-1*CS4300_Get_Wumpus_Theorem(1,1)];
    
    % Generate the rules
    for x = 1:3
        for y = 1:3
            fringes = CS4300_Get_Fringe(x, y, zeros(4));
            breeze_thm = CS4300_Get_Breeze_Theorem(x, y);
            stench_thm = CS4300_Get_Stench_Theorem(x, y);
            
            bthm = [-1*breeze_thm];
            sthm = [-1*stench_thm];
            
            % Neighboring cells
            r = 1;
            c = 1;
            while r <= length(fringes)
                f_x = fringes(r,c);
                c = c + 1;
                f_y = fringes(r,c);
                ROW = 5 - f_y;
                COL = f_x;
                
                KB = CS4300_Tell([-1*CS4300_Get_Pit_Theorem(f_x, f_y), breeze_thm], KB);
                KB = CS4300_Tell([-1*CS4300_Get_Wumpus_Theorem(f_x, f_y), stench_thm], KB);
                
                bthm = [bthm, CS4300_Get_Pit_Theorem(f_x, f_y)];
                sthm = [sthm, CS4300_Get_Wumpus_Theorem(f_x, f_y)];

                r = r + 1;
                c = 1;
            end
            
            KB = CS4300_Tell(bthm, KB);
            KB = CS4300_Tell(sthm, KB);
        end
    end
end