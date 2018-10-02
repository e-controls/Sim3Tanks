function [] = export_to_ws(varargin)

n = nargin();

for i = 1 : 2 : n
    
    name = varargin{i};
    var  = varargin{i+1};
    assignin('base', name, var);
    
end