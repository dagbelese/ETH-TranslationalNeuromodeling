%% GLM try

load PEs.mat
load MMN_Placebo.mat
load stimulus_sequence.mat

%%
ind_dev = find_deviant(tones);
pe = [[0 0];pe];
pe_dev = pe(ind_dev==1,:);
eps_2 = pe_dev(:,1);    % low-level PE
eps_3 = abs(pe_dev(:,2));   % high-level PE

% pla
MMN_early = MMN_placebo.MMN_early;
subj = squeeze(MMN_early(2,:,:));
mmn_early_dev = subj(:,ind_dev==1);

[b,dev,stats] = glmfit(mmn_early_dev',eps_2,"normal");
eps_2_hat = glmval(b,mmn_early_dev',"identity");

figure
plot(1:119,eps_2)
hold on
plot(eps_2_hat)
legend('eps_2','eps_2 hat')

%%

