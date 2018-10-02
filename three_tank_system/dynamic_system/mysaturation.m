function [y] = mysaturation(u, u_min, u_max)

y = zeros(size(u));

if(isscalar(u_min) && isscalar(u_min))
    for i = 1 : length(u)
        if(u(i) < u_min)
            y(i) = u_min;
        elseif(u(i) > u_max)
            y(i) = u_max;
        else
            y(i) = u(i);
        end
    end
else
    for i = 1 : length(u)
        if(u(i) < u_min(i))
            y(i) = u_min(i);
        elseif(u(i) > u_max(i))
            y(i) = u_max(i);
        else
            y(i) = u(i);
        end
    end
end