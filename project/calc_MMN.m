%% MMN calculation
% finding siginificant window
% standardized inter-subject and intra-dug group

cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling
addpath /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling
load stimulus_sequence.mat
load agon_dataset.mat
load agon_label.mat
load anta_dataset.mat
load anta_label.mat
load Channels.mat

%% grouping: 5 drugs

subject_placebo = anta_dataset(anta_label==0,:,:,:);
subject_placebo = [subject_placebo; agon_dataset(agon_label==0,:,:,:)];
subject_amisulpride = anta_dataset(anta_label==1,:,:,:);
subject_biperiden = anta_dataset(anta_label==2,:,:,:);
subject_levodopa = agon_dataset(agon_label==1,:,:,:);
subject_galantamine = agon_dataset(agon_label==2,:,:,:);

clear anta_dataset
clear agon_dataset
clear anta_label
clear agon_label

n_eeg_ch = 63;
n_trials = length(tones);

%% get standardized MMN
ind_dev = find_deviant(tones);
ind_std = find_standard_all(tones);

Fs = 250;
pre = 100;
w1 = round((pre+100:4:pre+275)/1000*Fs);
w2 = round((pre+225:4:pre+375)/1000*Fs);

g1 = ["AF3","AF4","AF7","AF8","F5","F7","Fp1","FP2","FT9","TP9"]; % + -
g2 = ["C1","C2","C3","C4","C5","C6","CP1","CP2","CP3","CP4","CP5","CP6","CP7","CPz",...
    "F1","F2","F3","F4","F6","F8","FC1","FC2","FC3","FC4","FC5","FC6","FCz",...
    "FT7","FT8","FT10","Fz","O1","O2","Oz","P1","P2","P3","P4","P5","P6","P7","P8",...
    "PO3","PO4","PO7","PO8","POz","Pz","T7","T8","TP7","TP8","TP10"]; % - +

%% placebo
n_subject = size(subject_placebo,1);
significant_ind = zeros(n_eeg_ch,2);   % find channel-and-drug-specific siginificant time by averaging across subjects intra drug groups
scale = zeros(n_eeg_ch,1);              % scale for intra-drug group normalization

% population properties: scale and siginificant time
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:n_subject
        erp = subject_placebo(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_avg = mean(mmn_avg,2);
    if sum(chan(ch_no)==g1)
        [M1,I1] = max(mmn_avg(w1));
        [M2,I2] = min(mmn_avg(w2));
    elseif sum(chan(ch_no)==g2)
        [M1,I1] = min(mmn_avg(w1));
        [M2,I2] = max(mmn_avg(w2));
    end
    scale(ch_no) = abs(M1-M2);
    significant_ind(ch_no,1)=w1(1)+I1;
    significant_ind(ch_no,2)=w2(1)+I2;
end
significant_time = significant_ind/Fs*1000-100;

MMN_placebo.significant_ind = significant_ind;
MMN_placebo.significant_time = significant_time;
MMN_placebo.channel_avg_scale = scale;


% trial-wise MMN
MMN_early = zeros(n_subject,n_eeg_ch,n_trials);
MMN_late = zeros(n_subject,n_eeg_ch,n_trials);

for ch_no = 1:n_eeg_ch
    ind = significant_ind(ch_no,:);
    for subj_no = 1:n_subject
        erp = subject_placebo(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        mmn_erp = erp(:,ind_dev==1);
        mmn_erp = mmn_erp - repmat(std_avg,[1,sum(ind_dev)]);
        
        MMN_early(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(1)-2:ind(1)+2,:),1);
        MMN_late(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(2)-2:ind(2)+2,:),1);
    end
end

MMN_placebo.MMN_early = MMN_early;
MMN_placebo.MMN_late = MMN_late;

save("MMN_Placebo","MMN_placebo")

%% ami
n_subject = size(subject_amisulpride,1);
significant_ind = zeros(n_eeg_ch,2);   % find channel-and-drug-specific siginificant time by averaging across subjects intra drug groups
scale = zeros(n_eeg_ch,1);              % scale for intra-drug group normalization

