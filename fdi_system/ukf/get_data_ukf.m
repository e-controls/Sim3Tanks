function [xhat, Pk] = get_data_ukf()

global xhat_k_1;
global P;

xhat = xhat_k_1;
Pk   = P;

end