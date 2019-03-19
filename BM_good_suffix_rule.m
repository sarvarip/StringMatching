function [l_vals] = BM_good_suffix_rule(pattern)
%% Page 21, Gusfield
% test: BM_good_suffix_rule('cabdabdab')
% test: BM_good_suffix_rule('GTCAGTGGTCA')
% test: BM_good_suffix_rule('AGCAGTACGTAGCCTAGCAGTA')
% test: BM_good_suffix_rule('TAGCAGTACGTAGCCTAGCAGTA')
% test: BM_good_suffix_rule('GAGCAGTACGTAGCCTAGCAGTA')

n_vals = fliplr(z_algo(reverse(pattern)));
n = length(pattern);
l_vals = zeros(1,n);

for j = 1:1:n-1
    if n_vals(j) > 0
        i = n-n_vals(j)+1;
        l_vals(i) = j;
    end
end