% population properties: scale and siginificant time
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:n_subject
        erp = subject_amisulpride(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_avg = mean(mmn_avg,2);
    if sum(chan(ch_no)==g1)
        [M1,I1] = max(mmn_avg(w1));
        [M2,I2] = min(mmn_avg(w2));
    elseif sum(chan(ch_no)==g2)
        [M1,I1] = min(mmn_avg(w1));
        [M2,I2] = max(mmn_avg(w2));
    end
    scale(ch_no) = abs(M1-M2);
    significant_ind(ch_no,1)=w1(1)+I1;
    significant_ind(ch_no,2)=w2(1)+I2;
end
significant_time = significant_ind/Fs*1000-100;

MMN_amisulpride.significant_ind = significant_ind;
MMN_amisulpride.significant_time = significant_time;
MMN_amisulpride.channel_avg_scale = scale;


% trial-wise MMN
MMN_early = zeros(n_subject,n_eeg_ch,n_trials);
MMN_late = zeros(n_subject,n_eeg_ch,n_trials);

for ch_no = 1:n_eeg_ch
    ind = significant_ind(ch_no,:);
    for subj_no = 1:n_subject
        erp = subject_amisulpride(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        mmn_erp = erp(:,ind_dev==1);
        mmn_erp = mmn_erp - repmat(std_avg,[1,sum(ind_dev)]);
        
        MMN_early(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(1)-2:ind(1)+2,:),1);
        MMN_late(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(2)-2:ind(2)+2,:),1);
    end
end

MMN_amisulpride.MMN_early = MMN_early;
MMN_amisulpride.MMN_late = MMN_late;

save("MMN_amisulpride","MMN_amisulpride")

%% bip
n_subject = size(subject_biperiden,1);
significant_ind = zeros(n_eeg_ch,2);   % find channel-and-drug-specific siginificant time by averaging across subjects intra drug groups
scale = zeros(n_eeg_ch,1);              % scale for intra-drug group normalization

% population properties: scale and siginificant time
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:n_subject
        erp = subject_biperiden(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_avg = mean(mmn_avg,2);
    if sum(chan(ch_no)==g1)
        [M1,I1] = max(mmn_avg(w1));
        [M2,I2] = min(mmn_avg(w2));
    elseif sum(chan(ch_no)==g2)
        [M1,I1] = min(mmn_avg(w1));
        [M2,I2] = max(mmn_avg(w2));
    end
    scale(ch_no) = abs(M1-M2);
    significant_ind(ch_no,1)=w1(1)+I1;
    significant_ind(ch_no,2)=w2(1)+I2;
end
significant_time = significant_ind/Fs*1000-100;

MMN_biperiden.significant_ind = significant_ind;
MMN_biperiden.significant_time = significant_time;
MMN_biperiden.channel_avg_scale = scale;


% trial-wise MMN
MMN_early = zeros(n_subject,n_eeg_ch,n_trials);
MMN_late = zeros(n_subject,n_eeg_ch,n_trials);

for ch_no = 1:n_eeg_ch
    ind = significant_ind(ch_no,:);
    for subj_no = 1:n_subject
        erp = subject_biperiden(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        mmn_erp = erp(:,ind_dev==1);
        mmn_erp = mmn_erp - repmat(std_avg,[1,sum(ind_dev)]);
        
        MMN_early(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(1)-2:ind(1)+2,:),1);
        MMN_late(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(2)-2:ind(2)+2,:),1);
    end
end

MMN_biperiden.MMN_early = MMN_early;
MMN_biperiden.MMN_late = MMN_late;

save("MMN_biperiden","MMN_biperiden")
%% gal
n_subject = size(subject_galantamine,1);
significant_ind = zeros(n_eeg_ch,2);   % find channel-and-drug-specific siginificant time by averaging across subjects intra drug groups
scale = zeros(n_eeg_ch,1);              % scale for intra-drug group normalization

