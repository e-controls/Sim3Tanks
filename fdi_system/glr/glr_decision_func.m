function [g] = glr_decision_func(r, meanr, stdr, M)

n = length(r);
g = zeros(n,1);
k = get_k();

if(k == 1)
    rbuffer = zeros(n,M);
    rbuffer(:,k) = r;
    glr_set_rbuffer(rbuffer);
    g(:) = 0;
else
    rbuffer = glr_get_rbuffer();
    if(k <= M)
        rbuffer(:,k) = r;
        glr_set_rbuffer(rbuffer);
        g(:) = 0;
    else
        rbuffer = circshift(rbuffer,M-1,2);
        rbuffer(:,M) = r;
        glr_set_rbuffer(rbuffer);
        
        aux = zeros(n,M);
        
        for j = 1 : M
            acc = 0;
            for i = j : M
                acc = acc + (rbuffer(:,i) - meanr(:));
            end
            aux(:,j) = (1/(M-j+1))*(acc.^2);
        end
        
        for p = 1 : n
            g(p) = (1/(2*stdr(p)^2))*max(aux(p,:));
        end
        
    end
end
