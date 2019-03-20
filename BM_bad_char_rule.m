function [lookup] = BM_bad_char_rule(pattern) %#codegen
 %% Assuming that pattern is DNA, so alphabet is {A,C,G,T}
 
 n = length(pattern);
 lookup = zeros(4,n);
 
 
for i=1:1:n
    if i > 1
        lookup(:,i) = lookup(:,i-1);
    end
    if pattern(i) == 'A'
        lookup(1,i) = i;
    elseif pattern(i) == 'C'
        lookup(2,i) = i;
    elseif pattern(i) == 'G'
        lookup(3,i) = i;
    else
        lookup(4,i) = i;
    end
end


         
     