function CS4300_Run_Hybrid_Wumpus_Agent()
% CS4300_Run_Hybrid_Wumpus_Agent - Runs the 3 boards for assignment 4b
% On input:
%   None
% On output:
%   None
% Call:
%   CS4300_Run_Hybrid_Wumpus_Agent();
% Author:
% Dusty Argyle
% UU
% Fall 2016
%

    EMPTY = 0;
    PIT = 1;
    GOLD = 2;
    WUMPUS = 3;

    % Board 1
    KB = [];
    KB = CS4300_Initialize_KB();
    KB.board = [EMPTY, EMPTY, EMPTY, WUMPUS;
                EMPTY, EMPTY, EMPTY, EMPTY;
                GOLD, PIT, EMPTY, EMPTY;
                EMPTY, EMPTY, EMPTY, EMPTY];
    bumped = 0;
    screamed = 0;
    finished = 0;

    %TODO RUN
    while ~finished
        percept = CS4300_get_percept(KB.board, KB.agent, bumped, screamed);
        action = CS4300_Hybrid_Wumpus_Agent(percept, KB);
        [KB.board, KB.agent, bumped, screamed] = CS4300_update(KB.board, KB.agent, action);
        if KB.agent.alive==0|KB.agent.succeed==1|KB.agent.climbed==1
            finished = 1;
        end
    end
    
            
    % Board 2
    KB = [];
    KB = CS4300_Initialize_KB();
    KB.board = [EMPTY, EMPTY, EMPTY, PIT;
                WUMPUS, GOLD, PIT, EMPTY;
                EMPTY, EMPTY, EMPTY, EMPTY;
                EMPTY, EMPTY, PIT, EMPTY];

    %TODO RUN
    
    % Board 5 - Impossible
    KB = [];
    KB = CS4300_Initialize_KB();
    KB.board = [EMPTY, EMPTY, EMPTY, EMPTY;
                EMPTY, EMPTY, EMPTY, EMPTY;
                WUMPUS, GOLD, EMPTY, EMPTY;
                EMPTY, PIT, PIT, EMPTY];

    %TODO RUN
end