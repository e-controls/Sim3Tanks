function [varargout] = get_dimensions(parameter)

Nx  = 3; % Number of states
Ny  = 8; % Number of outputs

if (nargin()==0)
    varargout{1} = Nx;
    varargout{2} = Ny;
else
    if(strcmp(parameter,'Nx'))
        varargout{1} = Nx;
    elseif (strcmp(parameter,'Ny'))
        varargout{1} = Ny;
    end
end