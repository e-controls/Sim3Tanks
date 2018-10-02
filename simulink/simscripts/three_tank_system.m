function three_tank_system(block)

Ts = num2str(get_sample_time());

step = find_system(bdroot,'BlockType','Step');

if ~isempty(step)
    for i = 1 : length(step)
        set_param(char(step(i)),'SampleTime',Ts);
    end
end

noise = find_system(bdroot,'BlockType','RandomNumber');

if ~isempty(noise)
    for i = 1 : length(noise)
        set_param(char(noise(i)),'SampleTime',Ts);
    end
end

constant = find_system(bdroot,'BlockType','Constant');

if ~isempty(constant)
    for i = 1 : length(constant)
        set_param(char(constant(i)),'SampleTime',Ts);
    end
end

fromws = find_system(bdroot,'BlockType','FromWorkspace');

if ~isempty(fromws)
    for i = 1 : length(fromws)
        set_param(char(fromws(i)),'SampleTime',Ts);
    end
end

set_k(0);

setup(block);

end

function setup(block)

block.NumInputPorts = 6;
block.NumOutputPorts = 12;

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

block.InputPort(1).Dimensions = 21; % f
block.InputPort(2).Dimensions = 03; % w
block.InputPort(3).Dimensions = 12; % v
block.InputPort(4).Dimensions = 03; % x0
block.InputPort(5).Dimensions = 01; % u1
block.InputPort(6).Dimensions = 01; % u2

block.OutputPort(1).Dimensions  = 1; % Level h1 measured
block.OutputPort(2).Dimensions  = 1; % Level h2 measured
block.OutputPort(3).Dimensions  = 1; % Level h3 measured
block.OutputPort(4).Dimensions  = 1; % Flow u1 measured
block.OutputPort(5).Dimensions  = 1; % Flow u2 measured
block.OutputPort(6).Dimensions  = 1; % Flow Qa measured
block.OutputPort(7).Dimensions  = 1; % Flow Qb measured
block.OutputPort(8).Dimensions  = 1; % Flow Q13 measured
block.OutputPort(9).Dimensions  = 1; % Flow Q23 measured
block.OutputPort(10).Dimensions = 1; % Flow Q1 measured
block.OutputPort(11).Dimensions = 1; % Flow Q2 measured
block.OutputPort(12).Dimensions = 1; % Flow Q3 measured

end

function SetInputPortSamplingMode(block, ~, ~)

block.InputPort(1).SamplingMode = 'Sample'; % f
block.InputPort(2).SamplingMode = 'Sample'; % w
block.InputPort(3).SamplingMode = 'Sample'; % v
block.InputPort(4).SamplingMode = 'Sample'; % x0
block.InputPort(5).SamplingMode = 'Sample'; % u1
block.InputPort(6).SamplingMode = 'Sample'; % u2

block.OutputPort(1).SamplingMode  = 'Sample'; % Level h1 measured
block.OutputPort(2).SamplingMode  = 'Sample'; % Level h2 measured
block.OutputPort(3).SamplingMode  = 'Sample'; % Level h3 measured
block.OutputPort(4).SamplingMode  = 'Sample'; % Flow u1 measured
block.OutputPort(5).SamplingMode  = 'Sample'; % Flow u2 measured
block.OutputPort(6).SamplingMode  = 'Sample'; % Flow Qa measured
block.OutputPort(7).SamplingMode  = 'Sample'; % Flow Qb measured
block.OutputPort(8).SamplingMode  = 'Sample'; % Flow Q13 measured
block.OutputPort(9).SamplingMode  = 'Sample'; % Flow Q23 measured
block.OutputPort(10).SamplingMode  = 'Sample'; % Flow Q1 measured
block.OutputPort(11).SamplingMode  = 'Sample'; % Flow Q2 measured
block.OutputPort(12).SamplingMode  = 'Sample'; % Flow Q3 measured

end

function Output(block)

set_k(get_k()+1);

f  = block.InputPort(1).Data;
w  = block.InputPort(2).Data;
v  = block.InputPort(3).Data;
x0 = block.InputPort(4).Data;
u1 = block.InputPort(5).Data;
u2 = block.InputPort(6).Data;
u  = [u1 u2]';

y = three_tank_system_simulator(x0, u, f, w, v);

block.OutputPort(1).Data  = y(1);
block.OutputPort(2).Data  = y(2);
block.OutputPort(3).Data  = y(3);
block.OutputPort(4).Data  = y(4);
block.OutputPort(5).Data  = y(5);
block.OutputPort(6).Data  = y(6);
block.OutputPort(7).Data  = y(7);
block.OutputPort(8).Data  = y(8);
block.OutputPort(9).Data  = y(9);
block.OutputPort(10).Data = y(10);
block.OutputPort(11).Data = y(11);
block.OutputPort(12).Data = y(12);

end