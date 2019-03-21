function [pos, arr] = ex_1_11(text)
%Gusfield exercise 11 chapter 1
%Define set here, S, like a lookup table (complexity depends on size of
%dictionary)
%pos is the postion at which the substring formed from the charactrs of S
%begins
%arr is an array of values corresponding to each index i, where the values
%represent the length of the longest substring in the text starting at i
%that can be formed from S

lookup = [2,1,1];
pos = [];
n = length(text);
arr = zeros(1,n);
arr(text=='a'|text=='b'|text=='c') = 1;
   
for i = 1:1:n
    
    if i > 4 %in more general form, 4 is the sum of elements in lookup
        letter_to_add_back = text(i-4); %add the letters back into the set
        %that are not considered to be in the substring any more
        if strcmp(letter_to_add_back, 'a')
            lookup(1) = lookup(1)+1;
        elseif strcmp(letter_to_add_back, 'b')
            lookup(2) = lookup(2)+1;
        elseif strcmp(letter_to_add_back, 'c')
            lookup(3) = lookup(3)+1;
        end
    end
        
    curr_letter = text(i); %read the next letter
    %since now it is assumed to be in the substring, take that letter out
    %of the set
    if strcmp(curr_letter, 'a')
        lookup(1) = lookup(1)-1;
    elseif strcmp(curr_letter, 'b')
        lookup(2) = lookup(2)-1;
    elseif strcmp(curr_letter, 'c')
        lookup(3) = lookup(3)-1;
    else
        continue
    end
    
    if isequal(lookup, [0,0,0]) %if the set is empty, we found a match
        pos = [pos, i-3]; %pos indicates where the match STARTS
        arr(i-3:i) = [4,3,2,1]; %arr will be overwritten multiple times
        %during the course of the for loop
    end
end
        
    
            