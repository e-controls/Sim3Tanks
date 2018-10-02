function [c] =  get_color(color)

normal = [102 205 170]/255;
fault  = [255 127 080]/255;
closed = [119 136 153]/255;
open   = [205 201 201]/255;
step   = [205 201 201]/255;
drift  = [238 233 233]/255;
blue   = [.70 0.78 1];
white  = [ 1   1   1];

switch lower(color)
    case 'normal'
        c = normal;
    case 'fault'
        c = fault;
    case 'open'
        c = open;
    case 'closed'
        c = closed;
    case 'step'
        c = step;
    case 'drift'
        c = drift;
    case 'b'
        c = blue;
    case 'w'
        c = white;
    otherwise
        c = 'default';
end