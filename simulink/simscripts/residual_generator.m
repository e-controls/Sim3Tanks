function residual_generator(block)

setup(block);

end

function setup(block)

block.NumInputPorts = 3;
block.NumOutputPorts = 8;

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

block.InputPort(1).Dimensions = 3; % xhat0
block.InputPort(2).Dimensions = 8; % yk
block.InputPort(3).Dimensions = 2; % uk

block.OutputPort(1).Dimensions  = 1; % Residue r1
block.OutputPort(2).Dimensions  = 1; % Residue r2
block.OutputPort(3).Dimensions  = 1; % Residue r3
block.OutputPort(4).Dimensions  = 1; % Residue r4
block.OutputPort(5).Dimensions  = 1; % Residue r5
block.OutputPort(6).Dimensions  = 1; % Residue r6
block.OutputPort(7).Dimensions  = 1; % Residue r7
block.OutputPort(8).Dimensions  = 1; % Residue r8

end

function SetInputPortSamplingMode(block, ~, ~)

block.InputPort(1).SamplingMode = 'Sample'; % xhat0
block.InputPort(2).SamplingMode = 'Sample'; % yk
block.InputPort(3).SamplingMode = 'Sample'; % uk

block.OutputPort(1).SamplingMode  = 'Sample'; % Residue r1
block.OutputPort(2).SamplingMode  = 'Sample'; % Residue r2
block.OutputPort(3).SamplingMode  = 'Sample'; % Residue r3
block.OutputPort(4).SamplingMode  = 'Sample'; % Residue r4
block.OutputPort(5).SamplingMode  = 'Sample'; % Residue r5
block.OutputPort(6).SamplingMode  = 'Sample'; % Residue r6
block.OutputPort(7).SamplingMode  = 'Sample'; % Residue r7
block.OutputPort(8).SamplingMode  = 'Sample'; % Residue r8

end

function Output(block)

xhat0 = block.InputPort(1).Data;
yk    = block.InputPort(2).Data;
uk    = block.InputPort(3).Data;

inov = ukf(xhat0, uk, yk); % Unscented Kalman Filter

block.OutputPort(1).Data  = inov(1);
block.OutputPort(2).Data  = inov(2);
block.OutputPort(3).Data  = inov(3);
block.OutputPort(4).Data  = inov(4);
block.OutputPort(5).Data  = inov(5);
block.OutputPort(6).Data  = inov(6);
block.OutputPort(7).Data  = inov(7);
block.OutputPort(8).Data  = inov(8);

end