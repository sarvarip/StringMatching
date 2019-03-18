function [A_look, C_look, G_look, T_look] = BM_bad_char_rule(pattern)
 %% Assuming that pattern is DNA, so alphabet is {A,C,G,T}
 
 n = length(pattern);
 A_look = [];
 C_look = [];
 G_look = [];
 T_look = [];
 
for i=n:-1:1
    if pattern(i) == 'A'
        A_look = [A_look, i];
    elseif pattern(i) == 'C'
        C_look = [C_look, i];
    elseif pattern(i) == 'G'
        G_look = [G_look, i];
    else
        T_look = [T_look, i];
    end
end


         
     