% population properties: scale and siginificant time
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:n_subject
        erp = subject_galantamine(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_avg = mean(mmn_avg,2);
    if sum(chan(ch_no)==g1)
        [M1,I1] = max(mmn_avg(w1));
        [M2,I2] = min(mmn_avg(w2));
    elseif sum(chan(ch_no)==g2)
        [M1,I1] = min(mmn_avg(w1));
        [M2,I2] = max(mmn_avg(w2));
    end
    scale(ch_no) = abs(M1-M2);
    significant_ind(ch_no,1)=w1(1)+I1;
    significant_ind(ch_no,2)=w2(1)+I2;
end
significant_time = significant_ind/Fs*1000-100;

% trial-wise MMN
MMN_early = zeros(n_subject,n_eeg_ch,n_trials);
MMN_late = zeros(n_subject,n_eeg_ch,n_trials);

for ch_no = 1:n_eeg_ch
    ind = significant_ind(ch_no,:);
    for subj_no = 1:n_subject
        erp = subject_galantamine(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        mmn_erp = erp(:,ind_dev==1);
        mmn_erp = mmn_erp - repmat(std_avg,[1,sum(ind_dev)]);
        
        MMN_early(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(1)-2:ind(1)+2,:),1);
        MMN_late(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(2)-2:ind(2)+2,:),1);
    end
end

MMN_galantamine.significant_ind = significant_ind;
MMN_galantamine.significant_time = significant_time;
MMN_galantamine.channel_avg_scale = scale;

MMN_galantamine.MMN_early = MMN_early;
MMN_galantamine.MMN_late = MMN_late;

save("MMN_galantamine","MMN_galantamine")
%% lev

n_subject = size(subject_levodopa,1);
significant_ind = zeros(n_eeg_ch,2);   % find channel-and-drug-specific siginificant time by averaging across subjects intra drug groups
scale = zeros(n_eeg_ch,1);              % scale for intra-drug group normalization

% population properties: scale and siginificant time
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:n_subject
        erp = subject_levodopa(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_avg = mean(mmn_avg,2);
    if sum(chan(ch_no)==g1)
        [M1,I1] = max(mmn_avg(w1));
        [M2,I2] = min(mmn_avg(w2));
    elseif sum(chan(ch_no)==g2)
        [M1,I1] = min(mmn_avg(w1));
        [M2,I2] = max(mmn_avg(w2));
    end
    scale(ch_no) = abs(M1-M2);
    significant_ind(ch_no,1)=w1(1)+I1;
    significant_ind(ch_no,2)=w2(1)+I2;
end
significant_time = significant_ind/Fs*1000-100;

% trial-wise MMN
MMN_early = zeros(n_subject,n_eeg_ch,n_trials);
MMN_late = zeros(n_subject,n_eeg_ch,n_trials);

for ch_no = 1:n_eeg_ch
    ind = significant_ind(ch_no,:);
    for subj_no = 1:n_subject
        erp = subject_levodopa(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        mmn_erp = erp(:,ind_dev==1);
        mmn_erp = mmn_erp - repmat(std_avg,[1,sum(ind_dev)]);
        
        MMN_early(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(1)-2:ind(1)+2,:),1);
        MMN_late(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(2)-2:ind(2)+2,:),1);
    end
end

MMN_levodopa.significant_ind = significant_ind;
MMN_levodopa.significant_time = significant_time;
MMN_levodopa.channel_avg_scale = scale;

MMN_levodopa.MMN_early = MMN_early;
MMN_levodopa.MMN_late = MMN_late;

save("MMN_levodopa","MMN_levodopa")

% %%
% p1 = squeeze(MMN_levodopa.MMN_early(1,1,:));
% p2 = squeeze(MMN_galantamine.MMN_early(1,1,:));
% p3 = squeeze(MMN_biperiden.MMN_early(1,1,:));
% p4 = squeeze(MMN_amisulpride.MMN_early(1,1,:));
% p5 = squeeze(MMN_placebo.MMN_early(1,1,:));
% 
% figure
% plot(p1)
% hold on
% plot(p2)
% plot(p3)
% plot(p4)
% plot(p5)

