function CS4300_pit_analysis(N)
% CS4300_pit_analysis - run an analysis on every pit situation
% On input:
%     N (int): number of randomly generated boards to try per number of pits
% On output:
%     Prints out the table containing solvable board data
% Call:
%     CS4300_pit_analysis(200);
% Author:
%     Dusty Argyle
%     UU
%     Fall 2015
%
%N = 1000;
PITS = [0:14];
SOLVS = zeros(1,14);

T = table;
for pit_number = PITS
   it = 0;
   solvable = 0;
   while it < N
       board = CS4300_gen_board_A1(pit_number);
       if CS4300_Wumpus_solvable(board)
          solvable = solvable + 1; 
       end
       it = it + 1;
   end
   percent = solvable/N;
   SOLVS(pit_number+1) = percent;
end

T.Pits = PITS';
T.PercentSolvable = SOLVS';

disp(T);

disp('mean:');
M = mean(SOLVS);
disp(M);

disp('variance:');
V = var(SOLVS);
disp(V);

disp('Confidence:');
CI1 = M - 1.645*sqrt(V/N);
CI2 = M + 1.645*sqrt(V/N);
disp(CI1);
disp('.. TO ..');
disp(CI2);
