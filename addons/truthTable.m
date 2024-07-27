function [T] = truthTable(N)
% T = truthTable(N) returns the truth table for N variables.

% Written by Arllem Farias, 2024.
% https://github.com/e-controls/Sim3Tanks

if(nargin() ~= 1)
    error('This function must have just one input argument.');
elseif(N~=floor(N) || N<=0)
    error('The input argument must be a positive integer.');
end

T = zeros(2^N,N);

cont = 0;
for j = 1 : N
    jump = 2^(N-j);
    for i = 1 : 2^N
        cont = cont + 1;
        if(cont > jump)
            T(i,j) = 1;
            if(cont == 2*jump)
                cont = 0;
            end
        end
    end
end

T = logical(T);

end