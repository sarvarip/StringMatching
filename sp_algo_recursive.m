function [sp_vals] = sp_algo_recursive(text)
%% recursively compute SP values: how to calculate SP(i+1)?
%% case 1: if S[i+1] = S[SP(i)+1] -> SP(i+1) = SP(i)+1
%% case 2: else: see if S[i+1] = S[SP(SP(i))+1] -> SP(i+1) = SP(SP(i))+1, else recurse in this fashion

%% Time complexity: the value of k cannot go below 0, we increase k by one 
%% in each iteration, n iterations, each reduction by k must be paid by an earlier increase,
%% only n of them, so ...

%Example: 'bbccaebbcabd'

sp_vals = zeros(1,length(text));
for i = 1:length(text)-1
    k = sp_vals(i);
    while k>0 && text(k+1) ~= text(i+1)
        k = sp_vals(k);
    end
    if text(k+1) == text(i+1)
        sp_vals(i+1) = k+1;
    else
        sp_vals(i+1) = 0;
    end
end
