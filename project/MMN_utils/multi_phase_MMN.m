%% multi-phase MMN
% study MMN population properties in different phases
clearvars
close all
clc

% cd /Users/liyitong/Documents/Frühlingsemester-2023/TN/TranslationalNeuromodelling
% please direct to the project main folder if executing scripts locally
addpath MMN_utils/
load agon_dataset.mat   % may not be uploaded due to GitLab storage limit
load anta_dataset.mat
load labels.mat
load stimulus_sequence.mat
load Channels.mat

%% set-up
agon_label = labels.agon;
anta_label = labels.anta;

subject_placebo = anta_dataset(anta_label.Pla,:,:,:);
subject_placebo = [subject_placebo; agon_dataset(agon_label.Pla,:,:,:)];

subject_amisulpride = anta_dataset(anta_label.DA,:,:,:);
subject_biperiden = anta_dataset(anta_label.ACh,:,:,:);

subject_levodopa = agon_dataset(agon_label.DA,:,:,:);
subject_galantamine = agon_dataset(agon_label.ACh,:,:,:);

clear anta_dataset
clear agon_dataset
clear anta_label
clear agon_label
clear labels

n_eeg_ch = 63;
n_trials = length(tones);

Fs = 250;
pre = 100;
w1 = round((pre+100:4:pre+275)/1000*Fs);
w2 = round((pre+225:4:pre+375)/1000*Fs);

g1 = ["AF3","AF4","AF7","AF8","F5","F7","Fp1","FP2","FT9","TP9"]; % + -
g2 = ["C1","C2","C3","C4","C5","C6","CP1","CP2","CP3","CP4","CP5","CP6","CP7","CPz",...
    "F1","F2","F3","F4","F6","F8","FC1","FC2","FC3","FC4","FC5","FC6","FCz",...
    "FT7","FT8","FT10","Fz","O1","O2","Oz","P1","P2","P3","P4","P5","P6","P7","P8",...
    "PO3","PO4","PO7","PO8","POz","Pz","T7","T8","TP7","TP8","TP10"]; % - +

std_ind = find_standard_all(tones);
dev_ind = find_deviant(tones);

%% bi-phase (creating data 2)
phase1 = [1:300 351:450 901:1200 1251:1350]; % stable
phase2 = [301:350 451:900 1201:1250 1351:1800]; % volatile
std_1 = std_ind(phase1);
std_2 = std_ind(phase2);
dev_1 = dev_ind(phase1);
dev_2 = dev_ind(phase2);

% ### Placebo ###
n_subject = size(subject_placebo,1);
% phase 1 (stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_placebo,chan,n_subject,std_1,dev_1,g1,g2,w1, w2, Fs, pre);
bi_phase_MMN_placebo.phase_1.siginificant_ind = significant_ind;
bi_phase_MMN_placebo.phase_1.siginificant_ind = significant_time;
bi_phase_MMN_placebo.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_placebo,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
bi_phase_MMN_placebo.phase_1.MMN_early = MMN_early;
bi_phase_MMN_placebo.phase_1.MMN_late = MMN_late;

% phase 2 (volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_placebo,chan,n_subject,std_2,dev_2,g1,g2,w1, w2, Fs, pre);
bi_phase_MMN_placebo.phase_2.siginificant_ind = significant_ind;
bi_phase_MMN_placebo.phase_2.siginificant_ind = significant_time;
bi_phase_MMN_placebo.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_placebo,chan,n_subject,n_trials,g1, g2,std_2,dev_2,w1,w2,significant_ind,scale);
bi_phase_MMN_placebo.phase_2.MMN_early = MMN_early;
bi_phase_MMN_placebo.phase_2.MMN_late = MMN_late;


