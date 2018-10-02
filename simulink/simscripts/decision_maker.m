function decision_maker(block)

setup(block);

end

function setup(block)

block.NumInputPorts = 8;
block.NumOutputPorts = 1;

block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

Ts = get_sample_time();

block.SampleTimes = [Ts 0];

block.SetAccelRunOnTLC(true);
block.RegBlockMethod('Outputs',@Output);
block.RegBlockMethod('SetInputPortSamplingMode',@SetInputPortSamplingMode);
block.RegBlockMethod('SetInputPortDimensions',@SetInputPortDimensions);

end

function SetInputPortDimensions(block, ~, ~)

block.InputPort(1).Dimensions  = 1; % z1
block.InputPort(2).Dimensions  = 1; % z2
block.InputPort(3).Dimensions  = 1; % z3
block.InputPort(4).Dimensions  = 1; % z4
block.InputPort(5).Dimensions  = 1; % z5
block.InputPort(6).Dimensions  = 1; % z6
block.InputPort(7).Dimensions  = 1; % z7
block.InputPort(8).Dimensions  = 1; % z8

block.OutputPort(1).Dimensions = 15; % p

end

function SetInputPortSamplingMode(block, ~, ~)

block.InputPort(1).SamplingMode  = 'Sample'; % z1
block.InputPort(2).SamplingMode  = 'Sample'; % z2
block.InputPort(3).SamplingMode  = 'Sample'; % z3
block.InputPort(4).SamplingMode  = 'Sample'; % z4
block.InputPort(5).SamplingMode  = 'Sample'; % z5
block.InputPort(6).SamplingMode  = 'Sample'; % z6
block.InputPort(7).SamplingMode  = 'Sample'; % z7
block.InputPort(8).SamplingMode  = 'Sample'; % z8

block.OutputPort(1).SamplingMode = 'Sample'; % p

end

function Output(block)

z1 = block.InputPort(1).Data;
z2 = block.InputPort(2).Data;
z3 = block.InputPort(3).Data;
z4 = block.InputPort(4).Data;
z5 = block.InputPort(5).Data;
z6 = block.InputPort(6).Data;
z7 = block.InputPort(7).Data;
z8 = block.InputPort(8).Data;

z = [z1 z2 z3 z4 z5 z6 z7 z8]'; % Threshold crossing vector

% Decision maker based on bayesian network
p = compute_fault_probabilities(z); % Vector of fault Probabilities

block.OutputPort(1).Data = p;

end