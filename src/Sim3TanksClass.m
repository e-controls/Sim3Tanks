classdef Sim3TanksClass < handle
    % Sim3TanksClass is the model class of the simulator.

    % Written by Arllem Farias, January/2024.
    % Last update February/2024 by Arllem Farias.

    %======================================================================

    properties (Access = private, Hidden = true, Constant = true)
        % The sequential order of these properties must be maintained.
        LIST_OF_PARAM = {'TankRadius';'TankHeight';'PipeRadius';
            'TransPipeHeight';'CorrectionTerm';'GravityConstant';...
            'PumpMinFlow';'PumpMaxFlow'};
        LIST_OF_VALVES = {'Kp1';'Kp2';'Kp3';'Ka';'Kb';'K13';'K23';'K1';...
            'K2';'K3'};
        LIST_OF_FAULTS = {'f1';'f2';'f3';'f4';'f5';'f6';'f7';'f8';...
            'f9';'f10';'f11';'f12';'f13';'f14';'f15';'f16';'f17';...
            'f18';'f19';'f20';'f21';'f22';'f23'};
        LIST_OF_STATES = {'h1';'h2';'h3'};
        LIST_OF_FLOWS = {'Q1in';'Q2in';'Q3in';'Qa';'Qb';'Q13';'Q23';'Q1';...
            'Q2';'Q3'};
    end

    %======================================================================

    properties (Access = public, Hidden = false)
        % The name of these properties can be changed as wished, but the
        % sequential order must be maintained.
        PhysicalParam = [];
        ValveSettings = [];
        FaultSettings = [];
        ProcessNoise  = [];
        MeasurementNoise = [];
        InitialCondition = [];
    end

    %======================================================================

    methods (Access = public, Hidden = true)

        function prepareModel(this)
            %--------------------------------------------------------------
            clear global SIM3TANKS_LISTS;
            global SIM3TANKS_LISTS; %#ok<*GVMIS>
            SIM3TANKS_LISTS.LIST_OF_PARAM  = this.LIST_OF_PARAM;
            SIM3TANKS_LISTS.LIST_OF_VALVES = this.LIST_OF_VALVES;
            SIM3TANKS_LISTS.LIST_OF_FAULTS = this.LIST_OF_FAULTS;
            SIM3TANKS_LISTS.LIST_OF_STATES = this.LIST_OF_STATES;
            SIM3TANKS_LISTS.LIST_OF_FLOWS  = this.LIST_OF_FLOWS;
            %--------------------------------------------------------------

            ClassPropers = properties(this);

            %--------------------------------------------------------------
            for i = 1 : numel(this.LIST_OF_PARAM)
                this.(ClassPropers{1}).(this.LIST_OF_PARAM{i}) = [];
            end
            %--------------------------------------------------------------
            for i = 1 : numel(this.LIST_OF_VALVES)
                this.(ClassPropers{2}).(this.LIST_OF_VALVES{i}).OperationMode = 'Closed';
                this.(ClassPropers{2}).(this.LIST_OF_VALVES{i}).EnableControl = false;
                this.(ClassPropers{2}).(this.LIST_OF_VALVES{i}).OpeningRate = 0;
            end
            %--------------------------------------------------------------
            for i = 1 : numel(this.LIST_OF_FAULTS)
                this.(ClassPropers{3}).(this.LIST_OF_FAULTS{i}).EnableSignal = false;
                this.(ClassPropers{3}).(this.LIST_OF_FAULTS{i}).Magnitude = 0;
            end
            %--------------------------------------------------------------
            Nx = numel(this.LIST_OF_STATES);
            this.(ClassPropers{4}).EnableSignal = false;
            this.(ClassPropers{4}).Magnitude = zeros(1,Nx);
            %--------------------------------------------------------------
            Nq = numel(this.LIST_OF_FLOWS);
            this.(ClassPropers{5}).EnableSignal = false;
            this.(ClassPropers{5}).Magnitude = zeros(1,Nx+Nq);
            %--------------------------------------------------------------
            this.(ClassPropers{6}) = zeros(1,Nx);
            %--------------------------------------------------------------
        end

    end

    %======================================================================

    properties (Access = private, Hidden = true)
        StateVariables {mustBeFinite,mustBeNonnegative} = [];
        FlowVariables  {mustBeFinite} = [];
        SensorMeasurements {mustBeFinite} = [];
        ValveSignals {mustBeGreaterThanOrEqual(ValveSignals,0),mustBeLessThanOrEqual(ValveSignals,1)} = [];
        FaultSignals {mustBeGreaterThanOrEqual(FaultSignals,0),mustBeLessThanOrEqual(FaultSignals,1)} = [];
    end

    %======================================================================

    methods (Access = public, Hidden = true) % Setter methods

        function setStateVariables(this,x)
            N = numel(this.LIST_OF_STATES);
            if(~isrow(x) && ~isempty(x))
                error(errorMessage(08));
            elseif(numel(x)~=N && ~isempty(x))
                error([errorMessage(06),' The system has ',num2str(N),' state variables.']);
            end
            this.StateVariables = x;
        end

        function setFlowVariables(this,q)
            N = numel(this.LIST_OF_FLOWS);
            if(~isrow(q) && ~isempty(q))
                error(errorMessage(08));
            elseif(numel(q)~=N && ~isempty(q))
                error([errorMessage(06),' The system has ',num2str(N),' flow variables.']);
            end
            this.FlowVariables = q;
        end

        function setSensorMeasurements(this,y)
            N = numel(this.LIST_OF_STATES) + numel(this.LIST_OF_FLOWS);
            if(~isrow(y) && ~isempty(y))
                error(errorMessage(08));
            elseif(numel(y)~=N && ~isempty(y))
                error([errorMessage(06),' The system has ',num2str(N),' measured variables.']);
            end
            this.SensorMeasurements = y;
        end

        function setValveSignals(this,v)
            N = numel(this.LIST_OF_VALVES);
            if(~isrow(v) && ~isempty(v))
                error(errorMessage(08));
            elseif(numel(v)~=N && ~isempty(v))
                error([errorMessage(06),' The system has ',num2str(N),' valves.']);
            end
            this.ValveSignals = v;
        end

        function setFaultSignals(this,f)
            N = numel(this.LIST_OF_FAULTS);
            if(~isrow(f) && ~isempty(f))
                error(errorMessage(08));
            elseif(numel(f)~=N && ~isempty(f))
                error([errorMessage(06),' The system has ',num2str(N),' fault signals.']);
            end
            this.FaultSignals = f;
        end

    end

    %======================================================================

    methods (Access = public, Hidden = true) % Pusher methods

        function pushStateVariables(this,x)
            N = numel(this.LIST_OF_STATES);
            if(~isrow(x) && ~isempty(x))
                error(errorMessage(08));
            elseif(numel(x)~=N && ~isempty(x))
                error([errorMessage(06),' The system has ',num2str(N),' state variables.']);
            end
            this.StateVariables = [this.StateVariables;x];
        end

        function pushFlowVariables(this,q)
            N = numel(this.LIST_OF_FLOWS);
            if(~isrow(q) && ~isempty(q))
                error(errorMessage(08));
            elseif(numel(q)~=N && ~isempty(q))
                error([errorMessage(06),' The system has ',num2str(N),' flow variables.']);
            end
            this.FlowVariables = [this.FlowVariables;q];
        end

        function pushSensorMeasurements(this,y)
            N = numel(this.LIST_OF_STATES) + numel(this.LIST_OF_FLOWS);
            if(~isrow(y) && ~isempty(y))
                error(errorMessage(08));
            elseif(numel(y)~=N && ~isempty(y))
                error([errorMessage(06),' The system has ',num2str(N),' measured variables.']);
            end
            this.SensorMeasurements = [this.SensorMeasurements;y];
        end

        function pushValveSignals(this,v)
            N =numel(this.LIST_OF_VALVES);
            if(~isrow(v) && ~isempty(v))
                error(errorMessage(08));
            elseif(numel(v)~=N && ~isempty(v))
                error([errorMessage(06),' The system has ',num2str(N),' valves.']);
            end
            this.ValveSignals = [this.ValveSignals;v];
        end

        function pushFaultSignals(this,f)
            N = numel(this.LIST_OF_FAULTS);
            if(~isrow(f) && ~isempty(f))
                error(errorMessage(08));
            elseif(numel(f)~=N && ~isempty(f))
                error([errorMessage(06),' The system has ',num2str(N),' fault signals.']);
            end
            this.FaultSignals = [this.FaultSignals;f];
        end

    end

    %======================================================================

    methods (Access = public, Hidden = true) % Getter methods

        function x = getStateVariables(varargin)
            this = varargin{1};
            x = this.StateVariables;
            if(nargin()==2 && ~isempty(x))
                Ts = varargin{2};
                varNames = this.LIST_OF_STATES;
                x = array2timetable(x,'SampleRate',1/Ts,'VariableNames',varNames);
            elseif(nargin()>2)
                error(errorMessage(02));
            end
        end

        function q = getFlowVariables(varargin)
            this = varargin{1};
            q = this.FlowVariables;
            if(nargin()==2 && ~isempty(q))
                Ts = varargin{2};
                varNames = this.LIST_OF_FLOWS;
                q = array2timetable(q,'SampleRate',1/Ts,'VariableNames',varNames);
            elseif(nargin()>2)
                error(errorMessage(02));
            end
        end

        function y = getSensorMeasurements(varargin)
            this = varargin{1};
            y = this.SensorMeasurements;
            if(nargin()==2 && ~isempty(y))
                Ts = varargin{2};
                varNames = [this.LIST_OF_STATES;this.LIST_OF_FLOWS];
                y = array2timetable(y,'SampleRate',1/Ts,'VariableNames',varNames);
            elseif(nargin()>2)
                error(errorMessage(02));
            end
        end

        function v = getValveSignals(varargin)
            this = varargin{1};
            v = this.ValveSignals;
            if(nargin()==2 && ~isempty(v))
                Ts = varargin{2};
                varNames = this.LIST_OF_VALVES;
                v = array2timetable(v,'SampleRate',1/Ts,'VariableNames',varNames);
            elseif(nargin()>2)
                error(errorMessage(02));
            end
        end

        function f = getFaultSignals(varargin)
            this = varargin{1};
            f = this.FaultSignals;
            if(nargin()==2 && ~isempty(f))
                Ts = varargin{2};
                varNames = this.LIST_OF_FAULTS;
                f = array2timetable(f,'SampleRate',1/Ts,'VariableNames',varNames);
            elseif(nargin()>2)
                error(errorMessage(02));
            end
        end

    end

end