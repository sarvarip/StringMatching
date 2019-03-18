function [occurences] = BM_algo(pattern, text)
%% Page 22, Gusfield
% k is the pointer that is "shifted"
% occurences denotes where the exact matching ENDS in the text
% example: BM_algo('AGCAGTACGTAGCCTAGCAGTA', 'ACGTAAGGCAGTACCAGCAGTACGTAGCCTAGCAGTAACGGT')
% this example uses the good suffix rule too!

[A_look, C_look, G_look, T_look] = BM_bad_char_rule(pattern);
l_vals = BM_good_suffix_rule(pattern);
occurences=[];
n = length(pattern);
m = length(text);

k = n;
while k<=m 
    i = n;
    h = k;
    while i>0 && pattern(i) == text(h) %need to do something if no match at all, i==n
        i = i-1;
        h = h-1;
    end
    if i==0
        occurences = [occurences, k];
        k = k+1;
    else
        mismatching_char = text(h); 
        num = i;
        if mismatching_char == 'A'
            lookup_val = max(A_look(A_look<num));
        elseif mismatching_char == 'C'
            lookup_val = max(C_look(C_look<num));
        elseif mismatching_char == 'G'
            lookup_val = max(G_look(G_look<num));
        elseif mismatching_char == 'T'
            lookup_val = max(T_look(T_look<num));
        else
            disp('Error: wrong dictionary is assumed');
            pause;
        end
        if isempty(lookup_val)
            lookup_val = 0;
        end
        if l_vals(i) > 0 && i<n %i<n meaning that there was at least a match
            k = k + max(n-l_vals(i), num-lookup_val);
        else
            k = k + num-lookup_val;
        end
    end
end


