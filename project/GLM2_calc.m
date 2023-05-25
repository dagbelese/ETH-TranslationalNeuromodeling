%%% GLM2 Calculation
%% Load datasets, prediction erros and stimulus sequence
load MMN_levodopa.mat
load MMN_galantamine.mat
load MMN_amisulpride.mat
load MMN_biperiden.mat
load MMN_Placebo.mat

load PEs.mat
load stimulus_sequence.mat

%% Preprocessing for GLM 2
% Index of deviant tones
dev_idx = find_deviant(tones);
% Index of stable high-tone phase
dev_stable_high_idx = zeros(size(dev_idx));
dev_stable_high_idx(1:300) = dev_idx(1:300);
dev_stable_high_idx(1250:1350) = dev_idx(1250:1350);
% Index of stable low-tone phase
dev_stable_low_idx = zeros(size(dev_idx));
dev_stable_low_idx(350:450) = dev_idx(350:450);
dev_stable_low_idx(900:1200) = dev_idx(900:1200);
% Index of volatile phase
dev_volatile_idx = zeros(size(dev_idx));
dev_volatile_idx(300:350) = dev_idx(300:350);
dev_volatile_idx(450:900) = dev_idx(450:900);
dev_volatile_idx(1200:1250) = dev_idx(1200:1250);
dev_volatile_idx(1350:1800) = dev_idx(1350:1800);

% Prediction erros
pe = [[0 0]; pe];
pe_stable_high = pe(dev_stable_high_idx==1, :);
pe_stable_low = pe(dev_stable_low_idx==1, :);
pe_volatile = pe(dev_volatile_idx==1, :);
eps2_stable_high = pe_stable_high(:,1); % Low-level PE - Stable high-tone
eps3_stable_high = abs(pe_stable_high(:,2)); % High-level PE - Stable high-tone
eps2_stable_low = pe_stable_low(:,1); % Low-level PE - Stable low-tone
eps3_stable_low = abs(pe_stable_low(:,2)); % High-level PE - Stable low-tone
eps2_volatile = pe_volatile(:,1); % Low-level PE - Volatile
eps3_volatile = abs(pe_volatile(:,2)); % High-level PE - Volatile

% Channel selection
channels = [1:63];

%% GLM 2 Calculations
% Group Levodopa
MMN_levodopa_early_high = squeeze(MMN_levodopa.MMN_early(:,channels,dev_stable_high_idx==1));
MMN_levodopa_late_high = squeeze(MMN_levodopa.MMN_late(:,channels,dev_stable_high_idx==1));
levodopa_high_MMN = cat(2, MMN_levodopa_early_high, MMN_levodopa_late_high);

MMN_levodopa_early_low = squeeze(MMN_levodopa.MMN_early(:,channels,dev_stable_low_idx==1));
MMN_levodopa_late_low = squeeze(MMN_levodopa.MMN_late(:,channels,dev_stable_low_idx==1));
levodopa_low_MMN = cat(2, MMN_levodopa_early_low, MMN_levodopa_late_low);

MMN_levodopa_early_volatile = squeeze(MMN_levodopa.MMN_early(:,channels,dev_volatile_idx==1));
MMN_levodopa_late_volatile = squeeze(MMN_levodopa.MMN_late(:,channels,dev_volatile_idx==1));
levodopa_volatile_MMN = cat(2, MMN_levodopa_early_volatile, MMN_levodopa_late_volatile);

