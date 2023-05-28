function [mmn_early,mmn_late] = mmn_trial_wise(ERP,chan,n_subj,n_trials,g1, g2, ind_std, ind_dev, w1, w2,significant_ind,scale)

n_eeg_ch=63;
mmn_early = zeros(n_subj,n_eeg_ch,n_trials);
mmn_late = zeros(n_subj,n_eeg_ch,n_trials);

for ch_no = 1:n_eeg_ch
    ind = significant_ind(ch_no,:);
    norm = scale(ch_no);
    for subj_no = 1:n_subj
        erp = ERP(subj_no,ch_no,:,:);
        erp = squeeze(erp);
        std_avg = mean(erp(:,ind_std==1),2);
        mmn_erp = erp(:,ind_dev==1);
        mmn_erp = mmn_erp - repmat(std_avg,[1,sum(ind_dev)]);

        mmn_erp_avg = mean(mmn_erp,2);% avg MMN ERP for this subject this channel
        if sum(chan(ch_no)==g1)
            M1_subj = max(mmn_erp_avg(w1));
            M2_subj = min(mmn_erp_avg(w2));
        elseif sum(chan(ch_no)==g2)
            M1_subj = min(mmn_erp_avg(w1));
            M2_subj = max(mmn_erp_avg(w2));
        end
        scale_subj = abs(M1_subj-M2_subj);
        
        % normalization
        mmn_early(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(1)-2:ind(1)+2,:),1)/scale_subj*norm;
        mmn_late(subj_no,ch_no,ind_dev==1) = mean(mmn_erp(ind(2)-2:ind(2)+2,:),1)/scale_subj*norm;
    end
end