function [data, avg_data, lower_confidences, higher_confidences] = CS4300_Arc_Consistency_Test()
% CS4300_Arc_Consistency_Test - Runs AC1 & AC3 and takes statistics.
% On input:
% On output:
% data (1200x6 array): NumberOfNodes, reductions1, reductions2, time1,
%                       time2, labels
% avg_data (7x6 array): same fields as data, just the averages
% lower_confidences (7x6 array): same fields as data, just the lower confidences
% higher_confidences (7x6 array): same fields as data, just the higher confidences
%
% Call: [data, avg_data, lower_confidences, higher_confidences] = CS4300_Arc_Consistency_Test();
% Author:
% Dusty Argyle
% UU
% Fall 2016
% 
P = 'CS4300_Arc_Consistency_Predicate';
data = zeros(1200, 6);
avg_data = zeros(7, 6);
lower_confidences = zeros(7,6);
higher_confidences = zeros(7,6);
iter = 1;

for N=4:10
   data(iter, 1) = N;
   G = ~eye(N,N);
   avg_t1 = zeros(1,200);
   avg_t2 = zeros(1,200);
   avg_r1 = zeros(1,200);
   avg_r2 = zeros(1,200);
   avg_l = zeros(1,200);
   
   for p = 0:0.2:1

              
       for t=1:200
          D = rand(N,N) < p;
          data(iter, 1) = N;

          tic;
          D1 = CS4300_AC3(G, D, P);
          t1 = toc;
          avg_t1(t) = t1;
          data(iter, 4) = t1;
          data(iter, 2) = numel(find(D)) - numel(find(D1));
          avg_r1(t) = numel(find(D)) - numel(find(D1));
          data(iter, 6) = numel(find(D));
          avg_l(t) = numel(find(D));
          
          tic;
          D2 = CS4300_AC1(G, D, P);
          t2 = toc;
          avg_t2(t) = t2;
          data(iter, 5) = t2;
          data(iter, 3) = numel(find(D)) - numel(find(D2));
          avg_r2(t) = numel(find(D)) - numel(find(D2));
          
          iter = iter + 1;
       end
   end
   
   total_avg_t1 = mean(avg_t1);
   total_avg_t2 = mean(avg_t2);
   total_avg_r1 = mean(avg_r1);
   total_avg_r2 = mean(avg_r2);
   total_avg_l = mean(avg_l);
   total_var_t1 = var(avg_t1);
   total_var_t2 = var(avg_t2);
   total_var_r1 = var(avg_r1);
   total_var_r2 = var(avg_r2);
   total_var_l = var(avg_l);
   
   avg_data(N-3, 1) = N;
   avg_data(N-3, 2) = total_avg_r1;
   avg_data(N-3, 3) = total_avg_r2;
   avg_data(N-3, 4) = total_avg_t1;
   avg_data(N-3, 5) = total_avg_t2;
   avg_data(N-3, 6) = total_avg_l;
   
   lower_confidences(N-3, 1) = N;
   lower_confidences(N-3, 2) = total_avg_r1 - 1.645*sqrt(total_var_r1/200);
   lower_confidences(N-3, 3) = total_avg_r2 - 1.645*sqrt(total_var_r2/200);
   lower_confidences(N-3, 4) = total_avg_t1 - 1.645*sqrt(total_var_t1/200);
   lower_confidences(N-3, 5) = total_avg_t2 - 1.645*sqrt(total_var_t2/200);
   lower_confidences(N-3, 6) = total_avg_l - 1.645*sqrt(total_var_l/200);
   higher_confidences(N-3, 1) = N;
   higher_confidences(N-3, 2) = total_avg_r1 + 1.645*sqrt(total_var_r1/200);
   higher_confidences(N-3, 3) = total_avg_r2 - 1.645*sqrt(total_var_r2/200);
   higher_confidences(N-3, 4) = total_avg_t1 - 1.645*sqrt(total_var_t1/200);
   higher_confidences(N-3, 5) = total_avg_t2 - 1.645*sqrt(total_var_t2/200);
   higher_confidences(N-3, 6) = total_avg_l - 1.645*sqrt(total_var_l/200);
end
end