function displayModel(varargin)
% displayModel is a Sim3Tanks method. This method does not have an input
% argument. It displays the model settings of a Sim3Tanks object on the
% command line.
%
% Example:
%   tts.displayModel();

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()==1)
    structVar = varargin{1}.Model;
elseif(nargin()==2 && isa(varargin{2},'struct'))
    structVar = varargin{2};
else
    error(getMessage('ERR002'));
end

%==========================================================================

fields = fieldnames(structVar);
isThereSubfield = false;
PREFIX1 = '+-- ';
PREFIX2 = 'O-- ';

for i = 1 : numel(fields)
    currentField = fields{i};
    fieldValue = structVar.(currentField);
    fieldType  = class(fieldValue);

    if(isstruct(fieldValue))
        isThereSubfield = true;
        fprintf('\n%s<strong>%s</strong> (Struct)\n', PREFIX1, currentField);
        displayModel(varargin{1},fieldValue);

    elseif(isThereSubfield)
        fprintf('\n%s<strong>%s</strong>: %s (%s)\n', PREFIX1, ...
            currentField, mat2str(fieldValue), fieldType);
    else
        fprintf('\t%s%s: %s (%s)\n', PREFIX2, ...
            currentField, mat2str(fieldValue), fieldType);
    end

end
