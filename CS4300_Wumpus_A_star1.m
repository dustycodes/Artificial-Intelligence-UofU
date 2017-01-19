function [so,no] = CS4300_Wumpus_A_star1(board,initial_state,goal_state,h_name,option)
% CS4300_Wumpus_A_star1 - A* algorithm for Wumpus world
% On input:
% board (4x4 int array): Wumpus board layout
% 0: means empty cell
% 1: means a pit in cell
% 2: means gold (only) in cell
% 3: means Wumpus (only) in cell
% 4: means gold and Wumpus in cell
% initial_state (1x3 vector): x,y,dir state
% goal_state (1x3 vector): x,y,dir state
% h_name (string): name of heuristic function
% option (int): picks insertion strategy for equal cost states
% 1: insert state before equal or greater than states
% 2: insert after equal or less than states
% On output:
% solution (nx4 array): solution sequence of state and the action
% nodes (search tree data structure): search tree
% (i).parent (int): index of node?s parent
% (i).level (int): level of node in search tree
% (i).state (1x3 vector): [x,y,dir] state represented by node
% (i).action (int): action along edge from parent to node
% (i).g (int): path length from root to node
% (i).h (float): heuristic value (estimate from node to goal)
% (i).cost (float): g + h (called f value in text)
% (i).children (1xk vector): list of node?s children
% Call:
%[so,no] = CS4300_Wumpus_A_star1([0,0,0,0;0,0,0,1;0,2,1,3;0,0,0,0],...
% [1,1,0],[2,2,1],'CS4300_A_star_Man',1)
% so =
% 1 1 0 0
% 2 1 0 1
% 2 1 1 3
% 2 2 1 1
%
% no = 1x9 struct array with fields:
% parent
% level
% state
% action
% cost
% g
% h
% children
% Author:
% Dusty Argyle
% UU
% Fall 2016
%

POSSIBLE_ACTIONS = 1:3;

g = 0;
h = feval(h_name, goal_state, initial_state);
root = struct('parent', 0, 'level', 0, 'state', initial_state, 'action', 0, 'cost', g+h, 'g', g, 'h', h, 'children', []);
frontier = [root];
explored = [];
so = [];
no = [];
parent_index = 1;

while true
    
    % Check the frontier
    if(length(frontier) == 0)
        break;
    end
    
    % Explore the priority node
    parent_node = frontier(1);
    % Fix children
    %parent_node.children = [parent_node.children, parent_index];
    
    frontier = frontier(2:length(frontier));
    explored = [parent_node, explored];
    
    
    % Check if it is the solution
    if(parent_node.state(1) == goal_state(1) && parent_node.state(2) == goal_state(2))
        current_node = parent_node;
        while current_node.level ~= 0
            so = [current_node.state, current_node.action; so];
            current_node = current_node.parent;
        end
        so = [current_node.state, current_node.action; so];
        no = explored;
        return
    end
    
    for action = POSSIBLE_ACTIONS
        
        % Setup the node
        agent.x = parent_node.state(1);
        agent.y = parent_node.state(2);
        agent.dir = parent_node.state(3);
        agent.alive = 1;
        [child_board,child_agent,bumped,screamed] = CS4300_update(board, agent, action);
        
        % If Wumpus died or bumps into a wall, don't add node as child
        if (bumped == true || child_agent.alive == 0)
            continue
        end
        
        % Get the state
        child_state = zeros(1,3);
        child_state(1) = child_agent.x;
        child_state(2) = child_agent.y;
        child_state(3) = child_agent.dir;
        
        % Search if it already exists
        exists = false;
        for node = explored
            if node.state == child_state
               exists = true; 
               break;
            end
        end
        for node = frontier
            if node.state == child_state
               exists = true; 
               break;
            end
        end
        
        if exists == true
            continue;
        end
        
        % Get the cost
        g = parent_node.cost + 1;
        h = feval(h_name, goal_state, child_state);
        
        % Create the node
        child_node = struct('parent', parent_node, 'level', parent_node.level + 1, 'state', child_state, 'action', action, 'cost', g+h, 'g', g, 'h', h, 'children', []);
        
        % Fix children
        parent_node.children = [parent_node.children, child_node];        
        
        % Insert into frontier
        if(length(frontier) ~= 0)
            iter = 1;
            while(iter <= length(frontier))
                if option == 1
                    % 1: insert state before equal or greater than states
                    if (child_node.cost < frontier(iter).cost)
                        br = iter - 1;
                        en = length(frontier);
                        frontier = [frontier(1:br) child_node frontier(iter:en)];
                        break;
                    elseif (iter == length(frontier))
                        frontier = [frontier, child_node];
                        break;
                    end
                else
                    % 2: insert after equal or less than states
                    if (child_node.cost <= frontier(iter).cost)
                        br = iter;
                        en = length(frontier);
                        frontier = [frontier(1:br) child_node frontier(iter:en)];
                        break;
                    elseif (iter == length(frontier))
                        frontier = [frontier, child_node];
                        break;
                    end
                end
                iter = iter + 1;
            end
        else
            frontier = [frontier, child_node];
        end
    end
    explored = [parent_node, explored(2:length(explored))];
    no = explored;
end
end