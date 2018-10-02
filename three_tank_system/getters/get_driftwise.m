function [fsignal] = get_driftwise(fmag, fstart, fstop)

t = get_time();
n = length(t);

fsignal = zeros(1,n);

inicio = 0;
fim = n;

flag1 = 1;

if(fmag ~= 0)
    
    for j = 1 : n
        if(t(j) >= fstart && flag1)
            inicio = j;
            flag1 = 0;
        elseif(t(j) >= fstop)
            fim = j;
            break;
        end
    end
    
    if(inicio ~= 0)
        step = ceil((fim-inicio)/3);
        qtd  = length(t(inicio:inicio+step-1));
        
        for j = inicio+1 : inicio+step
            fsignal(j) = fsignal(j-1) + fmag/qtd;
        end
        for j = inicio+step : inicio+2*step
            fsignal(j) = fmag;
        end
        
        for j = inicio+2*step+1 : fim
            fsignal(j) = fsignal(j-1) - fmag/qtd;
        end
        
    end
    
end