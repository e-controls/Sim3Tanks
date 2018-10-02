function [varargout] = get_valves_state(f,K)

d_valves = get_operation_mode();
Kn = length(d_valves);

if(nargin()==0)
    n = length(get_time());
    valves = zeros(Kn,n);
    f = get_faults();
    
    for i = 1 : Kn
        for j = 1 : n
            if(d_valves(i) ~= 0)
                valves(i,j) = d_valves(i) - f(i,j)*d_valves(i);
            else
                valves(i,j) = f(i,j)*max(d_valves);
            end
        end
    end
    
    varargout{1} = valves;
    
elseif(nargin()==1)
    
    for i = 1 : Kn
        if(d_valves(i) ~= 0)
            varargout{i} = d_valves(i) - f(i)*d_valves(i);
        else
            varargout{i} = f(i)*max(d_valves);
        end
    end
    
elseif(nargin()==2)
    
    switch lower(K)
        case 'kp1'
            fnumber = 1;
        case 'kp2'
            fnumber = 2;
        case 'ka'
            fnumber = 3;
        case 'kb'
            fnumber = 4;
        case 'k13'
            fnumber = 5;
        case 'k23'
            fnumber = 6;
        case 'k1'
            fnumber = 7;
        case 'k2'
            fnumber = 8;
        case 'k3'
            fnumber = 9;
    end
    
    if(d_valves(fnumber) ~= 0 )
        varargout{1} = d_valves(fnumber) - f(fnumber)*d_valves(fnumber);
    else
        varargout{1} = f(fnumber)*max(d_valves);
    end
    
end