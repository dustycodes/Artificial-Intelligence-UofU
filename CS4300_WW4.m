function [scores,traces] = CS4300_WW4(max_steps,f_name)
% CS4300_WW4 - Wumpus World 4 (MC agent) simulator
% On input:
%     max_steps (int): maximum number of simulation steps
%     f_name (string): name of agent function
% On output:
%     score (int): agent score on game
%     trace (nx3 int array): trace of state
%       (i,1): x location
%       (i,2): y location
%       (i,3): action selected at time i
% Call:
%     [s,t] = CS4300_WW4(50,'CS4300_MC_agent');
% Author:
%     T. Henderson
%     UU
%     Summer 2015
%     Modified by Dusty
%

number_of_boards = 50;
%boards{1} = CS4300_gen_board(.2);

% while length(boards) < number_of_boards
%     b = CS4300_gen_board(.2);
%     
%     x = 1;
%     while x <= length(boards)
%         board = boards{x};
%         if ~isequal(board, b)
%             boards{length(boards)+1} = b;
%             break;
%         end
%     end
% end

load('/Users/dusty/Downloads/A5_boards.mat');

index = 1;
while index <= number_of_boards
    board = boards(index).board;
    scores(index).score = 0;
    scores(index).success = 0;
    scores(index).failures = 0;
    scores(index).board = board;
    
    for trials = 1:5
        traces = [];
        
        agent.x = 1;
        agent.y = 1;
        agent.alive = 1;
        agent.gold = 0;  % grabbed gold in same room
        agent.dir = 0;  % facing right
        agent.succeed = 0;  % has gold and climbed out
        agent.climbed = 0; % climbed out
        
        clear(f_name);
        
        disp(board);
        [score,trace] = CS4300_WW1(max_steps,f_name,board);
        
        M = CS4300_show_trace(trace, .01);
        
        if score > 0
            scores(index).success = scores(index).success + 1;
        else
            scores(index).failures = scores(index).failures + 1;
        end
        scores(index).score = scores(index).score + score;
        scores(index).trace = trace;
    end
    scores(index).score = scores(index).score/5;

    index = index + 1;
end

end