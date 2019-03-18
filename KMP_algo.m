function [occurences] = KMP_algo(pattern, text)

% Example: KMP_algo('abcxabcde', 'xyabcxabcxabcdefeabcxabcdeg')

    occurences = [];
    sp_vals = sp_algo_recursive(pattern);
    k = 0;
    n = length(pattern);
    for j = 1:length(text)
        while k>0 && pattern(k+1) ~= text(j)
            k = sp_vals(k);
        end
        if pattern(k+1) == text(j)
            k = k+1;
        end
        if k == n
            occurences = [occurences, j-n+1];
            k = 0;
        end
    end
    