function [s] = inv_BWT(L)
%Assuming the alphabet is that of the DNA sequence

num_A = 0;
num_C = 0;
num_G = 0;
num_T = 0;
len = length(L);
s = [];

for i = 1:len
    if L(i) == 'A'
        num_A = num_A+1;
    elseif L(i) == 'C'
        num_C = num_C+1;
    elseif L(i) == 'G'
        num_G = num_G+1;
    elseif L(i) == 'T'
        num_T = num_T+1;
    elseif L(i) == '$'
        continue
    else
        disp('Error: Invalid alphabet');
        pause;
    end
end

first_col = ['$'; repmat('A',num_A,1); repmat('C',num_C,1); repmat('G',num_G,1); repmat('T',num_T,1)];
c = [L, first_col];

[~, ix] = sortrows(c);
not_rotated = find(L=='$');
s = [s, '$'];
i = not_rotated;

while length(s) ~= len
    i = find(ix==i);
    s = [s, L(i)];
end

s = reverse(s);
    


