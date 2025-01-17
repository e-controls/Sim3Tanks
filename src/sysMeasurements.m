function y = sysMeasurements(x,q,faultMag,offset,mNoise)
% sysMeasurements is a Sim3Tanks function. This function describes the
% level and flow measurements of the three-tank system through sensors.
%
% Example:
%   y = sysMeasurements(x,q,faultMag,offset,mNoise);
%           x : state vector
%           q : flow rate vector
%    faultMag : fault magnitude vector
%      offset : fault offset vector
%      mNoise : measurement noise vector

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<5)
    error(getMessage('ERR001'));
elseif(nargin()>5)
    error(getMessage('ERR002'));
end

%==========================================================================

N = numel(Sim3Tanks.LIST_OF_VALVES);

y = [x , q]; % [h1,h2,h3,Q1in,Q2in,Q3in,Qa,Qb,Q13,Q23,Q1,Q2,Q3]

for i = 1 : numel(y)
    j = N + i;
    if(faultMag(j) ~= 1)
        y(i) = (1-faultMag(j))*y(i) + offset(j) + mNoise(i);
    else
        y(i) = 0; % Could it be a NaN?
    end
end