% ### Ami ###
n_subject = size(subject_amisulpride,1);
% phase 1 (stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_amisulpride,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
bi_phase_MMN_amisulpride.phase_1.siginificant_ind = significant_ind;
bi_phase_MMN_amisulpride.phase_1.siginificant_ind = significant_time;
bi_phase_MMN_amisulpride.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_amisulpride,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
bi_phase_MMN_amisulpride.phase_1.MMN_early = MMN_early;
bi_phase_MMN_amisulpride.phase_1.MMN_late = MMN_late;

% phase 2 (volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_amisulpride,chan,n_subject,std_2,dev_2,g1,g2,w1, w2, Fs, pre);
bi_phase_MMN_amisulpride.phase_2.siginificant_ind = significant_ind;
bi_phase_MMN_amisulpride.phase_2.siginificant_ind = significant_time;
bi_phase_MMN_amisulpride.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_amisulpride,chan,n_subject,n_trials,g1, g2,std_2,dev_2,w1,w2,significant_ind,scale);
bi_phase_MMN_amisulpride.phase_2.MMN_early = MMN_early;
bi_phase_MMN_amisulpride.phase_2.MMN_late = MMN_late;


% ### Bip ###
n_subject = size(subject_biperiden,1);
% phase 1 (stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_biperiden,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
bi_phase_MMN_biperiden.phase_1.siginificant_ind = significant_ind;
bi_phase_MMN_biperiden.phase_1.siginificant_ind = significant_time;
bi_phase_MMN_biperiden.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_biperiden,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
bi_phase_MMN_biperiden.phase_1.MMN_early = MMN_early;
bi_phase_MMN_biperiden.phase_1.MMN_late = MMN_late;

% phase 2 (volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_biperiden,chan,n_subject,std_2,dev_2,g1,g2,w1, w2, Fs, pre);
bi_phase_MMN_biperiden.phase_2.siginificant_ind = significant_ind;
bi_phase_MMN_biperiden.phase_2.siginificant_ind = significant_time;
bi_phase_MMN_biperiden.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_biperiden,chan,n_subject,n_trials,g1, g2,std_2,dev_2,w1,w2,significant_ind,scale);
bi_phase_MMN_biperiden.phase_2.MMN_early = MMN_early;
bi_phase_MMN_biperiden.phase_2.MMN_late = MMN_late;


% ### Gal ###
n_subject = size(subject_galantamine,1);
% phase 1 (stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_galantamine,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
bi_phase_MMN_galantamine.phase_1.siginificant_ind = significant_ind;
bi_phase_MMN_galantamine.phase_1.siginificant_ind = significant_time;
bi_phase_MMN_galantamine.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_galantamine,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
bi_phase_MMN_galantamine.phase_1.MMN_early = MMN_early;
bi_phase_MMN_galantamine.phase_1.MMN_late = MMN_late;

% phase 2 (volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_galantamine,chan,n_subject,std_2,dev_2,g1,g2,w1, w2, Fs, pre);
bi_phase_MMN_galantamine.phase_2.siginificant_ind = significant_ind;
bi_phase_MMN_galantamine.phase_2.siginificant_ind = significant_time;
bi_phase_MMN_galantamine.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_galantamine,chan,n_subject,n_trials,g1, g2,std_2,dev_2,w1,w2,significant_ind,scale);
bi_phase_MMN_galantamine.phase_2.MMN_early = MMN_early;
bi_phase_MMN_galantamine.phase_2.MMN_late = MMN_late;


% ### Lev ###
n_subject = size(subject_levodopa,1);
% phase 1 (stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_levodopa,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
bi_phase_MMN_levodopa.phase_1.siginificant_ind = significant_ind;
bi_phase_MMN_levodopa.phase_1.siginificant_ind = significant_time;
bi_phase_MMN_levodopa.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_levodopa,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
bi_phase_MMN_levodopa.phase_1.MMN_early = MMN_early;
bi_phase_MMN_levodopa.phase_1.MMN_late = MMN_late;

% phase 2 (volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_levodopa,chan,n_subject,std_2,dev_2,g1,g2,w1, w2, Fs, pre);
bi_phase_MMN_levodopa.phase_2.siginificant_ind = significant_ind;
bi_phase_MMN_levodopa.phase_2.siginificant_ind = significant_time;
bi_phase_MMN_levodopa.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_levodopa,chan,n_subject,n_trials,g1, g2,std_2,dev_2,w1,w2,significant_ind,scale);
bi_phase_MMN_levodopa.phase_2.MMN_early = MMN_early;
bi_phase_MMN_levodopa.phase_2.MMN_late = MMN_late;

