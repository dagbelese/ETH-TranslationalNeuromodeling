%%% GLM1 Calculation
%% Load datasets, prediction erros and stimulus sequence
MMN_levodopa = load("selected_MMN_levodopa.mat");
MMN_galantamine = load("selected_MMN_galantamine.mat");
MMN_amisulpride = load("selected_MMN_amisulpride.mat");
MMN_biperiden = load("selected_MMN_biperiden.mat");
MMN_placebo = load("selected_MMN_placebo.mat");

MMN_levodopa = MMN_levodopa.selected_MMN_levodopa;
MMN_galantamine = MMN_galantamine.selected_MMN_galantamine;
MMN_amisulpride = MMN_amisulpride.selected_MMN_amisulpride;
MMN_biperiden = MMN_biperiden.selected_MMN_biperiden;
MMN_placebo = MMN_placebo.selected_MMN_placebo;

load PEs.mat
load stimulus_sequence.mat

%% Preprocessing for GLM 1
% Index of deviant tones
dev_idx = find_deviant(tones);
% Index of stable phase
dev_stable_idx = zeros(size(dev_idx));
dev_stable_idx(1:300) = dev_idx(1:300);
dev_stable_idx(350:450) = dev_idx(350:450);
dev_stable_idx(900:1200) = dev_idx(900:1200);
dev_stable_idx(1250:1350) = dev_idx(1250:1350);
% Index of volatile phase
dev_volatile_idx = zeros(size(dev_idx));
dev_volatile_idx(300:350) = dev_idx(300:350);
dev_volatile_idx(450:900) = dev_idx(450:900);
dev_volatile_idx(1200:1250) = dev_idx(1200:1250);
dev_volatile_idx(1350:1800) = dev_idx(1350:1800);

% Prediction erros
pe = [[0 0]; pe];
pe_stable = pe(dev_stable_idx==1, :);
pe_volatile = pe(dev_volatile_idx==1, :);
eps2_stable = pe_stable(:,1); % Low-level PE - Stable
eps3_stable = abs(pe_stable(:,2)); % High-level PE - Stable
eps2_volatile = pe_volatile(:,1); % Low-level PE - Volatile
eps3_volatile = abs(pe_volatile(:,2)); % High-level PE - Volatile

% Channel selection
channels = [1: size(MMN_levodopa.MMN_early, 2)];

%% GLM 1 Calculations
% Group Levodopa
MMN_levodopa_early_stable = squeeze(MMN_levodopa.MMN_early(:,channels,dev_stable_idx==1));
MMN_levodopa_late_stable = squeeze(MMN_levodopa.MMN_late(:,channels,dev_stable_idx==1));
levodopa_stable_MMN = cat(2, MMN_levodopa_early_stable, MMN_levodopa_late_stable);

MMN_levodopa_early_volatile = squeeze(MMN_levodopa.MMN_early(:,channels,dev_volatile_idx==1));
MMN_levodopa_late_volatile = squeeze(MMN_levodopa.MMN_late(:,channels,dev_volatile_idx==1));
levodopa_volatile_MMN = cat(2, MMN_levodopa_early_volatile, MMN_levodopa_late_volatile);

