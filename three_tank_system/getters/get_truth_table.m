function [T] = get_truth_table(n)

% Arllem Farias, 2017.

T = zeros(2^n,n);

cont = 0;

for j = 1 : n
    jump = 2^(n-j);
    
    for i = 1 : 2^n
        cont = cont + 1;
        
        if(cont > jump)
            T(i,j) = 1;
            if(cont == 2*jump)
                cont = 0;
            end
        end
        
    end
    
end

end