function [z,ka] = glr_check_threshold(g,th)

k = get_k();
n = length(g);
z = zeros(n,1);

if(k == 1)
    ka = zeros(n,1);
    flag = ones(n,1);
    glr_set_samples(ka);
    glr_set_flag(flag);
else
    flag = glr_get_flag();
    for p = 1 : n
        if(g(p)>th(p))
            z(p) = 1;
            if(flag(p))
                ka = glr_get_samples();
                ka(p) = k;
                glr_set_samples(ka);
                flag(p) = 0;
                glr_set_flag(flag);
            end
        end
    end
end

ka = glr_get_samples();

end