function [v] = get_output_noise(wnlevel, wnflow)

% White noise
vx = random('norm',wnlevel(1),wnlevel(2),[3 1]); % Output noise for level sensors
vq = random('norm',wnflow(1), wnflow(2), [9 1]); % Output noise for flow sensors
v  = [vx ; vq]; % Output noise

end