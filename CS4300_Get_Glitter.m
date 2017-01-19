function theorem = CS4300_Get_Glitter(agent)
% CS4300_Get_Glitter - returns the theorem for asking if there is
%   gold at the agents position
% On input:
%   agent(agent data structure): agent current state - x, y, dir
% On output:
%   theorem (integer): the agent's position theorem to ask if gold is there
% Call:  
%   theorem = CS4300_Get_Glitter(KB.agent);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    offset = agent.x + 4 * (agent.y-1);
    GOLD_BASE = 32;
    theorem = GOLD_BASE + offset; 
end