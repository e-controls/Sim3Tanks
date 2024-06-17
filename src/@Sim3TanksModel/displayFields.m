function displayFields(varargin)
% displayFields is a Sim3Tanks method. This method displays all fields and
% subfields of a Sim3Tanks object.

% Written by Arllem Farias, May/2024.
% Last update Jun/2024 by Arllem Farias.

%==========================================================================

if(nargin()==1)
    structVar = varargin{1}.Model;
elseif(nargin()==2 && isa(varargin{2},'struct'))
    structVar = varargin{2};
else
    error(errorMessage(02));
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
        displayFields(varargin{1},fieldValue);

    elseif(isThereSubfield)
        fprintf('\n%s<strong>%s</strong>: %s (%s)\n', PREFIX1, ...
            currentField, mat2str(fieldValue), fieldType);
    else
        fprintf('\t%s%s: %s (%s)\n', PREFIX2, ...
            currentField, mat2str(fieldValue), fieldType);
    end

end
