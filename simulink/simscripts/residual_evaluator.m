function residual_evaluator(block)

setup(block);

end

function setup(block)

block.NumInputPorts = 8;
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

block.InputPort(1).Dimensions  = 1; % r1
block.InputPort(2).Dimensions  = 1; % r2
block.InputPort(3).Dimensions  = 1; % r3
block.InputPort(4).Dimensions  = 1; % r4
block.InputPort(5).Dimensions  = 1; % r5
block.InputPort(6).Dimensions  = 1; % r6
block.InputPort(7).Dimensions  = 1; % r7
block.InputPort(8).Dimensions  = 1; % r8

block.OutputPort(1).Dimensions  = 1; % z1
block.OutputPort(2).Dimensions  = 1; % z2
block.OutputPort(3).Dimensions  = 1; % z3
block.OutputPort(4).Dimensions  = 1; % z4
block.OutputPort(5).Dimensions  = 1; % z5
block.OutputPort(6).Dimensions  = 1; % z6
block.OutputPort(7).Dimensions  = 1; % z7
block.OutputPort(8).Dimensions  = 1; % z8

end

function SetInputPortSamplingMode(block, ~, ~)

block.InputPort(1).SamplingMode  = 'Sample'; % r1
block.InputPort(2).SamplingMode  = 'Sample'; % r2
block.InputPort(3).SamplingMode  = 'Sample'; % r3
block.InputPort(4).SamplingMode  = 'Sample'; % r4
block.InputPort(5).SamplingMode  = 'Sample'; % r5
block.InputPort(6).SamplingMode  = 'Sample'; % r6
block.InputPort(7).SamplingMode  = 'Sample'; % r7
block.InputPort(8).SamplingMode  = 'Sample'; % r8

block.OutputPort(1).SamplingMode = 'Sample'; % z1
block.OutputPort(2).SamplingMode  = 'Sample'; % z2
block.OutputPort(3).SamplingMode  = 'Sample'; % z3
block.OutputPort(4).SamplingMode  = 'Sample'; % z4
block.OutputPort(5).SamplingMode  = 'Sample'; % z5
block.OutputPort(6).SamplingMode  = 'Sample'; % z6
block.OutputPort(7).SamplingMode  = 'Sample'; % z7
block.OutputPort(8).SamplingMode  = 'Sample'; % z8
end

function Output(block)

r1 = block.InputPort(1).Data;
r2 = block.InputPort(2).Data;
r3 = block.InputPort(3).Data;
r4 = block.InputPort(4).Data;
r5 = block.InputPort(5).Data;
r6 = block.InputPort(6).Data;
r7 = block.InputPort(7).Data;
r8 = block.InputPort(8).Data;

residue = [r1 r2 r3 r4 r5 r6 r7 r8]';

% GLR-Based residual evaluation
meanr = [0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0]'; % Mean of the residues in a fault-free scenario
stdr  = [0.3  0.3  0.3  2.5  2.5  1.5  1.5  1.5]'; % Standard deviation of the residues in a fault-free scenario
thr   = [20   20   20   40   40   20   20   20 ]'; % Thresholds for a fault-free scenario

datawindow = 20; % Data window length

g = glr_decision_func(residue,meanr,stdr,datawindow); % Decision function response of GLR method
g = mysaturation(g,zeros(size(thr)),1.5*thr); % Saturation of g(k)

z = glr_check_threshold(g,thr); % Threshold crossing vector => if g(i)>thr(i), then z(i)=1, otherwise, z(i)=0 (i=1,2,3,...,8)

block.OutputPort(1).Data  = z(1);
block.OutputPort(2).Data  = z(2);
block.OutputPort(3).Data  = z(3);
block.OutputPort(4).Data  = z(4);
block.OutputPort(5).Data  = z(5);
block.OutputPort(6).Data  = z(6);
block.OutputPort(7).Data  = z(7);
block.OutputPort(8).Data  = z(8);

end