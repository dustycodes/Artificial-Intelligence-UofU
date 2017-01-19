function truth = CS4300_Arc_Consistency_Validation()
% CS4300_Arc_Consistency_Validation - Validate AC1 and AC3
% On output: 
% truth (1 or 0): 1 if the tests passed
% Call: truth = CS4300_Arc_Consistency_Validation();
% Author:
% Dusty Argyle
% UU
% Fall 2016
% 
P = 'CS4300_Arc_Consistency_Predicate';
data = zeros(1200, 5);
iter = 1;
truth = 1;

N = 4;
G = ~eye(N,N);

D = [1,1,1,1;1,1,1,1;1,1,1,1;1,1,1,1];
ANS = [1,1,1,1;1,1,1,1;1,1,1,1;1,1,1,1];
D1 = CS4300_AC3(G, D, P);
D2 = CS4300_AC1(G, D, P);
if D1 ~= D2
    truth = 0;
end


D = [1,0,0,0;1,1,1,1;1,1,1,1;1,1,1,1];
ANS = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
D1 = CS4300_AC3(G, D, P);
D2 = CS4300_AC1(G, D, P);
if D1 ~= D2 && D1 == ANS
    truth = 0;
    return
end

D = [0,1,0,1;1,1,1,1;1,0,0,0;1,1,1,1];
ANS = [0,1,0,0;0,0,0,1;1,0,0,0;0,0,1,0];
D1 = CS4300_AC3(G, D, P);
D2 = CS4300_AC1(G, D, P);
if D1 ~= D2 && D1 == ANS
    truth = 0;
    return
end

D = [0,0,1,0;1,0,0,0;1,1,1,1;1,1,1,1];
ANS = [0,0,1,0;1,0,0,0;0,0,0,1;0,1,0,0];
D1 = CS4300_AC3(G, D, P);
D2 = CS4300_AC1(G, D, P);
if D1 ~= D2 && D1 == ANS
    truth = 0;
    return
end


for N=4:10
   data(iter, 1) = N;
   G = ~eye(N,N);
   
   for p = 0:0.2:1
       for t=1:200
          D = rand(N,N) < p;
          
          tic;
          D1 = CS4300_AC3(G, D, P);
          t1 = toc;
          data(iter, 2) = numel(find(D)) - numel(find(D1));
          data(iter, 4) = t1;
          
          tic;
          D2 = CS4300_AC1(G, D, P);
          t2 = toc;
          data(iter, 3) = numel(find(D)) - numel(find(D2));
          data(iter,5) = t2;
          
          if D2 ~= D1
              truth = 0;
          end
       end
   end
end
end