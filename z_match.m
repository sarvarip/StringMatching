function [occurences] = z_match(pattern, text)
%% Page 10, Gusfield
% example: z_match('AGCAGTACGTAGCCTAGCAGTA', 'ACGTAAGGCAGTACCAGCAGTACGTAGCCTAGCAGTAACGGT')

n = length(pattern);
full = strcat(pattern, '$', text);
z_vals = z_algo(full);
occurences = find(z_vals==n);
occurences = occurences-n-1; %-1 due to $ sign


