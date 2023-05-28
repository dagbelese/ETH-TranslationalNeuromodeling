function [significant_ind,significant_time,scale] = mmn_population_property(ERP,chan,n_subj,ind_std,ind_dev,g1,g2,w1,w2, Fs, pre_time)
% get MMN population properties per channel per drug-group 

n_eeg_ch=63;
significant_ind = zeros(n_eeg_ch,2);   % find channel-and-drug-specific siginificant time by averaging across subjects intra drug groups
scale = zeros(n_eeg_ch,1);              % scale for intra-drug group normalization

% population properties: scale and siginificant time
for ch_no = 1:n_eeg_ch
    mmn_avg = [];
    for subj_no = 1:n_subj
        erp = ERP(subj_no,ch_no,:,:);
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
significant_time = significant_ind/Fs*1000-pre_time;

