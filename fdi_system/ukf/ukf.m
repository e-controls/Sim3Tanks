function [inov, yhat, xhat] = ukf(xhat0, uk, yk)

if(get_k() == 1)
    xhat = xhat0;
    yhat = yk;
    inov = yk - yhat;
    P = get_covariance_matrix('P');
    set_data_ukf(xhat, P);
else
    
    [xhat, Pxx] = get_data_ukf();
    
    Q = get_covariance_matrix('Q');
    R = get_covariance_matrix('R');
    Ts = get_sample_time();
    
    [Nx, Ny] = get_dimensions();
    
    %% Prepare UKF
    Nsp = 2*Nx;
    wj  = 1/Nsp;
    Xj  = zeros(Nx,Nsp);
    Yj  = zeros(Ny,Nsp);
    
    %% Forecast step
    
    % Sigma-point matrix
    P_root = sqrt(Nx)*chol(abs(Pxx));
    Xk = xhat*ones(1,Nsp) + [P_root, -P_root];
    
    xhat = 0;
    for j = 1 : Nsp
        % Propagating the sigma points to states
        Xj(:,j) = d_func_f(Xk(:,j), uk, Ts);
        % Calculating new states
        xhat = xhat + wj * Xj(:,j);
    end
    
    Pxx = 0;
    for j = 1 : Nsp
        % Updating Pxx
        Pxx =  Pxx + wj * (Xj(:,j) - xhat)*(Xj(:,j) - xhat)';
    end
    Pxx = Pxx + Q;
    
    yhat = 0;
    for j = 1 : Nsp
        % Propagating the sigma points to outputs
        Yj(:,j) = d_func_g(Xj(:,j), uk);
        % Calculating new outputs
        yhat = yhat + wj * Yj(:,j);
    end
    
    Pxy  = 0;
    Pyy  = 0;
    for j = 1 : Nsp
        % Updating Pxy
        Pxy =  Pxy + wj * (Xj(:,j) - xhat)*(Yj(:,j) - yhat)';
        % Updating Pyy
        Pyy =  Pyy + wj * (Yj(:,j) - yhat)*(Yj(:,j) - yhat)';
    end
    Pyy = Pyy + R;
    
    %% Data-assimilation step
    K = Pxy * inv(Pyy);
    inov = yk - yhat;
    xhat = xhat + K * inov;
    Pxx = Pxx - K * Pyy * K';
    
    set_data_ukf(xhat, Pxx);
    
end