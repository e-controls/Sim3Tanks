function [q] = outflows(x, u, f)

[Kp1,Kp2,Ka,Kb,K13,K23,K1,K2,K3] = get_valves_state(f);

Beta = get_parameters('Beta');
h0   = get_parameters('h0');

h1 = x(1);
h2 = x(2);
h3 = x(3);

u1 = Kp1 * u(1);
u2 = Kp2 * u(2);

if(h1<=h0 && h2<=h0 && h3<=h0)
    %disp('CASE 1 : h1<=h0, h2<=h0, h3<=h0');
    Qa  = Ka * 0;
    Qb  = Kb * 0;
    
elseif(h1<=h0 && h2<=h0 && h3>h0)
    %disp('CASE 2 : h1<=h0, h2<=h0, h3>h0');
    Qa  = Ka * Beta * sign(h0-h3) * sqrt(abs(h0-h3));
    Qb  = Kb * Beta * sign(h0-h3) * sqrt(abs(h0-h3));
    
elseif(h1<=h0 && h2>h0 && h3<=h0)
    %disp('CASE 3 : h1<=h0, h2>h0, h3<=h0');
    Qa  = Ka * 0;
    Qb  = Kb * Beta * sign(h2-h3) * sqrt(abs(h2-h3));
    
elseif(h1<=h0 && h2>h0 && h3>h0)
    %disp('CASE 4 : h1<=h0, h2>h0, h3>h0');
    Qa  = Ka * Beta * sign(h0-h3) * sqrt(abs(h0-h3));
    Qb  = Kb * Beta * sign(h2-h3) * sqrt(abs(h2-h3));
    
elseif(h1>h0 && h2<=h0 && h3<=h0)
    %disp('CASE 5 : h1>h0, h2<=h0, h3<=h0');
    Qa  = Ka * Beta * sign(h1-h0) * sqrt(abs(h1-h0));
    Qb  = Kb * 0;
    
elseif(h1>h0 && h2<=h0 && h3>h0)
    %disp('CASE 6 : h1>h0, h2<=h0, h3>h0');
    Qa  = Ka * Beta * sign(h1-h3) * sqrt(abs(h1-h3));
    Qb  = Kb * Beta * sign(h0-h3) * sqrt(abs(h0-h3));
    
elseif(h1>h0 && h2>h0 && h3<=h0)
    %disp('CASE 7 : h1>h0, h2>h0, h3<=h0');
    Qa  = Ka * Beta * sign(h1-h0) * sqrt(abs(h1-h0));
    Qb  = Kb * Beta * sign(h2-h0) * sqrt(abs(h2-h0));
    
elseif(h1>h0 && h2>h0 && h3>h0)
    %disp('CASE 8 : h1>h0, h2>h0, h3>h0');
    Qa  = Ka * Beta * sign(h1-h3) * sqrt(abs(h1-h3));
    Qb  = Kb * Beta * sign(h2-h3) * sqrt(abs(h2-h3));
    
end

Q13 = K13 * Beta * sign(h1-h3) * sqrt(abs(h1-h3));
Q23 = K23 * Beta * sign(h2-h3) * sqrt(abs(h2-h3));
Q1  = K1  * Beta * sqrt(abs(h1));
Q2  = K2  * Beta * sqrt(abs(h2));
Q3  = K3  * Beta * sqrt(abs(h3));

q = [u1 u2 Qa Qb Q13 Q23 Q1 Q2 Q3]';

end