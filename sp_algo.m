function [sp_vals] = sp_algo(text)
%% Gusfield page 26
%% Wrong algorithm: sp_vals don't have to be from the set of z_vals: see 
%% page 24, example: 'bbccaebbcabd'

sp_vals = zeros(1,length(text));
z_vals = z_algo(text);

for j = length(text):-1:2 %going backwards mapping j to i 
    %and i will be overwritten if there is a smaller j that maps to it
    if z_vals(j)>0 
        i = j+z_vals(j)-1;
        sp_vals(i) = z_vals(j);
        disp([j, i])
    end
end

