function [M] = get_covariance_matrix(matrix)

M = 0;

switch upper(matrix)
    case 'P'
        M = diag([1e-4 1e-4 1e-4]);
    case 'Q'
        M = diag([1e-5 1e-5 1e-5]);
    case 'R'
        M = diag([1e1 1e1 1e1 1e2 1e2 1e2 1e2 1e2]);
end