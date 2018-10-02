function [varargout] = import_from_ws(varargin)

n = nargin();

for i = 1 : n
    
    varargout{i} = evalin('base',varargin{i});
    
end