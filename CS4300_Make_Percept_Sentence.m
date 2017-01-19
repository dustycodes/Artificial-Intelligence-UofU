function percept_sentences = CS4300_Make_Percept_Sentence(percept, agent)
% CS4300_Make_Percept_Sentence - Turns percepts into sentences
% On input:
%   percept (5x1 Array of boolean values): [Stench, Breeze, Glitter, Bump,
%       Scream] current sensor state of the agent in the wumpus world.
%   agent(agent data structure): agent current state - x, y, dir
% On output:
%   percept_sentences (5x1 of integers): the sentences to add to your KB
% Call:  
%   percept_sentence = CS4300_Make_Percept_Sentence(percept);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    WUMPUS_BASE = 0;
    PIT_BASE = 16;
    GOLD_BASE = 32;
    STENCH_BASE = 48;
    BREEZE_BASE = 64;
    BUMP_BASE = 80;
    SCREAM_BASE = 96;
    offset = agent.x + 4 * (agent.y-1);
    
    percept_sentences = [];
    stench = percept(1);
    breeze = percept(2);
    glitter = percept(3);
    bump = percept(4);
    scream = percept(5);
    
    if stench
        percept_sentences(1) = STENCH_BASE + offset; 
    else
        percept_sentences(1) = -1*(STENCH_BASE + offset); 
    end
    
    if breeze
        percept_sentences(2) = BREEZE_BASE + offset; 
    else
        percept_sentences(2) = -1*(BREEZE_BASE + offset); 
    end
    
    if glitter
        percept_sentences(3) = GOLD_BASE + offset; 
    else
        percept_sentences(3) = -1*(GOLD_BASE + offset); 
    end
    
%     if bump
%         percept_sentences(4) = BUMP_BASE + offset; 
%     else
%         percept_sentences(4) = -1*(BUMP_BASE + offset); 
%     end
%     
%     if scream
%         percept_sentences(5) = SCREAM_BASE + offset; 
%     else
%         percept_sentences(5) = -1*(SCREAM_BASE + offset); 
%     end
    
end