%% save data
save("bi_phase_MMN_placebo","bi_phase_MMN_placebo")
save("bi_phase_MMN_amisulpride","bi_phase_MMN_amisulpride")
save("bi_phase_MMN_biperiden","bi_phase_MMN_biperiden")
save("bi_phase_MMN_galantamine","bi_phase_MMN_galantamine")
save("bi_phase_MMN_levodopa","bi_phase_MMN_levodopa")

%% quad-phase (data 3)
phase1 = [1:300 351:450];% early stable
phase2 = [301:350 451:900];% early volatile
phase3 = [901:1200 1251:1350];% late stable
phase4 = [1201:1250 1351:1800];% late volatile
std_1 = std_ind(phase1);
std_2 = std_ind(phase2);
std_3 = std_ind(phase3);
std_4 = std_ind(phase4);
dev_1 = dev_ind(phase1);
dev_2 = dev_ind(phase2);
dev_3 = dev_ind(phase3);
dev_4 = dev_ind(phase4);

% ### Placebo ###
n_subject = size(subject_placebo,1);
% phase 1 (early-stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_placebo,chan,n_subject,std_1,dev_1,g1,g2,w1, w2, Fs, pre);
quad_phase_MMN_placebo.phase_1.siginificant_ind = significant_ind;
quad_phase_MMN_placebo.phase_1.siginificant_ind = significant_time;
quad_phase_MMN_placebo.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_placebo,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
quad_phase_MMN_placebo.phase_1.MMN_early = MMN_early;
quad_phase_MMN_placebo.phase_1.MMN_late = MMN_late;

% phase 2 (early-volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_placebo,chan,n_subject,std_2,dev_2,g1,g2,w1, w2, Fs, pre);
quad_phase_MMN_placebo.phase_2.siginificant_ind = significant_ind;
quad_phase_MMN_placebo.phase_2.siginificant_ind = significant_time;
quad_phase_MMN_placebo.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_placebo,chan,n_subject,n_trials,g1, g2,std_2,dev_2,w1,w2,significant_ind,scale);
quad_phase_MMN_placebo.phase_2.MMN_early = MMN_early;
quad_phase_MMN_placebo.phase_2.MMN_late = MMN_late;

% phase 3 (late-stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_placebo,chan,n_subject,std_3,dev_3,g1,g2,w1, w2, Fs, pre);
quad_phase_MMN_placebo.phase_3.siginificant_ind = significant_ind;
quad_phase_MMN_placebo.phase_3.siginificant_ind = significant_time;
quad_phase_MMN_placebo.phase_3.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_placebo,chan,n_subject,n_trials,g1, g2,std_3,dev_3,w1,w2,significant_ind,scale);
quad_phase_MMN_placebo.phase_3.MMN_early = MMN_early;
quad_phase_MMN_placebo.phase_3.MMN_late = MMN_late;

% phase 4 (late-volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_placebo,chan,n_subject,std_4,dev_4,g1,g2,w1, w2, Fs, pre);
quad_phase_MMN_placebo.phase_4.siginificant_ind = significant_ind;
quad_phase_MMN_placebo.phase_4.siginificant_ind = significant_time;
quad_phase_MMN_placebo.phase_4.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_placebo,chan,n_subject,n_trials,g1, g2,std_4,dev_4,w1,w2,significant_ind,scale);
quad_phase_MMN_placebo.phase_4.MMN_early = MMN_early;
quad_phase_MMN_placebo.phase_4.MMN_late = MMN_late;


% ### Ami ###
n_subject = size(subject_amisulpride,1);
% phase 1 (early-stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_amisulpride,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_amisulpride.phase_1.siginificant_ind = significant_ind;
quad_phase_MMN_amisulpride.phase_1.siginificant_ind = significant_time;
quad_phase_MMN_amisulpride.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_amisulpride,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
quad_phase_MMN_amisulpride.phase_1.MMN_early = MMN_early;
quad_phase_MMN_amisulpride.phase_1.MMN_late = MMN_late;

% phase 2 (early-volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_amisulpride,chan,n_subject,std_2,dev_2,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_amisulpride.phase_2.siginificant_ind = significant_ind;
quad_phase_MMN_amisulpride.phase_2.siginificant_ind = significant_time;
quad_phase_MMN_amisulpride.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_amisulpride,chan,n_subject,n_trials,g1, g2,std_2,dev_2,w1,w2,significant_ind,scale);
quad_phase_MMN_amisulpride.phase_2.MMN_early = MMN_early;
quad_phase_MMN_amisulpride.phase_2.MMN_late = MMN_late;

% phase 3 (late-stable)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_amisulpride,chan,n_subject,std_3,dev_3,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_amisulpride.phase_3.siginificant_ind = significant_ind;
quad_phase_MMN_amisulpride.phase_3.siginificant_ind = significant_time;
quad_phase_MMN_amisulpride.phase_3.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_amisulpride,chan,n_subject,n_trials,g1,g2,std_3,dev_3,w1,w2,significant_ind,scale);
quad_phase_MMN_amisulpride.phase_3.MMN_early = MMN_early;
quad_phase_MMN_amisulpride.phase_3.MMN_late = MMN_late;

