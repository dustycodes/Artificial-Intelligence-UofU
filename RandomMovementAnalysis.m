function action = RandomMovementAnalysis()
% CS4300_run_A1_trials - run experiments for A1
% On input:
%
% On output:
%    All output is in the 
% Call:
%     RandomMovementAnalysis(200);
% Author:
%     Dusty Argyle
%     UU
%     Fall 2016
%

gold=[];
steps=[];

for i=1:2000
 results = CS4300_WW2(inf,'CS4300_agent1');
 
 steps(i) = numel(results);
 gold(i) = 0;
 
 for j=1:steps(i)
    if results(j).agent.x == 3 && results(j).agent.y == 4
        gold(i)=1;
    end
 end
end

stepMean = mean(steps);
goldMean = mean(gold);
goldVar = var(gold);
stepVar = var(steps);

CI1 = goldMean - 1.96*sqrt(goldVar/2000);
CI2 = goldMean + 1.96*sqrt(goldVar/2000);

SCI1 = stepMean - 1.96*sqrt(stepVar/2000);
SCI2 = stepMean + 1.96*sqrt(stepVar/2000);

disp('Gold Mean:');
disp(goldMean);
disp('Gold Var:');
disp(goldVar);
disp('lower bound on Gold Step Confidence Interval:');
disp(CI1);
disp('uper Gold Confidence Interval:');
disp(CI2);


disp('Step Mean:');
disp(stepMean);
disp('Step Var:');
disp(stepVar);
disp('lower bound on Step Confidence Interval:');
disp(SCI1);
disp('uper Step Step Confidence Interval:');
disp(SCI2);


