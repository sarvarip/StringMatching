function [z_vals] = z_algo(text)
%% Gusfield page 9
% Test: 'aabaabcaxaabaabcy'

n = length(text);
z_vals = zeros(1, n); %z1 remains zero, undefined
r = 0;
l = 0;

for k=2:length(z_vals)
    if k > r %1 on page 9
        ind = 0;
        while text(k+ind) == text(ind+1)
            ind = ind+1;
            if k+ind > n
                break
            end
        end
        z_vals(k) = ind;
        if ind > 0
            l = k;
            r = k+ind-1;
        end
    else
        beta = r-k+1;
        kprime = k-l+1;
        z_of_kprime = z_vals(kprime);
        if z_of_kprime < beta %2a on page 9
            z_vals(k) = z_of_kprime;
        else %2b on page 9
            idx = 1;
            if r+idx <= n
                while text(r+idx) == text(beta+idx)
                    idx = idx+1;
                    if r+idx > n
                        break;
                    end
                end
            end
            q = r+idx;
            z_vals(k) = q-k;
            l = k;
            r = q-1;
        end
    end
end


    
                