% phase 3 (late-volatile)
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_amisulpride,chan,n_subject,std_4,dev_4,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_amisulpride.phase_4.siginificant_ind = significant_ind;
quad_phase_MMN_amisulpride.phase_4.siginificant_ind = significant_time;
quad_phase_MMN_amisulpride.phase_4.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_amisulpride,chan,n_subject,n_trials,g1,g2,std_4,dev_4,w1,w2,significant_ind,scale);
quad_phase_MMN_amisulpride.phase_4.MMN_early = MMN_early;
quad_phase_MMN_amisulpride.phase_4.MMN_late = MMN_late;


% ### Bip ###
n_subject = size(subject_biperiden,1);
% phase 1
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_biperiden,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_biperiden.phase_1.siginificant_ind = significant_ind;
quad_phase_MMN_biperiden.phase_1.siginificant_ind = significant_time;
quad_phase_MMN_biperiden.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_biperiden,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
quad_phase_MMN_biperiden.phase_1.MMN_early = MMN_early;
quad_phase_MMN_biperiden.phase_1.MMN_late = MMN_late;

% phase 2
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_biperiden,chan,n_subject,std_2,dev_2,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_biperiden.phase_2.siginificant_ind = significant_ind;
quad_phase_MMN_biperiden.phase_2.siginificant_ind = significant_time;
quad_phase_MMN_biperiden.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_biperiden,chan,n_subject,n_trials,g1, g2,std_2,dev_2, w1, w2,significant_ind,scale);
quad_phase_MMN_biperiden.phase_2.MMN_early = MMN_early;
quad_phase_MMN_biperiden.phase_2.MMN_late = MMN_late;

% phase 3
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_biperiden,chan,n_subject,std_3,dev_3,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_biperiden.phase_3.siginificant_ind = significant_ind;
quad_phase_MMN_biperiden.phase_3.siginificant_ind = significant_time;
quad_phase_MMN_biperiden.phase_3.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_biperiden,chan,n_subject,n_trials,g1, g2,std_3,dev_3, w1, w2,significant_ind,scale);
quad_phase_MMN_biperiden.phase_3.MMN_early = MMN_early;
quad_phase_MMN_biperiden.phase_3.MMN_late = MMN_late;

% phase 4
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_biperiden,chan,n_subject,std_4,dev_4,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_biperiden.phase_4.siginificant_ind = significant_ind;
quad_phase_MMN_biperiden.phase_4.siginificant_ind = significant_time;
quad_phase_MMN_biperiden.phase_4.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_biperiden,chan,n_subject,n_trials,g1, g2,std_4,dev_4, w1, w2,significant_ind,scale);
quad_phase_MMN_biperiden.phase_4.MMN_early = MMN_early;
quad_phase_MMN_biperiden.phase_4.MMN_late = MMN_late;


% ### Gal ###
n_subject = size(subject_galantamine,1);
% phase 1
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_galantamine,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_galantamine.phase_1.siginificant_ind = significant_ind;
quad_phase_MMN_galantamine.phase_1.siginificant_ind = significant_time;
quad_phase_MMN_galantamine.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_galantamine,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
quad_phase_MMN_galantamine.phase_1.MMN_early = MMN_early;
quad_phase_MMN_galantamine.phase_1.MMN_late = MMN_late;

