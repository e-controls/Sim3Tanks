function [w] = get_process_noise(wnprocess)

% White noise
w  = random('norm',wnprocess(1),wnprocess(2),[3 1]); % Process noise

end