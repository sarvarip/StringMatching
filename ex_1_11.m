function [pos, arr] = ex_1_11(text)
%Gusfield exercise 11 chapter 1
%Define set here, like a lookup table (complexity depends on size of
%dictionary)

lookup = [2,1,1];
pos = [];
n = length(text);
arr = zeros(1,n);
arr(text=='a'|text=='b'|text=='c') = 1;
   
for i = 1:1:n
    
    if i > 4
        letter_to_add_back = text(i-4);
        if strcmp(letter_to_add_back, 'a')
            lookup(1) = lookup(1)+1;
        elseif strcmp(letter_to_add_back, 'b')
            lookup(2) = lookup(2)+1;
        elseif strcmp(letter_to_add_back, 'c')
            lookup(3) = lookup(3)+1;
        end
    end
        
    curr_letter = text(i);
    if strcmp(curr_letter, 'a')
        lookup(1) = lookup(1)-1;
    elseif strcmp(curr_letter, 'b')
        lookup(2) = lookup(2)-1;
    elseif strcmp(curr_letter, 'c')
        lookup(3) = lookup(3)-1;
    else
        continue
    end
    
    if isequal(lookup, [0,0,0])
        pos = [pos, i-3];
        arr(i-3:i) = [4,3,2,1];
    end
end
        
    
            