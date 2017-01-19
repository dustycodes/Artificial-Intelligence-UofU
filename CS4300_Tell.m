function KB = CS4300_Tell(sentence, KB)
% CS4300_Tell - Add to the knowledge base
% On input:
%   sentence: A fact to add to the knowlege base
%   KB (Custom Data Structure): knowledge of the wumpus world state.
%       KB.sentences (CNF data structure): array of conjuctive clauses
%           KB.sentences(i).clauses each clause is a list of integers (- for negated literal)
% Call: 
%   CS4300_Tell(sentence, KB);
% Author:
% Dusty Argyle
% UU
% Fall 2016
%
    not_there = 1;
    for sen = KB.sentences
        s = sen.clauses;
        
        if isequal(length(s), length(sentence))
            same = 0;
            for l1 = s
                
               contains = 0;
               for l2 = sentence
                    if isequal(l1, l2)
                        contains = 1;
                        break;
                    end
               end
               
               if contains
                   same = same + 1;
               end
            end
            
            if isequal(same, length(sentence))
                return;
            end
        end
    end
    
    if not_there
        KB.sentences(length(KB.sentences)+1).clauses = sentence;
    end
end
