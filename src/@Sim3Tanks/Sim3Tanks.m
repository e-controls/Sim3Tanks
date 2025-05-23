classdef Sim3Tanks < handle
    % Sim3Tanks is the class used to define the system configurations.

    % https://github.com/e-controls/Sim3Tanks

    %======================================================================

    properties (Access = public, Hidden = true, Constant = true)

        % The sequential order of the cell elements must be maintained!
        LIST_OF_FIELDS = ...
            {'PhysicalParam';'ValveSettings';'FaultSettings';...
            'ProcessNoise';'MeasurementNoise';'InitialCondition'};
        LIST_OF_PARAM  = ...
            {'TankRadius';'TankHeight';'PipeRadius';'TransPipeHeight';...
            'CorrectionTerm';'GravityConstant';'PumpMinFlow';'PumpMaxFlow'};
        LIST_OF_VALVES = ...
            {'Kp1';'Kp2';'Kp3';'Ka';'Kb';'K13';'K23';'K1';'K2';'K3'};
        LIST_OF_FAULTS = ...
            {'f1';'f2';'f3';'f4';'f5';'f6';'f7';'f8';'f9';'f10';'f11';'f12';...
            'f13';'f14';'f15';'f16';'f17';'f18';'f19';'f20';'f21';'f22';'f23'};
        LIST_OF_STATES = ...
            {'h1';'h2';'h3'};
        LIST_OF_FLOWS  = ...
            {'Q1in';'Q2in';'Q3in';'Qa';'Qb';'Q13';'Q23';'Q1';'Q2';'Q3'};

    end

    %======================================================================

    properties (Access = private, Hidden = true)
        SimulationTime {mustBeFinite,mustBeNonnegative} = [];
        StateVariables {mustBeFinite,mustBeNonnegative} = [];
        FlowVariables  {mustBeFinite} = [];
        SensorMeasurements {mustBeFinite} = [];
        ValveSignals {mustBeGreaterThanOrEqual(ValveSignals,0),mustBeLessThanOrEqual(ValveSignals,1)} = [];
        FaultMagnitudes {mustBeGreaterThanOrEqual(FaultMagnitudes,0),mustBeLessThanOrEqual(FaultMagnitudes,1)} = [];
        FaultOffsets {mustBeFinite} = [];
    end

    %======================================================================

    properties (Access = public, Hidden = true)

        About = [];

    end

    properties (Access = public, Hidden = false)

        Model = [];

    end

    %======================================================================

    methods % Class Constructor

        function obj = Sim3Tanks(varargin)
            % Check input arguments
            if(nargin()~=0)
                error(getMessage('ERR002'));
            end
            obj.prepareModel();
        end

    end

    %======================================================================

    methods (Access = private, Hidden = true) % Prepare method

        function prepareModel(this)

            % PhysicalParam
            for i = 1 : numel(this.LIST_OF_PARAM)
                this.Model.(this.LIST_OF_FIELDS{1}).(this.LIST_OF_PARAM{i}) = [];
            end

            % ValveSettings
            for i = 1 : numel(this.LIST_OF_VALVES)
                this.Model.(this.LIST_OF_FIELDS{2}).(this.LIST_OF_VALVES{i}).OperationMode = 'Closed';
                this.Model.(this.LIST_OF_FIELDS{2}).(this.LIST_OF_VALVES{i}).EnableControl = false;
                this.Model.(this.LIST_OF_FIELDS{2}).(this.LIST_OF_VALVES{i}).OpeningRate = [];
            end

            % FaultSettings (Magnitudes)
            for i = 1 : numel(this.LIST_OF_FAULTS)
                this.Model.(this.LIST_OF_FIELDS{3}).(this.LIST_OF_FAULTS{i}).EnableSignal = false;
                this.Model.(this.LIST_OF_FIELDS{3}).(this.LIST_OF_FAULTS{i}).Magnitude = [];
            end

            % FaultSettings (Offsets)
            for i = 11 : numel(this.LIST_OF_FAULTS)
                this.Model.(this.LIST_OF_FIELDS{3}).(this.LIST_OF_FAULTS{i}).Offset = [];
            end

            % ProcessNoise
            this.Model.(this.LIST_OF_FIELDS{4}).EnableSignal = false;
            this.Model.(this.LIST_OF_FIELDS{4}).Magnitude = [];

            % MeasurementNoise
            this.Model.(this.LIST_OF_FIELDS{5}).EnableSignal = false;
            this.Model.(this.LIST_OF_FIELDS{5}).Magnitude = [];

            % InitialCondition
            this.Model.(this.LIST_OF_FIELDS{6}) = [];

            % Initializing simulation time
            this.SimulationTime = 0;

        end

    end

    %======================================================================

    methods (Access = private, Hidden = true) % Setter methods

        function setInternalStateVariables(this,x)
            N = numel(this.LIST_OF_STATES);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(x) && ~isempty(x))
                error(getMessage('ERR005'));
            elseif(numel(x)~=N && ~isempty(x))
                error([getMessage('ERR006'),' The system has ',num2str(N),' state variables.']);
            end
            this.StateVariables = x;
        end

        function setInternalFlowVariables(this,q)
            N = numel(this.LIST_OF_FLOWS);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(q) && ~isempty(q))
                error(getMessage('ERR005'));
            elseif(numel(q)~=N && ~isempty(q))
                error([getMessage('ERR006'),' The system has ',num2str(N),' flow variables.']);
            end
            this.FlowVariables = q;
        end

        function setInternalSensorMeasurements(this,y)
            N = numel(this.LIST_OF_STATES) + numel(this.LIST_OF_FLOWS);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(y) && ~isempty(y))
                error(getMessage('ERR005'));
            elseif(numel(y)~=N && ~isempty(y))
                error([getMessage('ERR006'),' The system has ',num2str(N),' measured variables.']);
            end
            this.SensorMeasurements = y;
        end

        function setInternalValveSignals(this,v)
            N = numel(this.LIST_OF_VALVES);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(v) && ~isempty(v))
                error(getMessage('ERR005'));
            elseif(numel(v)~=N && ~isempty(v))
                error([getMessage('ERR006'),' The system has ',num2str(N),' valves.']);
            end
            this.ValveSignals = v;
        end

        function setInternalFaultMagnitudes(this,f)
            N = numel(this.LIST_OF_FAULTS);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(f) && ~isempty(f))
                error(getMessage('ERR005'));
            elseif(numel(f)~=N && ~isempty(f))
                error([getMessage('ERR006'),' The system has ',num2str(N),' fault magnitudes.']);
            end
            this.FaultMagnitudes = f;
        end

        function setInternalFaultOffsets(this,f)
            N = numel(this.LIST_OF_FAULTS(11:end));
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(f) && ~isempty(f))
                error(getMessage('ERR005'));
            elseif(numel(f)~=N && ~isempty(f))
                error([getMessage('ERR006'),' The system has ',num2str(N),' fault offsets.']);
            end
            this.FaultOffsets = f;
        end

    end

    %======================================================================

    methods (Access = private, Hidden = true) % Pusher methods

        function pushInternalStateVariables(this,x)
            N = numel(this.LIST_OF_STATES);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(x) && ~isempty(x))
                error(getMessage('ERR005'));
            elseif(numel(x)~=N && ~isempty(x))
                error([getMessage('ERR006'),' The system has ',num2str(N),' state variables.']);
            end
            this.StateVariables = [this.StateVariables;x];
        end

        function pushInternalFlowVariables(this,q)
            N = numel(this.LIST_OF_FLOWS);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(q) && ~isempty(q))
                error(getMessage('ERR005'));
            elseif(numel(q)~=N && ~isempty(q))
                error([getMessage('ERR006'),' The system has ',num2str(N),' flow variables.']);
            end
            this.FlowVariables = [this.FlowVariables;q];
        end

        function pushInternalSensorMeasurements(this,y)
            N = numel(this.LIST_OF_STATES) + numel(this.LIST_OF_FLOWS);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(y) && ~isempty(y))
                error(getMessage('ERR005'));
            elseif(numel(y)~=N && ~isempty(y))
                error([getMessage('ERR006'),' The system has ',num2str(N),' measured variables.']);
            end
            this.SensorMeasurements = [this.SensorMeasurements;y];
        end

        function pushInternalValveSignals(this,v)
            N =numel(this.LIST_OF_VALVES);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(v) && ~isempty(v))
                error(getMessage('ERR005'));
            elseif(numel(v)~=N && ~isempty(v))
                error([getMessage('ERR006'),' The system has ',num2str(N),' valves.']);
            end
            this.ValveSignals = [this.ValveSignals;v];
        end

        function pushInternalFaultMagnitudes(this,f)
            N = numel(this.LIST_OF_FAULTS);
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(f) && ~isempty(f))
                error(getMessage('ERR005'));
            elseif(numel(f)~=N && ~isempty(f))
                error([getMessage('ERR006'),' The system has ',num2str(N),' fault magnitudes.']);
            end
            this.FaultMagnitudes = [this.FaultMagnitudes;f];
        end

        function pushInternalFaultOffsets(this,f)
            N = numel(this.LIST_OF_FAULTS(11:end));
            if(nargin()==1)
                error(getMessage('ERR001'));
            elseif(~isrow(f) && ~isempty(f))
                error(getMessage('ERR005'));
            elseif(numel(f)~=N && ~isempty(f))
                error([getMessage('ERR006'),' The system has ',num2str(N),' fault offsets.']);
            end
            this.FaultOffsets = [this.FaultOffsets;f];
        end

    end

    %======================================================================

    methods (Access = private, Hidden = true) % Getter methods

        function x = getInternalStateVariables(varargin)
            this = varargin{1};
            x = this.StateVariables;
            if(nargin()==2 && ~isempty(x))
                t = varargin{2};
                varNames = this.LIST_OF_STATES;
                x = array2timetable(x,'RowTimes',seconds(t),'VariableNames',varNames);
            elseif(nargin()>2)
                error(getMessage('ERR002'));
            end
        end

        function q = getInternalFlowVariables(varargin)
            this = varargin{1};
            q = this.FlowVariables;
            if(nargin()==2 && ~isempty(q))
                t = varargin{2};
                varNames = this.LIST_OF_FLOWS;
                q = array2timetable(q,'RowTimes',seconds(t),'VariableNames',varNames);
            elseif(nargin()>2)
                error(getMessage('ERR002'));
            end
        end

        function y = getInternalSensorMeasurements(varargin)
            this = varargin{1};
            y = this.SensorMeasurements;
            if(nargin()==2 && ~isempty(y))
                t = varargin{2};
                varNames = [this.LIST_OF_STATES;this.LIST_OF_FLOWS];
                y = array2timetable(y,'RowTimes',seconds(t),'VariableNames',varNames);
            elseif(nargin()>2)
                error(getMessage('ERR002'));
            end
        end

        function v = getInternalValveSignals(varargin)
            this = varargin{1};
            v = this.ValveSignals;
            if(nargin()==2 && ~isempty(v))
                t = varargin{2};
                varNames = this.LIST_OF_VALVES;
                v = array2timetable(v,'RowTimes',seconds(t),'VariableNames',varNames);
            elseif(nargin()>2)
                error(getMessage('ERR002'));
            end
        end

        function f = getInternalFaultMagnitudes(varargin)
            this = varargin{1};
            f = this.FaultMagnitudes;
            if(nargin()==2 && ~isempty(f))
                t = varargin{2};
                varNames = this.LIST_OF_FAULTS;
                f = array2timetable(f,'RowTimes',seconds(t),'VariableNames',varNames);
            elseif(nargin()>2)
                error(getMessage('ERR002'));
            end
        end

        function f = getInternalFaultOffsets(varargin)
            this = varargin{1};
            f = this.FaultOffsets;
            if(nargin()==2 && ~isempty(f))
                t = varargin{2};
                varNames = this.LIST_OF_FAULTS(11:end);
                f = array2timetable(f,'RowTimes',seconds(t),'VariableNames',varNames);
            elseif(nargin()>2)
                error(getMessage('ERR002'));
            end
        end

    end

    %======================================================================

    methods (Access = private, Hidden = true) % Time methods

        function resetInternalSimulationTime(varargin)
            if(nargin()>1)
                error(getMessage('ERR002'));
            end
            this = varargin{1};
            this.SimulationTime = 0;
        end

        function incrementInternalSimulationTime(varargin)
            if(nargin()<2)
                error(getMessage('ERR001'));
            end
            this = varargin{1};
            time = varargin{2};
            this.SimulationTime = [this.SimulationTime;time];
        end

        function t = getInternalSimulationTime(varargin)
            this = varargin{1};
            t = this.SimulationTime;
            if(nargin()==2)
                t = t(varargin{2});
            elseif(nargin()>2)
                error(getMessage('ERR002'));
            end
        end

    end

end