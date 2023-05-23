cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling
addpath /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling
load stimulus_sequence.mat
load agon_dataset.mat
load agon_label.mat
load anta_dataset.mat
load anta_label.mat
load Channels.mat

%% MMN - drug group average: anta (Thu 18-05)
n_subject = size(anta_dataset,1);
n_eeg_ch = size(anta_dataset,2);
n_sample = size(anta_dataset,3);
n_trial = size(anta_dataset,4);

ind_dev = find_deviant(tones);
ind_std = find_standard_all(tones);

subject_placebo = anta_dataset(anta_label==0,:,:,:);
subject_amisulpride = anta_dataset(anta_label==1,:,:,:);
subject_biperiden = anta_dataset(anta_label==2,:,:,:);

clear anta_dataset
clear anta_label

%%
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling/figures/anta_study/Placebo/png/
mmn_placebo = [];
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:size(subject_placebo,1)
        erp = subject_placebo(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_placebo = [mmn_placebo mean(mmn_avg,2)];

    plot_areaerrorbar(mmn_avg',options)
    xlabel('t[ms]')
    ylabel('[mV]')
    title("MMN: Placebo "+chan(ch_no))
    fn = "Pla_"+chan(ch_no)+".png";
    saveas(gcf,fn)
end

%%
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling/figures/anta_study/Amisulpride/png/
mmn_amisulpride = [];
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:size(subject_amisulpride,1)
        erp = subject_amisulpride(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_amisulpride = [mmn_amisulpride mean(mmn_avg,2)];
    plot_areaerrorbar(mmn_avg',options)
    xlabel('t[ms]')
    ylabel('[mV]')
    title("MMN: Amisulpride "+chan(ch_no))
    fn = "Ami_"+chan(ch_no)+".png";
    saveas(gcf,fn)
end

%%
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling/figures/anta_study/Biperiden/png
mmn_biperiden = [];
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:size(subject_biperiden,1)
        erp = subject_biperiden(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_biperiden = [mmn_biperiden mean(mmn_avg,2)];
    plot_areaerrorbar(mmn_avg',options)
    xlabel('t[ms]')
    ylabel('[mV]')
    title("MMN: Biperiden "+chan(ch_no))
    fn = "Bip_"+chan(ch_no)+".png";
    saveas(gcf,fn)
end

%% inter-group contrast
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling/figures/anta_study/inter-drug-contrast/png/
for ch_no = 1:n_eeg_ch
    figure
    plot(t,mmn_placebo(:,ch_no),"LineWidth",1.5);
    hold on
    plot(t,mmn_amisulpride(:,ch_no),"LineWidth",1.5);
    plot(t,mmn_biperiden(:,ch_no),"LineWidth",1.5);
    hold off
    legend('Pla','Ami','Bip')
    xlabel('t[ms]')
    ylabel('MMN[mV]')
    title("Inter-Drug group Contrast (Anta) Channel: "+chan(ch_no))
    fn = chan(ch_no)+".png";
    saveas(gcf,fn)
end


%% MMN - drug group average: agon (Thu 18-05)
n_subject = size(agon_dataset,1);
n_eeg_ch = size(agon_dataset,2);
n_sample = size(agon_dataset,3);
n_trial = size(agon_dataset,4);

ind_dev = find_deviant(tones);
ind_std = find_standard_all(tones);

subject_placebo = agon_dataset(agon_label==0,:,:,:);
subject_levodopa = agon_dataset(agon_label==1,:,:,:);
subject_galantamine = agon_dataset(agon_label==2,:,:,:);

t = (1:139)/250*1000-100;
options.x_aixs = t;
        options.handle     = 1;
        options.color_area = [128 193 219]./255;    % Blue theme
        options.color_line = [ 52 148 186]./255;
        options.alpha      = 0.5;
        options.line_width = 2;
        options.error      = 'std';

clear agon_dataset
clear agon_label

%%
cd figures/agon-study/Placebo/png
mmn_placebo = [];
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:size(subject_placebo,1)
        erp = subject_placebo(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_placebo = [mmn_placebo mean(mmn_avg,2)];

    plot_areaerrorbar(mmn_avg',options)
    xlabel('t[ms]')
    ylabel('[mV]')
    title("MMN: Placebo "+chan(ch_no))
    fn = "Pla_"+chan(ch_no)+".png";
    saveas(gcf,fn)
end

%%
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling/figures/agon_study/Galantamine/png
mmn_galantamine = [];
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:size(subject_galantamine,1)
        erp = subject_galantamine(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_galantamine = [mmn_galantamine mean(mmn_avg,2)];
    plot_areaerrorbar(mmn_avg',options)
    xlabel('t[ms]')
    ylabel('[mV]')
    fn = "Gal_"+chan(ch_no)+".png";
    saveas(gcf,fn)
end

%%
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling/figures/agon_study/Levodopa/png
mmn_levodopa = [];
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:size(subject_levodopa,1)
        erp = subject_levodopa(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        dev_avg = mean(erp(:,ind_dev==1),2);
        mmn_avg = [mmn_avg dev_avg - std_avg];
    end
    mmn_levodopa = [mmn_levodopa mean(mmn_avg,2)];
    plot_areaerrorbar(mmn_avg',options)
    xlabel('t[ms]')
    ylabel('[mV]')
    title("MMN: Levodopa "+chan(ch_no))
    fn = "Lev_"+chan(ch_no)+".png";
    saveas(gcf,fn)
end

%% inter-group contrast
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling/figures/MMN-channels/agon-study/inter-drug-contrast/png/
for ch_no = 1:n_eeg_ch
    figure
    plot(t,mmn_placebo(:,ch_no),"LineWidth",1.5);
    hold on
    plot(t,mmn_galantamine(:,ch_no),"LineWidth",1.5);
    plot(t,mmn_levodopa(:,ch_no),"LineWidth",1.5);
    hold off
    legend('Pla','Gal','Lev')
    xlabel('t[ms]')
    ylabel('MMN[mV]')
    title("Inter-Drug group Contrast "+chan(ch_no))
    fn = chan(ch_no)+".png";
    saveas(gcf,fn)
end
    
%% MMN - channel scan (Wed 17-05)

ind_dev = find_deviant(tones);
ind_std = find_standard_all(tones);

% suspected bad subjects:

subject_no = 7;
subject = squeeze(agon_dataset(subject_no,:,:,:));
% subject = squeeze(anta_dataset(subject_no,:,:,:));

% ch_no = zeros(1,3);
% ch_no(1) = find(contains(chan,'Fz'));
% ch_no(2) = find(contains(chan,'F3'),1);
% ch_no(3) = find(contains(chan,'F4'),1);

%ch_no = find(matches(chan,'F4'));

cd figures/MMN-channels/agon-study/examples/subject7/
for ch_no = 1:63
    erp = subject(ch_no,:,:);
    erp = squeeze(erp);

    subject_std = erp(:,ind_std==1);
    subject_dev = erp(:,ind_dev==1);
    std_avg = mean(subject_std,2);
    dev_avg = mean(subject_dev,2);
    mmn_avg = dev_avg - std_avg;

    figure
    subplot(211)
    plot((1:139)/250*1000-100,std_avg,'LineWidth',1)
    hold on
    plot((1:139)/250*1000-100,dev_avg,'LineWidth',1)
    legend('Averaged standard','Average deviant')
    title("subject "+num2str(subject_no)+", channel: "+chan(ch_no)+", drug type: "+num2str(agon_label(subject_no)))
    subplot(212)
    plot((1:139)/250*1000-100,mmn_avg,'LineWidth',1)
    legend('average MMN')
    fn = chan(ch_no)+"_Pla"+"_subj"+subject_no+".fig";
    saveas(gcf,fn)
end
    % MMN_ERP = subject_dev - repmat(std_avg,[1 119]);

%% try: another approach to quantify MMN

ERP_max_windowed = max(erp(51:75,:),[],1);
ERP_min_windowed = min(erp(51:75,:),[],1);
MMN_new = ERP_max_windowed - ERP_min_windowed;

ind_std_all = find_standard_all(tones);
%ind_std = find_standard(tones);
MMN_new(ind_std_all==1) = mean(MMN_new(ind_std_all==1));
%MMN_new(ind_std==1) = mean(MMN_new(ind_std_all==1));
MMN_new = MMN_new/mean(MMN_new(ind_std_all==1));
%MMN_new = MMN_new/mean(MMN_new(ind_std==1));
figure
plot(MMN_new)
title("MMN(test): subject "+num2str(subject_no)+" drug type: "+num2str(agon_label(subject_no)))

