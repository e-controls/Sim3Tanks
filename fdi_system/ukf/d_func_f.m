function [xk] = d_func_f(x, u, Ts)

[A, Beta] = get_parameters();

x1 = x(1);
x2 = x(2);
x3 = x(3);

Q13 = Beta * sign(x1-x3) * sqrt(abs(x1-x3));
Q23 = Beta * sign(x2-x3) * sqrt(abs(x2-x3));
Q3  = Beta * sqrt(abs(x3));

mx = (1/A) * [   -Q13    ;...
                 -Q23    ;...
              Q13+Q23-Q3];

B  = (1/A) * [ 1 , 0 ;...
               0 , 1 ;...
               0 , 0 ];

xk = x + Ts*mx + Ts*B*u;

end