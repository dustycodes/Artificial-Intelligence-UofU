function UtilityTracePlotter( Ut, states )
%UTILITYTRACEPLOTTER Summary of this function goes here
%   Detailed explanation goes here
%   On input:
%   Ut (NxM array where N is number of steps and M is number of states): 
%   states (1 to n)
%   states (vector): actions (1 to k)
%
%      

if isempty(states)
    return
end

numStates = length(states);
numSteps = length(Ut(:,1));

plot(0,0,'w.');
hold on

for s = 1:numStates
    plot(Ut(:,states(s))); 
    text(numSteps + 1, Ut(end,states(s)), num2str(states(s)));
end


