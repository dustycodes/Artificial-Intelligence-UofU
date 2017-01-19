function res = CS4300_get_data(trace)
% CS4300_run_get_data - get behavior data from trace of trial
% On input:
%     trace (trace data structure): trial data
% On output:
%     res (1x2 array): results of trial
%       (1): arrived at gold
%       (2): number of steps
% Call:
%     r = CS4300_run_get_data(t);
% Author:
%     T. Henderson
%     UU
%     Summer 2015; modified Summer 2016
%

res = zeros(1,2);
goal_row = 1;
goal_col = 3;

len_trace = length(trace);
res(2) = len_trace;
for s = 1:len_trace
    if trace(s).agent.x==goal_col&trace(s).agent.y==4-goal_row+1
        res(1) = 1;
    end
end
