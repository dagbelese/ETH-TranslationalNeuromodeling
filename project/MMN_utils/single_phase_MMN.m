%% single-phase MMN calculation
% finding siginificant window
% standardized inter-subject and intra-dug group
clearvars
close all
clc

% cd /Users/liyitong/Documents/Frühlingsemester-2023/TN/TranslationalNeuromodelling
% please direct to the project main folder if executing scripts locally
addpath MMN_utils/
load agon_dataset.mat
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

ind_std = find_standard_all(tones);
ind_dev = find_deviant(tones);

%%
% placebo
% population properties
n_subject = size(subject_placebo,1);
[significant_ind,significant_time,scale] = mmn_population_property(subject_placebo,chan,n_subject,ind_std,ind_dev,g1,g2,w1, w2, Fs, pre);
uni_phase_MMN_placebo.significant_ind = significant_ind;
uni_phase_MMN_placebo.significant_time = significant_time;
uni_phase_MMN_placebo.channel_avg_scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_placebo,chan,n_subject,n_trials,g1, g2,ind_std,ind_dev, w1, w2,significant_ind,scale);
uni_phase_MMN_placebo.MMN_early = MMN_early;
uni_phase_MMN_placebo.MMN_late = MMN_late;

save("uni_phase_MMN_Placebo","uni_phase_MMN_placebo")

% ami
n_subject = size(subject_amisulpride,1);
[significant_ind,significant_time,scale] = mmn_population_property(subject_amisulpride,chan,n_subject,ind_std,ind_dev,g1,g2,w1, w2, Fs, pre);
uni_phase_MMN_amisulpride.significant_ind = significant_ind;
uni_phase_MMN_amisulpride.significant_time = significant_time;
uni_phase_MMN_amisulpride.channel_avg_scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_amisulpride,chan,n_subject,n_trials,g1, g2,ind_std,ind_dev, w1, w2,significant_ind,scale);
uni_phase_MMN_amisulpride.MMN_early = MMN_early;
uni_phase_MMN_amisulpride.MMN_late = MMN_late;

save("uni_phase_MMN_amisulpride","uni_phase_MMN_amisulpride")

% bip
n_subject = size(subject_biperiden,1);
[significant_ind,significant_time,scale] = mmn_population_property(subject_biperiden,chan,n_subject,ind_std,ind_dev,g1,g2, w1, w2, Fs, pre);
uni_phase_MMN_biperiden.significant_ind = significant_ind;
uni_phase_MMN_biperiden.significant_time = significant_time;
uni_phase_MMN_biperiden.channel_avg_scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_biperiden,chan,n_subject,n_trials,g1, g2,ind_std,ind_dev, w1, w2,significant_ind,scale);
uni_phase_MMN_biperiden.MMN_early = MMN_early;
uni_phase_MMN_biperiden.MMN_late = MMN_late;

save("uni_phase_MMN_biperiden","uni_phase_MMN_biperiden")

% gal
n_subject = size(subject_galantamine,1);
[significant_ind,significant_time,scale] = mmn_population_property(subject_galantamine,chan,n_subject,ind_std,ind_dev,g1,g2, w1, w2, Fs, pre);
uni_phase_MMN_galantamine.significant_ind = significant_ind;
uni_phase_MMN_galantamine.significant_time = significant_time;
uni_phase_MMN_galantamine.channel_avg_scale = scale;
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_galantamine,chan,n_subject,n_trials,g1, g2,ind_std,ind_dev, w1, w2,significant_ind,scale);
uni_phase_MMN_galantamine.MMN_early = MMN_early;
uni_phase_MMN_galantamine.MMN_late = MMN_late;

save("uni_phase_MMN_galantamine","uni_phase_MMN_galantamine")

% lev
n_subject = size(subject_levodopa,1);
[significant_ind,significant_time,scale] = mmn_population_property(subject_levodopa,chan,n_subject,ind_std,ind_dev,g1,g2, w1, w2, Fs, pre);
% trial-wise MMN
[MMN_early,MMN_late] = mmn_trial_wise(subject_levodopa,chan,n_subject,n_trials,g1, g2,ind_std,ind_dev, w1, w2,significant_ind,scale);

uni_phase_MMN_levodopa.significant_ind = significant_ind;
uni_phase_MMN_levodopa.significant_time = significant_time;
uni_phase_MMN_levodopa.channel_avg_scale = scale;
uni_phase_MMN_levodopa.MMN_early = MMN_early;
uni_phase_MMN_levodopa.MMN_late = MMN_late;

save("uni_phase_MMN_levodopa","uni_phase_MMN_levodopa")

%% visual check
f = figure();
f.Position = [440   378   860   420];
stem(uni_phase_MMN_placebo.channel_avg_scale,"*",'LineWidth',1.2)
ylim([0 6.25])
xticks(1:63)
xticklabels(chan(1:63))
ylabel("Average channel scale [mV]")
hold on
stem(uni_phase_MMN_amisulpride.channel_avg_scale,"*",'LineWidth',1.2)
stem(uni_phase_MMN_biperiden.channel_avg_scale,"*",'LineWidth',1.2)
stem(uni_phase_MMN_galantamine.channel_avg_scale,"*",'LineWidth',1.2)
stem(uni_phase_MMN_levodopa.channel_avg_scale,"*",'LineWidth',1.2)
ylabel("Average channel scale [mV]")
xlabel("EEG Channel")
title("uni-phase MMN: inter-drug-group contrast")
legend('placebo','amisulpride','biperiden','galantamine','levodopa')

cd figures/
fn = "quad-phase-Ami.png";
saveas(gcf,fn)

%%
% p1 = squeeze(uni_phase_MMN_levodopa.MMN_early(1,5,:));
% p2 = squeeze(uni_phase_MMN_galantamine.MMN_early(1,5,:));
% p3 = squeeze(uni_phase_MMN_biperiden.MMN_early(1,5,:));
% p4 = squeeze(uni_phase_MMN_amisulpride.MMN_early(1,5,:));
% p5 = squeeze(uni_phase_MMN_placebo.MMN_early(1,5,:));
% 
% figure
% plot(p1)
% hold on
% plot(p2)
% plot(p3)
% plot(p4)
% plot(p5)
