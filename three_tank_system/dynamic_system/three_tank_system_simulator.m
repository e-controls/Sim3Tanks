function [y, h, q] = three_tank_system_simulator(x0, u, f, w, v)

if(get_k() == 1)
    h = x0; % System initial condition
    q = outflows(x0, u, f);
    y = y_out(x0, q, f, v);
    set_data_tts(x0);
else
    
    Hmax = get_parameters('Hmax');
    h0   = get_parameters('h0');
    Ts   = get_sample_time();
    x    = get_data_tts();
    
    h1 = x(1);
    h2 = x(2);
    h3 = x(3);
    
    options = odeset('MaxStep', Ts, 'RelTol', 1e-12);
    
    if(h1<=h0 && h2<=h0 && h3<=h0)
        %disp('CASE 1 : h1<=h0, h2<=h0, h3<=h0');
        [t, aux] = ode45(@(t,y)dxdt_case1(x, u, f, w), [0 Ts], x, options);
        
    elseif(h1<=h0 && h2<=h0 && h3>h0)
        %disp('CASE 2 : h1<=h0, h2<=h0, h3>h0');
        [t, aux] = ode45(@(t,y)dxdt_case2(x, u, f, w), [0 Ts], x, options);
        
    elseif(h1<=h0 && h2>h0 && h3<=h0)
        %disp('CASE 3 : h1<=h0, h2>h0, h3<=h0');
        [t, aux] = ode45(@(t,y)dxdt_case3(x, u, f, w), [0 Ts], x, options);
        
    elseif(h1<=h0 && h2>h0 && h3>h0)
        %disp('CASE 4 : h1<=h0, h2>h0, h3>h0');
        [t, aux] = ode45(@(t,y)dxdt_case4(x, u, f, w), [0 Ts], x, options);
        
    elseif(h1>h0 && h2<=h0 && h3<=h0)
        %disp('CASE 5 : h1>h0, h2<=h0, h3<=h0');
        [t, aux] = ode45(@(t,y)dxdt_case5(x, u, f, w), [0 Ts], x, options);
        
    elseif(h1>h0 && h2<=h0 && h3>h0)
        %disp('CASE 6 : h1>h0, h2<=h0, h3>h0');
        [t, aux] = ode45(@(t,y)dxdt_case6(x, u, f, w), [0 Ts], x, options);
        
    elseif(h1>h0 && h2>h0 && h3<=h0)
        %disp('CASE 7 : h1>h0, h2>h0, h3<=h0');
        [t, aux] = ode45(@(t,y)dxdt_case7(x, u, f, w), [0 Ts], x, options);
        
    elseif(h1>h0 && h2>h0 && h3>h0)
        %disp('CASE 8 : h1>h0, h2>h0, h3>h0');
        [t, aux] = ode45(@(t,y)dxdt_case8(x, u, f, w), [0 Ts], x, options);
        
    end
    
    % Levels
    h = mysaturation(aux(end,:)', 0, Hmax); % h = [h1, h2, h3]'
    
    % Outflows
    q = outflows(h, u, f); % q = [u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'
    
    % Output
    y = y_out(h, q, f, v); % y = [h1, h2, h3, u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'
    
    % Update data
    set_data_tts(h);
    
end