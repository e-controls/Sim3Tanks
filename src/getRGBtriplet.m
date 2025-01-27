function [varargout] = getRGBtriplet(varargin)
% getRGBtriplet is a Sim3Tanks function. This function returns the RGB
% triplet associated with a tag.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<1)
    error(getMessage('ERR001'));
elseif(nargin()>1)
    error(getMessage('ERR002'));
end

%==========================================================================

% RGB Triplet
LIST_OF_COLORS = {...
    'normal', [102 205 170]/255;...
    'fault' , [255 127 080]/255;...
    'closed', [119 136 153]/255;...
    'open'  , [205 201 201]/255;...
    'step'  , [205 201 201]/255;...
    'drift' , [238 233 233]/255;...
    'blue'  , [179 199 255]/255;...
    'white' , [255 255 255]/255;...
    };

option = find(strcmpi(varargin{1},LIST_OF_COLORS),1);

if(isempty(option))
    error(getMessage('ERR003'));
end

varargout{1} = LIST_OF_COLORS{option,2};

end