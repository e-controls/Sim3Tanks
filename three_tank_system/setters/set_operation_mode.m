function [] = set_operation_mode(valve)

n = length(valve);

global d_valve;
d_valve = zeros(1,n);

for i = 1 : n
    d_valve(i) = valve(i);
end