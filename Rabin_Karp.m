function [occurences] = Rabin_Karp(pattern, text)
%% page 80, Gusfield

occurences = [];

n = length(pattern);
m = length(text);

pattern = strrep(pattern,'A','0');
pattern = strrep(pattern,'C','1');
pattern = strrep(pattern,'G','2');
pattern = strrep(pattern,'T','3');

text = strrep(text,'A','0');
text = strrep(text,'C','1');
text = strrep(text,'G','2');
text = strrep(text,'T','3');

pattern = pattern-'0';
text = text-'0';
no_primes = 3;

I = n*m^2;
p = primes(I);
a = 2;
p = p(p >= a);
prims = p(randperm(numel(p),no_primes));
hp = zeros(1,no_primes);
ht = zeros(m-n+1,no_primes);

for i = 1:no_primes
    
    prim = prims(i);
        
    %modulo of powers of 4 (page 79 Gusfield)
    four_to_n_mod = 1;
    for f = 1:n
        four_to_n_mod = mod(4*four_to_n_mod,prim);
    end
    
    %By Lemma 4.4.1
    hp_ = mod(pattern(1)*4,prim);
    for num = pattern(2:end)
        hp_ = mod(hp_*4,prim)+num;
    end
    hp(i) = mod(hp_,prim);
    
    %converting first n element of text
    ht_ = mod(text(1)*4,prim);
    for num = text(2:n)
        ht_ = mod(ht_*4,prim)+num;
    end
    ht(1,i) = mod(ht_,prim);
    
    %converting the rest of the text
    for j = 2:m-n+1
        temp = mod(4*ht(j-1,i),prim) - four_to_n_mod*text(j-1) + text(j+n-1);
        ht(j,i) = mod(temp, prim);
    end
    
end

for row = 1:m-n+1
    if isequal(hp, ht(row,:))
        occurences = [occurences, row];
    end
end

        
    
    
    
    








