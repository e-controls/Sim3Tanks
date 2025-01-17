function Qx = sysFlowRates(x,K,h0,Beta)
% sysFlowRates is a Sim3Tanks function. This function describes the flow
% equations of the three-tank system.
%
% Example:
%   Qx = sysFlowRates(x,K,h0,Beta)
%       x : state vector
%       K : valve vector
%      h0 : transmission pipe height
%    Beta : constant value

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<4)
    error(getMessage('ERR001'));
elseif(nargin()>4)
    error(getMessage('ERR002'));
end

%==========================================================================

h1 = x(1);
h2 = x(2);
h3 = x(3);

if(h1<=h0 && h2<=h0 && h3<=h0)
    % fprintf('CASE 1 : h1<=h0, h2<=h0, h3<=h0\n');
    Qa = K(4)*0;
    Qb = K(5)*0;

elseif(h1<=h0 && h2<=h0 && h3>h0)
    % fprintf('CASE 2 : h1<=h0, h2<=h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    Qb = K(5)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));

elseif(h1<=h0 && h2>h0 && h3<=h0)
    % fprintf('CASE 3 : h1<=h0, h2>h0, h3<=h0\n');
    Qa = K(4)*0;
    Qb = K(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));

elseif(h1<=h0 && h2>h0 && h3>h0)
    % fprintf('CASE 4 : h1<=h0, h2>h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    Qb = K(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));

elseif(h1>h0 && h2<=h0 && h3<=h0)
    % fprintf('CASE 5 : h1>h0, h2<=h0, h3<=h0\n');
    Qa = K(4)*Beta*sign(h1-h0)*sqrt(abs(h1-h0));
    Qb = K(5)*0;

elseif(h1>h0 && h2<=h0 && h3>h0)
    % fprintf('CASE 6 : h1>h0, h2<=h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
    Qb = K(5)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));

elseif(h1>h0 && h2>h0 && h3<=h0)
    % fprintf('CASE 7 : h1>h0, h2>h0, h3<=h0\n');
    Qa = K(4)*Beta*sign(h1-h0)*sqrt(abs(h1-h0));
    Qb = K(5)*Beta*sign(h2-h0)*sqrt(abs(h2-h0));

elseif(h1>h0 && h2>h0 && h3>h0)
    % fprintf('CASE 8 : h1>h0, h2>h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
    Qb = K(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));

else
    error(getMessage('ERR000'));
end

Q13 = K(6)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
Q23 = K(7)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));
Q1  = K(8)*Beta*sqrt(abs(h1));
Q2  = K(9)*Beta*sqrt(abs(h2));
Q3  = K(10)*Beta*sqrt(abs(h3));

Qx = [Qa,Qb,Q13,Q23,Q1,Q2,Q3];

end