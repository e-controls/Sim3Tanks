function [y] = y_out(h, q, f, v)

Kn = length(get_operation_mode());

y = [h ; q];

for i = 1 : length(y)
    j = Kn + i;
    if(f(j) ~= 1)
        y(i) = (1 - f(j)) * y(i) + v(i);
    else
        y(i) = 0;
    end
end