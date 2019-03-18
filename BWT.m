function [L] = BWT(s)
%example: BWT('TGCAGCACAGTGGGCA$')

len = length(s);
array = zeros(len,len);
array(1,:) = s;

for j=1:len-1
    array(j+1,:) = circshift(s,j);
end

array = sortrows(array);
L = array(:,end);
L = char(L);



