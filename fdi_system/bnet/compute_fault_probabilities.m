function [p] = compute_fault_probabilities(z)
%% Computes the probabilities based on Bayesian networks

if(get_k() == 1)
    S = load('trained_bnet.mat');
    engine = jtree_inf_engine(S.bnet);
    set_jtree_inf_engine(engine);
end

Ne = length(z); % Amount of evidences
Nf = 15; % Amount of faults
p  = zeros(Nf,1); % Probability vector of faults

evidence = [num2cell(1+z'),cell(1,Nf)];

engine = enter_evidence(get_jtree_inf_engine(),evidence);

marg = cell(1,Nf);

for i = 1 : Nf
    marg{i} = marginal_nodes(engine,Ne+i);
    p(i) = marg{i}.T(2);
end
