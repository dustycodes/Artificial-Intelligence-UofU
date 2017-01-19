function res = CS4300_Gaussian_1D_ex(num_trials,num_samps)
% CS4300_Gaussian_1D_ex - example of 1-dim Gaussian on testing rand
% On input:
%     num_trials (int): number of trials for experiment
%     num_samps (int): number of sample per trial
% On output:
%     res (num_trialsx1): mean of rand on num_samps samples
% Call:
%     res = CS4300_Gaussian_1D_ex(1000,100);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

res = zeros(num_trials,1);
for t = 1:num_trials
    samps = rand(num_samps,1);
    res(t) = mean(samps);
end
res_mean = mean(res);
res_var = var(res);
[h,b] = hist(res,20);
clf
plot(b,h);
hold on
p = CS4300_Gaussian_1D(b,mean(res),var(res));
plot(b,max(h)*p/max(p),'ro');