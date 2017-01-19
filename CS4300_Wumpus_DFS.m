function [solution,nodes]  = CS4300_Wumpus_DFS(board,initial_state,...
    goal_state)
% CS4300_Wumpus_DFS - DFS on Wumpus board finding path to goal
% On input:
%     board (4x4 array): Wumpus board
%       0: empty cell
%       1: pit in cell
%       2: gold in cell
%       3: Wumpus in cell
%       4: Wumpus and gold in cell
%     initial_state (1x3 vector): x,y,dir values of initial state
%     goal_state (1x3 vector): x,y,dir of final state
% On output:
%     solution (nx4 array): n states from start to goal states
%       (x,y,dir,action)
%     nodes (search tree data structure): nodes of search tree
%       (i).parent (int): index of parent
%       (i). level (int): level in tree
%       (i).state (1x3 vector): x,y,dir of node
%       (i).action (int): action taken to get to this state
%       (i).cost (int): path cost to this node fro mroot
%       (i).children (1xk vector): indexes of node's children
% Call:
%     b = CS4300_gen_board_A1(2)
%   b =
%       0     0     0     1
%       2     0     1     0
%       0     0     0     0
%       0     3     0     0
%     [so,no] = CS4300_Wumpus_DFS(b,[1,1,0],[3,4,1])
%   so =
%     1     1     0     0
%     1     1     1     3
%     1     2     1     1
%     1     3     1     1
%   no = 
%     1x8 struct array with fields:
%     parent
%     level
%     state
%     action
%     cost
%     children
%
% Author:
%     T. Henderson
%     UU
%     Fall 2014
%

nodes(1).parent = [];
nodes(1).level = 0;
nodes(1).state = initial_state;
nodes(1).action = 0;
nodes(1).cost = 0;
nodes(1).children = [];
num_nodes = 1;
frontier = [1];
explored = [];
while 1==1
    if isempty(frontier)
        solution = [];
        return
    end
    node = frontier(1);
    frontier = frontier(2:end);
    explored = [explored,node];
    if CS4300_Wumpus_solution(nodes(node).state,goal_state)
        solution = CS4300_traceback(nodes,node);
        return
    end
    next_list = [];
    for action = 1:3
        next_state = CS4300_Wumpus_transition(nodes(node).state,...
            action,board);
        if next_state(1)>0 ...
            & CS4300_Wumpus_new_state(next_state,frontier,explored,...
                nodes)
            num_nodes = num_nodes + 1;
            nodes(num_nodes).parent = node;
            nodes(num_nodes).level = nodes(node).level + 1;
            nodes(num_nodes).state = next_state;
            nodes(num_nodes).action = action;
            nodes(num_nodes).cost = nodes(node).cost + 1;
            nodes(num_nodes).children = [];
            nodes(node).children = [nodes(node).children,num_nodes];
            next_list = [num_nodes,next_list];
        end
    end
    frontier = [next_list(end:-1:1),frontier];
end
