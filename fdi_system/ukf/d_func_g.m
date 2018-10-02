function [yk] = d_func_g(x, u)

Beta = get_parameters('Beta');

x1 = x(1);
x2 = x(2);
x3 = x(3);

Q13 = Beta * sign(x1-x3) * sqrt(abs(x1-x3));
Q23 = Beta * sign(x2-x3) * sqrt(abs(x2-x3));
Q3  = Beta * sqrt(abs(x3));

gx = [x1 x2 x3 0 0 Q13 Q23 Q3]';

D  = [zeros(3,2) ; eye(2) ; zeros(3,2)];

yk = gx + D*u;

end