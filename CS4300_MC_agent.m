function action = CS4300_MC_agent(percept)
% CS4300_MC_agent - Monte Carlo agent with a few informal rules
% On input:
%     percept (1x5 Boolean vector): percept from Wumpus world
%       (1): stench
%       (2): breeze
%       (3): glitter
%       (4): bump
%       (5): scream
% On output:
%     action (int): action to take
%       1: FORWARD
%       2: RIGHT
%       3: LEFT
%       4: GRAB
%       5: SHOOT
%       6: CLIMB
% Call:
%     a = CS4300_MC_agent(percept);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

FORWARD = 1;
RIGHT = 2;
LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

persistent safe pits Wumpus board have_gold have_arrow plan
persistent agent frontier visited t
persistent stenches
persistent breezes
persistent num_trials

if isempty(agent)
    t = 0;
    agent.x = 1;
    agent.y = 1;
    agent.dir = 0;
    safe = -ones(4,4);
    pits = -ones(4,4);
    Wumpus = -ones(4,4);
    board = -ones(4,4);
    visited = zeros(4,4);
    frontier = zeros(4,4);
    safe(4,1) = 1;
    pits(4,1) = 0;
    Wumpus(4,1) = 0;
    board(4,1) = 0;
    visited(4,1) = 1;
    have_gold = 0;
    have_arrow = 1;
    
    % Instantiate probs
    stenches = ones(4,4)*-1;
    breezes = ones(4,4)*-1;
    
    % Set to 50, 100, 200
    %num_trials = 200;
    %num_trials = 150;
    %num_trials = 50;
    %num_trials = 10;
    num_trials = 200;
    %num_trials = 0;
end

board(5-agent.y, agent.x) = 0;

if have_gold==1&~isempty(plan)
    action = plan(1);
    plan = plan(2:end);
    return
end

% incorporate new percepts
changed = 0;
if breezes(5-agent.y, agent.x) ~= percept(2)
    breezes(5-agent.y, agent.x) = percept(2);
    changed = 1;
end
if stenches(5-agent.y, agent.x) ~= percept(1)
    stenches(5-agent.y, agent.x) = percept(1);
    
    % we need to change everything not adjacent to zero
    if percept(1) == 1
        
        [s_rows, s_cols] = find(stenches==1);
        number_of_stenches = length(s_rows);
        new_stenches = zeros(4,4);
        neighbors_1 = CS4300_Get_Neighbors(agent.x, agent.y);
        
        rn = 1;
        cn = 1;
        while rn <= length(neighbors_1)
            n_x = neighbors_1(rn,cn);
            cn = cn + 1;
            n_y = neighbors_1(rn,cn);
            ROW = 5 - n_y;
            COL = n_x;
            
            if number_of_stenches <= 1
                neighbors_2 = CS4300_Get_Neighbors(n_x, n_y);
                rm = 1;
                cm = 1;
                while rm <= length(neighbors_2)
                    m_x = neighbors_2(rm,cm);
                    cm = cm + 1;
                    m_y = neighbors_2(rm,cm);
                    MROW = 5 - m_y;
                    MCOL = m_x;
                    
                    if visited(MROW, MCOL) == 0 && stenches(MROW, MCOL)~=0
                        new_stenches(MROW, MCOL) = -1;
                    end
                    
                    rm = rm + 1;
                    cm = 1;
                end
            end
            
            if visited(ROW, COL) == 0 && stenches(ROW, COL)~=0
                new_stenches(ROW, COL) = -1;
            end
            
            rn = rn + 1;
            cn = 1;
        end
        
        stenches = new_stenches;
        ri = 1;
        while ri < length(s_rows)+1
            stenches(s_rows(ri), s_cols(ri)) = 1;
            ri = ri + 1;
        end
        changed = 1;
    end
end
SHOOT = 5;

if ~have_arrow
    stenches=zeros(4,4);
end

% update info
if changed
    [pits,Wumpus] = CS4300_WP_estimates(breezes,stenches,num_trials);
end
[safe_rows, safe_cols] = find(pits==0 & Wumpus==0);
ri = 1;
while ri < length(safe_rows)+1
    safe(safe_rows(ri), safe_cols(ri)) = 1;
    board(safe_rows(ri), safe_cols(ri)) = 0;
    ri = ri + 1;
end
[frontier_rows, frontier_cols] = find(visited==1);
ri = 1;
while ri < length(frontier_rows)+1
    
    neighbors = CS4300_Get_Neighbors(frontier_cols(ri), 5-frontier_rows(ri));
    
    rn = 1;
    cn = 1;
    while rn <= length(neighbors)
        n_x = neighbors(rn,cn);
        cn = cn + 1;
        n_y = neighbors(rn,cn);
        ROW = 5 - n_y;
        COL = n_x;
        
        % We don't know what it is, could be a wumpus
        if visited(ROW,COL) == 0
            frontier(ROW, COL) = 1;
        end
        
        rn = rn + 1;
        cn = 1;
    end
    
    ri = ri + 1;