% phase 2
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_galantamine,chan,n_subject,std_2,dev_2,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_galantamine.phase_2.siginificant_ind = significant_ind;
quad_phase_MMN_galantamine.phase_2.siginificant_ind = significant_time;
quad_phase_MMN_galantamine.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_galantamine,chan,n_subject,n_trials,g1, g2,std_2,dev_2, w1, w2,significant_ind,scale);
quad_phase_MMN_galantamine.phase_2.MMN_early = MMN_early;
quad_phase_MMN_galantamine.phase_2.MMN_late = MMN_late;

% phase 3
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_galantamine,chan,n_subject,std_3,dev_3,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_galantamine.phase_3.siginificant_ind = significant_ind;
quad_phase_MMN_galantamine.phase_3.siginificant_ind = significant_time;
quad_phase_MMN_galantamine.phase_3.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_galantamine,chan,n_subject,n_trials,g1, g2,std_3,dev_3, w1, w2,significant_ind,scale);
quad_phase_MMN_galantamine.phase_3.MMN_early = MMN_early;
quad_phase_MMN_galantamine.phase_3.MMN_late = MMN_late;

% phase 4
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_galantamine,chan,n_subject,std_4,dev_4,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_galantamine.phase_4.siginificant_ind = significant_ind;
quad_phase_MMN_galantamine.phase_4.siginificant_ind = significant_time;
quad_phase_MMN_galantamine.phase_4.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_galantamine,chan,n_subject,n_trials,g1, g2,std_4,dev_4, w1, w2,significant_ind,scale);
quad_phase_MMN_galantamine.phase_4.MMN_early = MMN_early;
quad_phase_MMN_galantamine.phase_4.MMN_late = MMN_late;


% ### Lev ###
n_subject = size(subject_levodopa,1);
% phase 1
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_levodopa,chan,n_subject,std_1,dev_1,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_levodopa.phase_1.siginificant_ind = significant_ind;
quad_phase_MMN_levodopa.phase_1.siginificant_ind = significant_time;
quad_phase_MMN_levodopa.phase_1.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_levodopa,chan,n_subject,n_trials,g1, g2,std_1,dev_1, w1, w2,significant_ind,scale);
quad_phase_MMN_levodopa.phase_1.MMN_early = MMN_early;
quad_phase_MMN_levodopa.phase_1.MMN_late = MMN_late;

% phase 2
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_levodopa,chan,n_subject,std_2,dev_2,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_levodopa.phase_2.siginificant_ind = significant_ind;
quad_phase_MMN_levodopa.phase_2.siginificant_ind = significant_time;
quad_phase_MMN_levodopa.phase_2.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_levodopa,chan,n_subject,n_trials,g1, g2,std_2,dev_2, w1, w2,significant_ind,scale);
quad_phase_MMN_levodopa.phase_2.MMN_early = MMN_early;
quad_phase_MMN_levodopa.phase_2.MMN_late = MMN_late;

% phase 3
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_levodopa,chan,n_subject,std_3,dev_3,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_levodopa.phase_3.siginificant_ind = significant_ind;
quad_phase_MMN_levodopa.phase_3.siginificant_ind = significant_time;
quad_phase_MMN_levodopa.phase_3.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_levodopa,chan,n_subject,n_trials,g1, g2,std_3,dev_3, w1, w2,significant_ind,scale);
quad_phase_MMN_levodopa.phase_3.MMN_early = MMN_early;
quad_phase_MMN_levodopa.phase_3.MMN_late = MMN_late;

% phase 4
% population property
[significant_ind,significant_time,scale] = mmn_population_property(subject_levodopa,chan,n_subject,std_4,dev_4,g1,g2,w1,w2,Fs,pre);
quad_phase_MMN_levodopa.phase_4.siginificant_ind = significant_ind;
quad_phase_MMN_levodopa.phase_4.siginificant_ind = significant_time;
quad_phase_MMN_levodopa.phase_4.scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_levodopa,chan,n_subject,n_trials,g1, g2,std_4,dev_4, w1, w2,significant_ind,scale);
quad_phase_MMN_levodopa.phase_4.MMN_early = MMN_early;
quad_phase_MMN_levodopa.phase_4.MMN_late = MMN_late;


