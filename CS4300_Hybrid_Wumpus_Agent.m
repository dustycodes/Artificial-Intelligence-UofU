function action = CS4300_Hybrid_Wumpus_Agent(percept)
% CS4300_Hybrid_Wumpus_Agent - A wumpus world agent that uses propositional
%   logic to identify objects throughout the world and determine
%   appropriate actions.
% On input:
%   percept (5x1 Array of boolean values): [Stench, Breeze, Glitter, Bump,
%       Scream] current sensor state of the agent in the wumpus world.
% On output:
%   action (integer): The action to take
% Call: 
%   action = CS4300_Hybrid_Wumpus_Agent(percept, KB);
% Author:
%   Dusty Argyle
%   UU
%   Fall 2016
%

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
    persistent KB;
    persistent visited_board;
    persistent grabbed;
    persistent safe_place;
    
    % List of actions
    EMPTY = 0;
    PIT = 1;
    GOLD = 2;
    WUMPUS = 3;
    FORWARD = 1;
    ROTATE_RIGHT = 2;
    ROTATE_LEFT = 3;
    GRAB = 4;
    SHOOT = 5;
    CLIMB = 6;
    
    if isempty(KB)
        KB = CS4300_Initialize_KB();
        KB.board = ones(4);
        KB.board(4,1) = EMPTY;
        visited_board = zeros(4);
        grabbed = 0;
        safe_place = [];
    end
    
    ROW = 5 - KB.agent.y;
    COL = KB.agent.x;
    
    % Update based on previous action
    KB.visited_board(ROW,COL) = 1;
    visited_board(ROW,COL) = 1;

    % Add percepts to KB if they aren't already there
    percept_sentences = CS4300_Make_Percept_Sentence(percept, KB.agent);
    for sentence = percept_sentences
        KB = CS4300_Tell(sentence, KB);
    end
    
    % Check if there is gold
    theorem.clauses = [CS4300_Get_Glitter(KB.agent)];
    proved = CS4300_Ask(theorem, KB);
    if proved && ~grabbed
        % update KB boards
        KB.board(ROW,COL) = GOLD;
        
        % Grab and get out
        KB.plan = [GRAB];
        % Create a plan to get out
        [so,no] = CS4300_Wumpus_A_star(KB.board, [KB.agent.x,KB.agent.y,KB.agent.dir], [1,1,1], 'CS4300_A_star_Man');
        KB.plan = [KB.plan, transpose(so(:,4))];
        action = KB.plan(1);
        KB.plan = KB.plan(2:end);
        KB.plan = KB.plan(2:end);
        KB.plan = [KB.plan, CLIMB];
        grabbed = 1;
    elseif ~isempty(KB.plan)
        % Pop plan to perform next action
        action = KB.plan(1);
        KB.plan = KB.plan(2:end);
    else
        % Find somewhere to go
        fringes = CS4300_Get_Fringe(KB.agent.x, KB.agent.y, visited_board);
        
        % Foreach adjacent location, check it for safety
        r = 1;
        while r <= length(fringes)
            c = 1;
            test_x = fringes(r,c);
            c = c + 1;
            test_y = fringes(r,c);
            test_row = 5 - test_y;
            test_col = test_x;
            r = r + 1;
            
            pit_thm = CS4300_Get_Pit_Theorem(test_x, test_y);
            wumpus_thm = CS4300_Get_Wumpus_Theorem(test_x, test_y);
            
            if isequal(KB.board(test_row,test_col), EMPTY)
                % we know it's safe already
                safe_place = [test_x, test_y; safe_place];
                break;
            end
            
            % We have to figure it out by askin KB
            thm.clauses = [-1*pit_thm];
            not_a_pit = CS4300_Ask(thm, KB);
            thm.clauses = [-1*wumpus_thm];
            not_a_wumpus = CS4300_Ask(thm, KB);
            thm.clauses = [pit_thm, wumpus_thm];
            %a_pit_or_wumpus = CS4300_Ask(thm, KB);
            if (not_a_wumpus && not_a_pit) %|| ~a_pit_or_wumpus
                KB.board(test_row,test_col) = EMPTY;
                safe_place = [test_x, test_y; safe_place];
                break;
            end
            
        end
        
        
        if ~isempty(safe_place)
            % Try the safe place
            test_x = safe_place(1,1);
            test_y = safe_place(1,2);
            safe_place(1,:)=[];

            [so,no] = CS4300_Wumpus_A_star(KB.board, [KB.agent.x,KB.agent.y,KB.agent.dir], [test_x,test_y,1], 'CS4300_A_star_Man');
            KB.plan = [KB.plan, transpose(so(:,4))];
            KB.plan = KB.plan(2:end);
            action = KB.plan(1);
            KB.plan = KB.plan(2:end);
        else
            % Random action between LEFT RIGHT FORWARD
            action = randi([1,3]);
        end
    end
    
    [board,KB.agent,bumped,screamed] = CS4300_update(KB.board,KB.agent,action);
end