end


% find safest place to go
if percept(3)==1
    plan = [GRAB];
    have_gold = 1;
    [so,no] = CS4300_Wumpus_A_star(abs(board),...
        [agent.x,agent.y,agent.dir],...
        [1,1,0],'CS4300_A_star_Man');
    plan = [plan;so(2:end,4)];
    plan = [plan;CLIMB];
end

if isempty(plan)
    [cand_rows,cand_cols] = find(frontier==1&safe==1&visited==0);
    if ~isempty(cand_rows)
        cand_x = cand_cols;
        cand_y = 4 - cand_rows + 1;
        [so,no] = CS4300_Wumpus_A_star(abs(board),...
            [agent.x,agent.y,agent.dir],...
            [cand_x(1),cand_y(1),0],'CS4300_A_star_Man');
        plan = [so(2:end,4)];
%     else
%         [cand_rows,cand_cols] = find(frontier==1&visited==0);
%                 cand_x = cand_cols;
%         cand_y = 4 - cand_rows + 1;
%         [so,no] = CS4300_Wumpus_A_star(abs(board),...
%             [agent.x,agent.y,agent.dir],...
%             [cand_x(1),cand_y(1),0],'CS4300_A_star_Man');
%         plan = [so(2:end,4)];
    end
end

% No Wumpus shot yet
if have_arrow==1&isempty(plan)
    
    %plan = CS4300_plan_shot(agent,Wumpus,visited,safe,board);
    neighbors = [];
    [safe_rows, safe_cols] = find(safe==1);
    ri = 1;
    while ri < length(safe_rows)+1
        
        s_x = safe_cols(ri);
        s_y = 5-safe_rows(ri);
        n = CS4300_Get_Neighbors(s_x,s_y);
        neighbors = [neighbors; n];
        ri = ri + 1;
    end
    
    
    max = 0;
    shoot_cell = [1,1];
    rn = 1;
    cn = 1;
    while rn <= length(neighbors)
        n_x = neighbors(rn,cn);
        cn = cn + 1;
        n_y = neighbors(rn,cn);
        ROW = 5 - n_y;
        COL = n_x;
        
        if max < Wumpus(ROW,COL)
            shoot_cell = [n_x,n_y];
            max = Wumpus(ROW,COL);
        end
        
        rn = rn + 1;
        cn = 1;
    end
    
    shoot_from = [1,1];
    direction = 0;
    n = CS4300_Get_Neighbors(shoot_cell(1),shoot_cell(2));
    rn = 1;
    cn = 1;
    while rn <= length(n)
        n_x = n(rn,cn);
        cn = cn + 1;
        n_y = n(rn,cn);
        ROW = 5 - n_y;
        COL = n_x;
        
        if safe(ROW, COL) == 1
            shoot_from = [n_x, n_y];
            
            if shoot_cell(1) < shoot_from(1)
                direction = 2;
            elseif shoot_cell(1) > shoot_from(1)
                direction = 0;
            elseif shoot_cell(2) > shoot_from(2)
                direction = 1;
            elseif shoot_cell(2) < shoot_from(2)
                direction = 3;
            end
            break;
        end
        
        rn = rn + 1;
        cn = 1;
    end
    
    if agent.x ~= shoot_from(1) && agent.y ~= shoot_from(2)
    
        [so,no] = CS4300_Wumpus_A_star(abs(board),...
            [agent.x,agent.y,agent.dir],...
            [shoot_from(1),shoot_from(2),direction],'CS4300_A_star_Man');
        
        if isempty(so)
            plan = [1];
        else
            plan = [so(2:end,4)];
        end
    end
    
    temp_agent = agent;
    while direction ~= temp_agent.dir
        action = 3;
        [board,temp_agent,bumped,screamed] = CS4300_update(board,temp_agent,action);
        plan = [plan; action];
    end
    
    plan = [plan; SHOOT; 1];
end

% Take a risk
if isempty(plan)
    [cand_rows,cand_cols] = find(frontier==1);
    cand_x = cand_cols;
    cand_y = 4 - cand_rows + 1;
    temp_board = board;
    temp_board(cand_rows(1),cand_cols(1)) = 0;
    [so,no] = CS4300_Wumpus_A_star(abs(temp_board),...
        [agent.x,agent.y,agent.dir],...
        [cand_x(1),cand_y(1),0],'CS4300_A_star_Man');
    plan = [so(2:end,4)];
end

action = plan(1);
plan = plan(2:end);

% Update agent's idea of state
%agent = CS4300_agent_update(agent,action);
[board,agent,bumped,screamed] = CS4300_update(board,agent,action);
visited(4-agent.y+1,agent.x) = 1;
frontier(4-agent.y+1,agent.x) = 0;

if action==SHOOT
    have_arrow = 0;
end

tch = 0;
