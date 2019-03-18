function [arr, ix_ret] = radix_sort(array)
%% Radix sort with counting sort

no_passes = ceil(log10(max(array)));
if ceil(log10(max(array))) == log10(max(array))
    no_passes = no_passes+1;
end
d = num2str(no_passes);
s = strcat('%0',d,'.f');
n = length(array);
arr = zeros(n, no_passes);

for i = 1:n
    temp = num2str(array(i),s);
    arr(i,:) = temp-'0';
end

[~, ix] = counting_sort(arr(:,end));
arr = arr(ix,:);
ix_ret = ix;

for pass = no_passes-1:-1:1
    [~, ix] = counting_sort(arr(:,pass));
    arr = arr(ix,:);
    ix_ret = ix_ret(ix);
end



    

