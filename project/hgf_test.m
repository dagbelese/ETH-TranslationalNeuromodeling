%% HGF attempt

cd /Users/liyitong/Documents/Frühlingssemester-2023/TN
addpath TranslationalNeuromodelling/Information/paradigm/
addpath tapas-master/HGF/

load stimulus_sequence.mat
u = tones';

%%

hgf_binary_config = tapas_hgf_binary_config()
unitsq_sgm_config = tapas_unitsq_sgm_config()
optim_config = tapas_quasinewton_optim_config()

% mus
hgf_binary_config.mu_0mu = [NaN, 0, 0];
hgf_binary_config.mu_0sa = [NaN, 0, 0]; % fixed

% sigmas
hgf_binary_config.logsa_0mu = [NaN,   log(1), log(1)];
hgf_binary_config.logsa_0sa = [NaN,          0,      0.00001];

% omegas
hgf_binary_config.ommu = [NaN,  -2.5,  log(0.12)]; % omega3 = log(theta)
%hgf_binary_config.omsa = [NaN, 5^2, 0.088^2];
hgf_binary_config.omsa = [NaN, 4^2, 0.1^2];

% kappas
hgf_binary_config.logkamu = [log(1), log(1.2)];
hgf_binary_config.logkasa = [     0,   0.01];

bopars = tapas_fitModel([],...
                         u,...
                         'tapas_hgf_binary_config',...
                         'tapas_bayes_optimal_binary_config',...
                         'tapas_quasinewton_optim_config');

%%
sim = tapas_simModel(u,...
                     'tapas_hgf_binary',...
                     [NaN 0 0 NaN 1 1.5 NaN 0 0 1 2.8 NaN -2.5 log(0.025)],...
                     'tapas_unitsq_sgm',...
                     5,...
                     123456789);

tapas_hgf_binary_plotTraj(sim)

%%
est = tapas_fitModel(sim.y, sim.u, hgf_binary_config, unitsq_sgm_config, optim_config);

tapas_fit_plotCorr(est)

%%
cd TranslationalNeuromodelling/
fn = "HGF_sim_traj";
save(fn,"sim")

%%
belief = sim.traj.mu;
pe = diff(belief);
pe = pe(:,2:3);
figure
subplot(211)
plot(abs(pe(:,1)))
title('low level pe')
subplot(212)
plot(abs(pe(:,2)))
title('high level pe')