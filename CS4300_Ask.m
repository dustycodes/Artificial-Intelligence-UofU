function proved = CS4300_Ask(theorem, KB)
% CS4300_Ask - uses RTP to try and prove the asked theorem
% On input:
%   theorem (CNF) 
% On output:
%   proved (boolean): returns true if the theorem is true
% Call:
%   proved = CS4300_Ask(theroem);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    proved = 0;
    
    p = CS4300_RTP(KB.sentences, theorem, [1:113]);
    if isempty(p)
        proved = 1;
    end
end
