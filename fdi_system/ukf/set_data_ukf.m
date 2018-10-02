function [] = set_data_ukf(xhat, Pk)

global xhat_k_1;
global P;

xhat_k_1 = xhat;
P        = Pk;

end