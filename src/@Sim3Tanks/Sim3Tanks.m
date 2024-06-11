classdef Sim3Tanks %< handle
    % Sim3Tanks is the model class of the simulator.

    % Written by Arllem Farias, June/2024.
    % Last update June/2024 by Arllem Farias.

    %======================================================================

    properties %(Access = public, Hidden = false)
        Model = Sim3TanksModel();
    end

    %======================================================================

    methods % Class Constructor
        function obj = Sim3Tanks(varargin)

            % Check input arguments
            if(nargin()~=0)
                error(errorMessage(02));
            end
            
            

        end
    end


end