GLM_levodopa.D = zeros(size(levodopa_volatile_MMN, 1), 6*size(levodopa_volatile_MMN, 2)+6);
for i=1:size(levodopa_volatile_MMN, 1)
    b_eps2_stable_high = glmfit(squeeze(levodopa_high_MMN(i,:,:))', eps2_stable_high, 'normal');
    b_eps3_stable_high = glmfit(squeeze(levodopa_high_MMN(i,:,:))', eps3_stable_high, 'normal');
    b_eps2_stable_low = glmfit(squeeze(levodopa_low_MMN(i,:,:))', eps2_stable_low, 'normal');
    b_eps3_stable_low = glmfit(squeeze(levodopa_low_MMN(i,:,:))', eps3_stable_low, 'normal');
    b_eps2_volatile = glmfit(squeeze(levodopa_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(levodopa_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_levodopa.D(i,:) = [b_eps2_stable_high; b_eps3_stable_high; b_eps2_stable_low; b_eps3_stable_low; b_eps2_volatile; b_eps3_volatile];
end

% Group Galantamine
MMN_galantamine_early_high = squeeze(MMN_galantamine.MMN_early(:,channels,dev_stable_high_idx==1));
MMN_galantamine_late_high = squeeze(MMN_galantamine.MMN_late(:,channels,dev_stable_high_idx==1));
galantamine_high_MMN = cat(2, MMN_galantamine_early_high, MMN_galantamine_late_high);

MMN_galantamine_early_low = squeeze(MMN_galantamine.MMN_early(:,channels,dev_stable_low_idx==1));
MMN_galantamine_late_low = squeeze(MMN_galantamine.MMN_late(:,channels,dev_stable_low_idx==1));
galantamine_low_MMN = cat(2, MMN_galantamine_early_low, MMN_galantamine_late_low);

MMN_galantamine_early_volatile = squeeze(MMN_galantamine.MMN_early(:,channels,dev_volatile_idx==1));
MMN_galantamine_late_volatile = squeeze(MMN_galantamine.MMN_late(:,channels,dev_volatile_idx==1));
galantamine_volatile_MMN = cat(2, MMN_galantamine_early_volatile, MMN_galantamine_late_volatile);

GLM_galantamine.D = zeros(size(galantamine_volatile_MMN, 1), 6*size(galantamine_volatile_MMN, 2)+6);
for i=1:size(galantamine_volatile_MMN, 1)
    b_eps2_stable_high = glmfit(squeeze(galantamine_high_MMN(i,:,:))', eps2_stable_high, 'normal');
    b_eps3_stable_high = glmfit(squeeze(galantamine_high_MMN(i,:,:))', eps3_stable_high, 'normal');
    b_eps2_stable_low = glmfit(squeeze(galantamine_low_MMN(i,:,:))', eps2_stable_low, 'normal');
    b_eps3_stable_low = glmfit(squeeze(galantamine_low_MMN(i,:,:))', eps3_stable_low, 'normal');
    b_eps2_volatile = glmfit(squeeze(galantamine_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(galantamine_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_galantamine.D(i,:) = [b_eps2_stable_high; b_eps3_stable_high; b_eps2_stable_low; b_eps3_stable_low; b_eps2_volatile; b_eps3_volatile];
end

% Group Amisulpride
MMN_amisulpride_early_high = squeeze(MMN_amisulpride.MMN_early(:,channels,dev_stable_high_idx==1));
MMN_amisulpride_late_high = squeeze(MMN_amisulpride.MMN_late(:,channels,dev_stable_high_idx==1));
amisulpride_high_MMN = cat(2, MMN_amisulpride_early_high, MMN_amisulpride_late_high);

MMN_amisulpride_early_low = squeeze(MMN_amisulpride.MMN_early(:,channels,dev_stable_low_idx==1));
MMN_amisulpride_late_low = squeeze(MMN_amisulpride.MMN_late(:,channels,dev_stable_low_idx==1));
amisulpride_low_MMN = cat(2, MMN_amisulpride_early_low, MMN_amisulpride_late_low);

MMN_amisulpride_early_volatile = squeeze(MMN_amisulpride.MMN_early(:,channels,dev_volatile_idx==1));
MMN_amisulpride_late_volatile = squeeze(MMN_amisulpride.MMN_late(:,channels,dev_volatile_idx==1));
amisulpride_volatile_MMN = cat(2, MMN_amisulpride_early_volatile, MMN_amisulpride_late_volatile);

GLM_amisulpride.D = zeros(size(amisulpride_volatile_MMN, 1), 6*size(amisulpride_volatile_MMN, 2)+6);
for i=1:size(amisulpride_volatile_MMN, 1)
    b_eps2_stable_high = glmfit(squeeze(amisulpride_high_MMN(i,:,:))', eps2_stable_high, 'normal');
    b_eps3_stable_high = glmfit(squeeze(amisulpride_high_MMN(i,:,:))', eps3_stable_high, 'normal');
    b_eps2_stable_low = glmfit(squeeze(amisulpride_low_MMN(i,:,:))', eps2_stable_low, 'normal');
    b_eps3_stable_low = glmfit(squeeze(amisulpride_low_MMN(i,:,:))', eps3_stable_low, 'normal');
    b_eps2_volatile = glmfit(squeeze(amisulpride_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(amisulpride_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_amisulpride.D(i,:) = [b_eps2_stable_high; b_eps3_stable_high; b_eps2_stable_low; b_eps3_stable_low; b_eps2_volatile; b_eps3_volatile];
end

% Group Biperiden
MMN_biperiden_early_high = squeeze(MMN_biperiden.MMN_early(:,channels,dev_stable_high_idx==1));
MMN_biperiden_late_high = squeeze(MMN_biperiden.MMN_late(:,channels,dev_stable_high_idx==1));
biperiden_high_MMN = cat(2, MMN_biperiden_early_high, MMN_biperiden_late_high);

MMN_biperiden_early_low = squeeze(MMN_biperiden.MMN_early(:,channels,dev_stable_low_idx==1));
MMN_biperiden_late_low = squeeze(MMN_biperiden.MMN_late(:,channels,dev_stable_low_idx==1));
biperiden_low_MMN = cat(2, MMN_biperiden_early_low, MMN_biperiden_late_low);

MMN_biperiden_early_volatile = squeeze(MMN_biperiden.MMN_early(:,channels,dev_volatile_idx==1));
MMN_biperiden_late_volatile = squeeze(MMN_biperiden.MMN_late(:,channels,dev_volatile_idx==1));
biperiden_volatile_MMN = cat(2, MMN_biperiden_early_volatile, MMN_biperiden_late_volatile);

GLM_biperiden.D = zeros(size(biperiden_volatile_MMN, 1), 6*size(biperiden_volatile_MMN, 2)+6);
for i=1:size(biperiden_volatile_MMN, 1)
    b_eps2_stable_high = glmfit(squeeze(biperiden_high_MMN(i,:,:))', eps2_stable_high, 'normal');
    b_eps3_stable_high = glmfit(squeeze(biperiden_high_MMN(i,:,:))', eps3_stable_high, 'normal');
    b_eps2_stable_low = glmfit(squeeze(biperiden_low_MMN(i,:,:))', eps2_stable_low, 'normal');
    b_eps3_stable_low = glmfit(squeeze(biperiden_low_MMN(i,:,:))', eps3_stable_low, 'normal');
    b_eps2_volatile = glmfit(squeeze(biperiden_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(biperiden_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_biperiden.D(i,:) = [b_eps2_stable_high; b_eps3_stable_high; b_eps2_stable_low; b_eps3_stable_low; b_eps2_volatile; b_eps3_volatile];
end

% Group Placebo
MMN_placebo_early_high = squeeze(MMN_placebo.MMN_early(:,channels,dev_stable_high_idx==1));
MMN_placebo_late_high = squeeze(MMN_placebo.MMN_late(:,channels,dev_stable_high_idx==1));
placebo_high_MMN = cat(2, MMN_placebo_early_high, MMN_placebo_late_high);

MMN_placebo_early_low = squeeze(MMN_placebo.MMN_early(:,channels,dev_stable_low_idx==1));
MMN_placebo_late_low = squeeze(MMN_placebo.MMN_late(:,channels,dev_stable_low_idx==1));
placebo_low_MMN = cat(2, MMN_placebo_early_low, MMN_placebo_late_low);

MMN_placebo_early_volatile = squeeze(MMN_placebo.MMN_early(:,channels,dev_volatile_idx==1));
MMN_placebo_late_volatile = squeeze(MMN_placebo.MMN_late(:,channels,dev_volatile_idx==1));
placebo_volatile_MMN = cat(2, MMN_placebo_early_volatile, MMN_placebo_late_volatile);

GLM_placebo.D = zeros(size(placebo_volatile_MMN, 1), 6*size(placebo_volatile_MMN, 2)+6);
for i=1:size(placebo_volatile_MMN, 1)
    b_eps2_stable_high = glmfit(squeeze(placebo_high_MMN(i,:,:))', eps2_stable_high, 'normal');
    b_eps3_stable_high = glmfit(squeeze(placebo_high_MMN(i,:,:))', eps3_stable_high, 'normal');
    b_eps2_stable_low = glmfit(squeeze(placebo_low_MMN(i,:,:))', eps2_stable_low, 'normal');
    b_eps3_stable_low = glmfit(squeeze(placebo_low_MMN(i,:,:))', eps3_stable_low, 'normal');
    b_eps2_volatile = glmfit(squeeze(placebo_volatile_MMN(i,:,:))', eps2_volatile, 'normal');
    b_eps3_volatile = glmfit(squeeze(placebo_volatile_MMN(i,:,:))', eps3_volatile, 'normal');
    GLM_placebo.D(i,:) = [b_eps2_stable_high; b_eps3_stable_high; b_eps2_stable_low; b_eps3_stable_low; b_eps2_volatile; b_eps3_volatile];
end

%% Save GLM weights
save GLM2_levodopa.mat GLM_levodopa
save GLM2_galantamine.mat GLM_galantamine
save GLM2_amisulpride.mat GLM_amisulpride
save GLM2_biperiden.mat GLM_biperiden
save GLM2_placebo.mat GLM_placebo

%% Test EPS2 Stable High-Tone
eps2_stable_high_pred = glmval(GLM_placebo.D(10,1:127)',squeeze(placebo_high_MMN(10,:,:))', 'identity');
figure
plot(eps2_stable_high)
hold on
plot(eps2_stable_high_pred, 'o')
legend('eps2 HT-stable', 'eps2 HT-stable pred')

%% Test EPS3 Stable High-Tone
eps3_stable_high_pred = glmval(GLM_placebo.D(10,128:254)',squeeze(placebo_high_MMN(10,:,:))', 'identity');
figure
plot(eps3_stable_high)
hold on
plot(eps3_stable_high_pred, 'o')
legend('eps3 HT-stable', 'eps3 HT-stable pred')

%% Test EPS2 Stable Low-Tone
eps2_stable_low_pred = glmval(GLM_placebo.D(10,255:381)',squeeze(placebo_low_MMN(10,:,:))', 'identity');
figure
plot(eps2_stable_low)
hold on
plot(eps2_stable_low_pred, 'o')
legend('eps2 LT-stable', 'eps2 LT-stable pred')

%% Test EPS3 Stable Low-Tone
eps3_stable_low_pred = glmval(GLM_placebo.D(10,382:508)',squeeze(placebo_low_MMN(10,:,:))', 'identity');
figure
plot(eps3_stable_low)
hold on
plot(eps3_stable_low_pred, 'o')
legend('eps3 LT-stable', 'eps3 LT-stable pred')

%% Test EPS2 Volatile
eps2_volatile_pred = glmval(GLM_placebo.D(10,509:635)',squeeze(placebo_volatile_MMN(10,:,:))', 'identity');
figure
plot(eps2_volatile)
hold on
plot(eps2_volatile_pred, 'o')
legend('eps2 volatile', 'eps2 volatile pred')

%% Test EPS3 Volatile
eps3_volatile_pred = glmval(GLM_placebo.D(10,636:762)',squeeze(placebo_volatile_MMN(10,:,:))', 'identity');
figure
plot(eps3_volatile)
hold on
plot(eps3_volatile_pred, 'o')
legend('eps3 volatile', 'eps3 volatile pred')