GLM_levodopa = zeros(size(levodopa_stable_MMN, 1), 4*size(levodopa_stable_MMN, 2)+4);
for i=1:size(levodopa_stable_MMN, 1)
    b_eps2_stable = glmfit(squeeze(levodopa_stable_MMN(i,:,:))', eps2_stable, 'normal');
    b_eps3_stable = glmfit(squeeze(levodopa_stable_MMN(i,:,:))', eps3_stable, 'normal');
    b_eps2_volatile = glmfit(squeeze(levodopa_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(levodopa_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_levodopa(i,:) = [b_eps2_stable; b_eps3_stable; b_eps2_volatile; b_eps3_volatile];
end

% Group Galantamine
MMN_galantamine_early_stable = squeeze(MMN_galantamine.MMN_early(:,channels,dev_stable_idx==1));
MMN_galantamine_late_stable = squeeze(MMN_galantamine.MMN_late(:,channels,dev_stable_idx==1));
galantamine_stable_MMN = cat(2, MMN_galantamine_early_stable, MMN_galantamine_late_stable);

MMN_galantamine_early_volatile = squeeze(MMN_galantamine.MMN_early(:,channels,dev_volatile_idx==1));
MMN_galantamine_late_volatile = squeeze(MMN_galantamine.MMN_late(:,channels,dev_volatile_idx==1));
galantamine_volatile_MMN = cat(2, MMN_galantamine_early_volatile, MMN_galantamine_late_volatile);

GLM_galantamine = zeros(size(galantamine_stable_MMN, 1), 4*size(galantamine_stable_MMN, 2)+4);
for i=1:size(galantamine_stable_MMN, 1)
    b_eps2_stable = glmfit(squeeze(galantamine_stable_MMN(i,:,:))', eps2_stable, 'normal');
    b_eps3_stable = glmfit(squeeze(galantamine_stable_MMN(i,:,:))', eps3_stable, 'normal');
    b_eps2_volatile = glmfit(squeeze(galantamine_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(galantamine_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_galantamine(i,:) = [b_eps2_stable; b_eps3_stable; b_eps2_volatile; b_eps3_volatile];
end

% Group Amisulpride
MMN_amisulpride_early_stable = squeeze(MMN_amisulpride.MMN_early(:,channels,dev_stable_idx==1));
MMN_amisulpride_late_stable = squeeze(MMN_amisulpride.MMN_late(:,channels,dev_stable_idx==1));
amisulpride_stable_MMN = cat(2, MMN_amisulpride_early_stable, MMN_amisulpride_late_stable);

MMN_amisulpride_early_volatile = squeeze(MMN_amisulpride.MMN_early(:,channels,dev_volatile_idx==1));
MMN_amisulpride_late_volatile = squeeze(MMN_amisulpride.MMN_late(:,channels,dev_volatile_idx==1));
amisulpride_volatile_MMN = cat(2, MMN_amisulpride_early_volatile, MMN_amisulpride_late_volatile);

GLM_amisulpride = zeros(size(amisulpride_stable_MMN, 1), 4*size(amisulpride_stable_MMN, 2)+4);
for i=1:size(amisulpride_stable_MMN, 1)
    b_eps2_stable = glmfit(squeeze(amisulpride_stable_MMN(i,:,:))', eps2_stable, 'normal');
    b_eps3_stable = glmfit(squeeze(amisulpride_stable_MMN(i,:,:))', eps3_stable, 'normal');
    b_eps2_volatile = glmfit(squeeze(amisulpride_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(amisulpride_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_amisulpride(i,:) = [b_eps2_stable; b_eps3_stable; b_eps2_volatile; b_eps3_volatile];
end

% Group Biperiden
MMN_biperiden_early_stable = squeeze(MMN_biperiden.MMN_early(:,channels,dev_stable_idx==1));
MMN_biperiden_late_stable = squeeze(MMN_biperiden.MMN_late(:,channels,dev_stable_idx==1));
biperiden_stable_MMN = cat(2, MMN_biperiden_early_stable, MMN_biperiden_late_stable);

MMN_biperiden_early_volatile = squeeze(MMN_biperiden.MMN_early(:,channels,dev_volatile_idx==1));
MMN_biperiden_late_volatile = squeeze(MMN_biperiden.MMN_late(:,channels,dev_volatile_idx==1));
biperiden_volatile_MMN = cat(2, MMN_biperiden_early_volatile, MMN_biperiden_late_volatile);

GLM_biperiden = zeros(size(biperiden_stable_MMN, 1), 4*size(biperiden_stable_MMN, 2)+4);
for i=1:size(biperiden_stable_MMN, 1)
    b_eps2_stable = glmfit(squeeze(biperiden_stable_MMN(i,:,:))', eps2_stable, 'normal');
    b_eps3_stable = glmfit(squeeze(biperiden_stable_MMN(i,:,:))', eps3_stable, 'normal');
    b_eps2_volatile = glmfit(squeeze(biperiden_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(biperiden_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_biperiden(i,:) = [b_eps2_stable; b_eps3_stable; b_eps2_volatile; b_eps3_volatile];
end

% Group Placebo
MMN_placebo_early_stable = squeeze(MMN_placebo.MMN_early(:,channels,dev_stable_idx==1));
MMN_placebo_late_stable = squeeze(MMN_placebo.MMN_late(:,channels,dev_stable_idx==1));
placebo_stable_MMN = cat(2, MMN_placebo_early_stable, MMN_placebo_late_stable);

MMN_placebo_early_volatile = squeeze(MMN_placebo.MMN_early(:,channels,dev_volatile_idx==1));
MMN_placebo_late_volatile = squeeze(MMN_placebo.MMN_late(:,channels,dev_volatile_idx==1));
placebo_volatile_MMN = cat(2, MMN_placebo_early_volatile, MMN_placebo_late_volatile);

GLM_placebo = zeros(size(placebo_stable_MMN, 1), 4*size(placebo_stable_MMN, 2)+4);
for i=1:size(placebo_stable_MMN, 1)
    b_eps2_stable = glmfit(squeeze(placebo_stable_MMN(i,:,:))', eps2_stable, 'normal');
    b_eps3_stable = glmfit(squeeze(placebo_stable_MMN(i,:,:))', eps3_stable, 'normal');
    b_eps2_volatile = glmfit(squeeze(placebo_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(placebo_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_placebo(i,:) = [b_eps2_stable; b_eps3_stable; b_eps2_volatile; b_eps3_volatile];
end

%% Save GLM weights
save selected_GLM1_levodopa.mat GLM_levodopa
save selected_GLM1_galantamine.mat GLM_galantamine
save selected_GLM1_amisulpride.mat GLM_amisulpride
save selected_GLM1_biperiden.mat GLM_biperiden
save selected_GLM1_placebo.mat GLM_placebo

% %% Test EPS2 Stable
% eps2_stable_pred = glmval(GLM_placebo.D(10,1:8)',squeeze(placebo_stable_MMN(10,:,:))', 'identity');
% figure
% plot(eps2_stable)
% hold on
% plot(eps2_stable_pred, 'o')
% legend('eps2 stable', 'eps2 stable pred')
% 
% %% Test EPS3 Stable
% eps3_stable_pred = glmval(GLM_placebo.D(10,9:16)',squeeze(placebo_stable_MMN(10,:,:))', 'identity');
% figure
% plot(eps3_stable)
% hold on
% plot(eps3_stable_pred, 'o')
% legend('eps3 stable', 'eps3 stable pred')
% 
% %% Test EPS2 Volatile
% eps2_volatile_pred = glmval(GLM_placebo.D(10,17:24)',squeeze(placebo_volatile_MMN(10,:,:))', 'identity');
% figure
% plot(eps2_volatile)
% hold on
% plot(eps2_volatile_pred, 'o')
% legend('eps2 volatile', 'eps2 volatile pred')
% 
% %% Test EPS3 Volatile
% eps3_volatile_pred = glmval(GLM_placebo.D(10,25:32)',squeeze(placebo_volatile_MMN(10,:,:))', 'identity');
% figure
% plot(eps3_volatile)
% hold on
% plot(eps3_volatile_pred, 'o')
% legend('eps3 volatile', 'eps3 volatile pred')