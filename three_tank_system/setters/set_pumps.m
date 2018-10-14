function [] = set_pumps(PFLOW,PSTART,PSTOP)
% SET_PUMPS(PFLOW,PSTART,PSTOP) sets the flow rate from the pumps P1 and P2.
% All input arguments are column vectors with two positions. For example, if:
%   • PFLOW  = [QP1 ; QP2],
%   • PSTART = [TI1 ; TI2],
%   • PSTOP  = [TF1 ; TF2],
% then pump P1 has maximum flow QP1, turns on at TI1, and turns off at TF1;
% and pump P2 has maximum flow QP2, turns on at TI2, and turns off at TF2.
%
% If PSTART and PSTOP are omitted from the input arguments, then any flow
% signal can be defined by the user. In this case, PFLOW must have
% dimension 2-by-N, where N is the number of samples. For example:
%
%   PFLOW = [QP1(k=0), QP1(k=1), QP1(k=2), QP1(k=3), ..., QP1(k=N);...
%            QP2(k=0), QP2(k=1), QP2(k=2), QP2(k=3), ..., QP2(k=N)];
%
% This function does not have output arguments.
%
% See also GET_PUMPS.

% Written by Arllem Farias, 2018.

global pumps;

if(nargin()==1)
    pumps = PFLOW;
else
    time = get_time();
    M = length(PFLOW);
    N = length(time);
    
    pumps = zeros(M,N);
    
    for i = 1 : M % For each pump
        if(PFLOW(i) >= 0)
            for j = 1 : N % For each sample
                if(time(j) >= PSTART(i) && time(j) <= PSTOP(i))
                    pumps(i,j) = PFLOW(i);
                end
            end
        end
    end
end