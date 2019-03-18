function [sorted_arr, ix] = counting_sort(array)

mn = min(array);
mx = max(array);
shift = mn-1;
len = length(array);
count = zeros(1, mx-mn+1);
sorted_arr = zeros(1, len);
ix = zeros(1, len);
for i=1:len
    num = array(i);
    count(num-shift) = count(num-shift)+1;
end
sumCount = cumsum(count);

for i=len:-1:1 %reverse order to make counting_sort stable!
    num = array(i);
    sorted_arr(sumCount(num-shift)) = num;
    ix(sumCount(num-shift)) = i;
    sumCount(num-shift) = sumCount(num-shift)-1;
end

    
    
    