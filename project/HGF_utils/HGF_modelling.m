%% simulate belief trajectory with HGF
clearvars
clc
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling
addpath tapas-master/HGF/

load stimulus_sequence.mat
u = tones';

%%
eps2_0 = 0;
eps3_0 = 1.5;
omega = -3.8;
theta = log(0.006);
sim = tapas_simModel(u,...
                     'tapas_hgf_binary',...
                     [NaN eps2_0 eps3_0 NaN 1 1.5 NaN 0 0 1 1.8 NaN omega theta],...
                     'tapas_unitsq_sgm',...
                     5,...
                     123456789);

tapas_hgf_binary_plotTraj(sim)
fn = "figures/HGF_2805.png";
saveas(gcf,fn)

%
belief = sim.traj.mu;
pe = diff(belief);
pe = pe(:,2:3);
figure
subplot(211)
scatter(1:1799,abs(pe(:,1)),'k','.')
title('HGF simulated low-level PE')
subplot(212)
scatter(1:1799,abs(pe(:,2)),'k','.')
xlabel('Deviant trial number')
ylim([0,0.12])
title('HGF simulated high-level PE')
fn = "figures/simulated_PE_2805.png";
saveas(gcf,fn)

save("HGF_data/PEs_2805","pe")