function [occurences] = BM_algo(pattern, text) %#codegen
%% Page 22, Gusfield
% k is the pointer that is "shifted"
% occurences denotes where the exact matching ENDS in the text
% example: BM_algo('AGCAGTACGTAGCCTAGCAGTA', 'ACGTAAGGCAGTACCAGCAGTACGTAGCCTAGCAGTAACGGTGCTGTAGCAGTACGTAGCCTAGCAGTAAGTACCAGCTA')
% example 2: BM_algo('ACTGAACTGACT','CCGCTGAACTGACTGACTGAACTGACTTGAACTGACT');
% this example uses the good suffix rule too!

lookup = BM_bad_char_rule(pattern);
l_vals = BM_good_suffix_rule(pattern);
sp_vals = sp_algo_recursive(pattern);
n = length(pattern);
sp_val_n = sp_vals(n); %described as l-values in Gusfield
occurences=[];
m = length(text);

k = n;
while k<=m 
    i = n;
    h = k;
    while i>0 && pattern(i) == text(h) 
        i = i-1;
        h = h-1;
    end
    if i==0
        occurences = [occurences, k];
        k = k+n-sp_val_n;
    else
        mismatching_char = text(h); 
        num = i;
        if num == 1
            lookup_val = 0;
        else
            if mismatching_char == 'A'
                lookup_val = lookup(1,num-1);
            elseif mismatching_char == 'C'
                lookup_val = lookup(2,num-1);
            elseif mismatching_char == 'G'
                lookup_val = lookup(3,num-1);
            elseif mismatching_char == 'T'
                lookup_val = lookup(4,num-1);
            else
                disp('Error: wrong dictionary is assumed');
                pause;
            end
        end
        if l_vals(i) > 0 && i<n %i<n meaning that there was at least one 
            %character matching
            k = k + max(n-l_vals(i), num-lookup_val);
        else
            k = k + num-lookup_val;
        end
    end
end