%% save data
save("quad_phase_MMN_placebo","quad_phase_MMN_placebo")
save("quad_phase_MMN_amisulpride","quad_phase_MMN_amisulpride")
save("quad_phase_MMN_biperiden","quad_phase_MMN_biperiden")
save("quad_phase_MMN_galantamine","quad_phase_MMN_galantamine")
save("quad_phase_MMN_levodopa","quad_phase_MMN_levodopa")


%% visual check: bi-phase
cd figures/
f = figure();
f.Position = [440   378   860   420];
stem(bi_phase_MMN_levodopa.phase_1.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
hold on
stem(bi_phase_MMN_levodopa.phase_2.scale,".",'LineWidth',1.2)
ylim([0 3.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: stable-volatile contrast (Levodopa)")
legend("stable phases","volatile phases")
fn = "bi-phase-Lev.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(bi_phase_MMN_placebo.phase_1.scale,".",'LineWidth',1.2)
ylim([0 3.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(bi_phase_MMN_placebo.phase_2.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: stable-volatile contrast (Placebo)")
legend("stable phases","volatile phases")
fn = "bi-phase-Pla.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(bi_phase_MMN_galantamine.phase_1.scale,".",'LineWidth',1.2)
ylim([0 3.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(bi_phase_MMN_galantamine.phase_2.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: stable-volatile contrast (Galantamine)")
legend("stable phases","volatile phases")
fn = "bi-phase-Gal.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(bi_phase_MMN_biperiden.phase_1.scale,".",'LineWidth',1.2)
ylim([0 3.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(bi_phase_MMN_biperiden.phase_2.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: stable-volatile contrast (Biperiden)")
legend("stable phases","volatile phases")
fn = "bi-phase-Bip.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(bi_phase_MMN_amisulpride.phase_1.scale,".",'LineWidth',1.2)
ylim([0 3.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(bi_phase_MMN_amisulpride.phase_2.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: stable-volatile contrast (Amisulpride)")
legend("stable phases","volatile phases")
fn = "bi-phase-Ami.png";
saveas(gcf,fn)

% visual check: quad-phase
f = figure();
f.Position = [440   378   860   420];
stem(quad_phase_MMN_levodopa.phase_1.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
hold on
stem(quad_phase_MMN_levodopa.phase_2.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_levodopa.phase_3.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_levodopa.phase_4.scale,".",'LineWidth',1.2)
ylim([0 6.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: 4-phase contrast (Levodopa)")
legend("early-stable phases","early-volatile phases","late-stable phases","late-volatile phases")
fn = "quad-phase-Lev.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(quad_phase_MMN_placebo.phase_1.scale,".",'LineWidth',1.2)
ylim([0 6.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(quad_phase_MMN_placebo.phase_2.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_placebo.phase_3.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_placebo.phase_4.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: 4-phase contrast (Placebo)")
legend("early-stable phases","early-volatile phases","late-stable phases","late-volatile phases")
fn = "quad-phase-Pla.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(quad_phase_MMN_galantamine.phase_1.scale,".",'LineWidth',1.2)
ylim([0 6.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(quad_phase_MMN_galantamine.phase_2.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_galantamine.phase_3.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_galantamine.phase_4.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: 4-phase contrast (Galantamine)")
legend("early-stable phases","early-volatile phases","late-stable phases","late-volatile phases")
fn = "quad-phase-Gal.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(quad_phase_MMN_biperiden.phase_1.scale,".",'LineWidth',1.2)
ylim([0 6.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(quad_phase_MMN_biperiden.phase_2.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_biperiden.phase_3.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_biperiden.phase_4.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: 4-phase contrast (Biperiden)")
legend("early-stable phases","early-volatile phases","late-stable phases","late-volatile phases")
fn = "quad-phase-Bip.png";
saveas(gcf,fn)

f = figure();
f.Position = [440   378   860   420];
stem(quad_phase_MMN_amisulpride.phase_1.scale,".",'LineWidth',1.2)
ylim([0 6.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(quad_phase_MMN_amisulpride.phase_2.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_amisulpride.phase_3.scale,".",'LineWidth',1.2)
stem(quad_phase_MMN_amisulpride.phase_4.scale,".",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("MMN: 4-phase contrast (Amisulpride)")
legend("early-stable phases","early-volatile phases","late-stable phases","late-volatile phases")
fn = "quad-phase-Ami.png";
saveas(gcf,fn)
