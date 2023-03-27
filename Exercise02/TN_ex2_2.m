%% Translational Neuromodeling Exercise 2.2
% (a)
% tapas_fitModel(...) - fits models to observed responses
% tapas_simModel(...) - simulates the trajectories of perceptual states and
% responses

% (b)
% Parameter setting
kappa2 = 1;
omega2 = -4;
omega3 = -6;
theta = exp(omega3);

num_trials = 320;
u = zeros(num_trials+1, 1);
s = zeros(num_trials+1, 1);
x2 = zeros(num_trials+1,1);
x3 = ones(num_trials+1, 1);

for i=1:num_trials
    x3(i+1) = x3(i) + sqrt(theta)*randn(1);

    x2(i+1) = x2(i) + exp(kappa2*x3(i+1)+omega2)*randn(1);

    s(i+1) = 1/(1+exp(-x2(i+1)));

    u(i+1) = round(s(i+1));
end

% Plot traces
figure;
subplot(3, 1, 1);
plot(1:num_trials+1, x3);
title('x3');
subplot(3, 1, 2);
plot(1:num_trials+1, x2);
title('x2');
subplot(3, 1, 3);
plot(1:num_trials+1, u);
title('u');

% (c)
sim = tapas_simModel(u,...
                     'tapas_hgf_binary',...
                     [NaN 0 1 NaN 1 1 NaN 0 0 1 1 NaN -4 -6],...
                     'tapas_unitsq_sgm',...
                     5);

tapas_hgf_binary_plotTraj(sim)

% We can observe that the simulated traces of x3 and x2 track the 
% trends of the generated traces, indicating that the simulated agent is
% able to track the evolution of x3 and x2. The responses r also closely track 
% the input sequence u, although there are some differences due to the 
% randomness introduced in the perceptual and response models. 

% (d)
% Using the generative model of the hgf to generate stimulus sequences for 
% an experiment might not be a good idea because the model assumes certain 
% simplifying assumptions about the generative process that may not hold 
% in real-world situations. For instance, the model assumes that the sensory 
% inputs are generated solely based on the current hidden state of the system, 
% which might not be true in practice. Additionally, the model assumes 
% that the hidden states are independent of each other, which might not 
% be the case in real-world systems.

% However, the generative model of the hgf can still be a useful model 
% for the agent to invert during perception. In other words, given sensory 
% inputs, the model can help infer the most likely hidden states that 
% generated the inputs. This can be useful in many contexts, such as in 
% understanding how humans make perceptual judgments or in developing 
% machine learning algorithms that can make sense of complex sensory data.
