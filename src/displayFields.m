function [] = displayFields(varargin)
% displayFields is a Sim3Tanks function. This function displays all fields
% and subfields of a Sim3Tanks object.

% Written by Arllem Farias, May/2024.
% Last update Jun/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(errorMessage(01));
elseif(nargin()>1)
    error(errorMessage(02));
end

%==========================================================================

structVar = varargin{1};

fields = fieldnames(structVar);
isThereSubfield = false;
PREFIX = '|--';

for i = 1 : numel(fields)
    currentField = fields{i};
    fieldValue = structVar.(currentField);
    fieldType  = class(fieldValue);

    if(isstruct(fieldValue))
        isThereSubfield = true;
        fprintf('\n%s<strong>%s</strong> (Struct)\n', PREFIX, currentField);
        displayFields(fieldValue);

    elseif(isThereSubfield)
        fprintf('\n%s<strong>%s</strong>: %s (%s)\n', PREFIX, ...
            currentField, mat2str(fieldValue), fieldType);
    else
        fprintf('\t%s%s: %s (%s)\n', PREFIX, ...
            currentField, mat2str(fieldValue), fieldType);
    end

end

end