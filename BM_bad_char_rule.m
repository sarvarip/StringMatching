function [lookup] = BM_bad_char_rule(pattern) %#codegen
 %% Assuming that pattern is DNA, so alphabet is {A,C,G,T}
 
 n = length(pattern);
 lookup = -1*ones(4,n);
 
if pattern(1) == 'A'
    lookup(1,1) = 1;
elseif pattern(2) == 'C'
    lookup(2,1) = 1;
elseif pattern(3) == 'G'
    lookup(3,1) = 1;
else
    lookup(4,1) = 1;
end
 
for i=2:1:n
    lookup(:,i) = lookup(:,i-1);
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


         
     