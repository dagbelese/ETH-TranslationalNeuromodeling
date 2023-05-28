function selected_MMN = selecting(MMN,n_phase,representative, rep_ind)

if n_phase==1
    MMN_early = MMN.MMN_early;
    MMN_late = MMN.MMN_late;
    % selecting
    selected_MMN_early = MMN_early(:,rep_ind,:);
    selected_MMN_late = MMN_late(:,rep_ind,:);
    selected_MMN = MMN;
    selected_MMN.MMN_early = selected_MMN_early;
    selected_MMN.MMN_late = selected_MMN_late;
    selected_MMN.selected_channel = representative;

elseif n_phase==2
    MMN_early_p1 = MMN.phase_1.MMN_early;
    MMN_late_p1 = MMN.phase_1.MMN_late;
    MMN_early_p2 = MMN.phase_2.MMN_early;
    MMN_late_p2 = MMN.phase_2.MMN_late;
    % selecting
    selected_MMN_early_p1 = MMN_early_p1(:,rep_ind,:);
    selected_MMN_late_p1 = MMN_late_p1(:,rep_ind,:);
    selected_MMN_early_p2 = MMN_early_p2(:,rep_ind,:);
    selected_MMN_late_p2 = MMN_late_p2(:,rep_ind,:);
    selected_MMN = MMN;
    selected_MMN.phase_1.MMN_early = selected_MMN_early_p1;
    selected_MMN.phase_1.MMN_late = selected_MMN_late_p1;
    selected_MMN.phase_2.MMN_early = selected_MMN_early_p2;
    selected_MMN.phase_2.MMN_late = selected_MMN_late_p2;
    selected_MMN.selected_channel = representative;

elseif n_phase==4
    MMN_early_p1 = MMN.phase_1.MMN_early;
    MMN_late_p1 = MMN.phase_1.MMN_late;
    MMN_early_p2 = MMN.phase_2.MMN_early;
    MMN_late_p2 = MMN.phase_2.MMN_late;
    MMN_early_p3 = MMN.phase_3.MMN_early;
    MMN_late_p3 = MMN.phase_3.MMN_late;
    MMN_early_p4 = MMN.phase_4.MMN_early;
    MMN_late_p4 = MMN.phase_4.MMN_late;
    % selecting
    selected_MMN_early_p1 = MMN_early_p1(:,rep_ind,:);
    selected_MMN_late_p1 = MMN_late_p1(:,rep_ind,:);
    selected_MMN_early_p2 = MMN_early_p2(:,rep_ind,:);
    selected_MMN_late_p2 = MMN_late_p2(:,rep_ind,:);
    selected_MMN_early_p3 = MMN_early_p3(:,rep_ind,:);
    selected_MMN_late_p3 = MMN_late_p3(:,rep_ind,:);
    selected_MMN_early_p4 = MMN_early_p4(:,rep_ind,:);
    selected_MMN_late_p4 = MMN_late_p4(:,rep_ind,:);
    selected_MMN = MMN;
    selected_MMN.phase_1.MMN_early = selected_MMN_early_p1;
    selected_MMN.phase_1.MMN_late = selected_MMN_late_p1;
    selected_MMN.phase_2.MMN_early = selected_MMN_early_p2;
    selected_MMN.phase_2.MMN_late = selected_MMN_late_p2;
    selected_MMN.phase_3.MMN_early = selected_MMN_early_p3;
    selected_MMN.phase_3.MMN_late = selected_MMN_late_p3;
    selected_MMN.phase_4.MMN_early = selected_MMN_early_p4;
    selected_MMN.phase_4.MMN_late = selected_MMN_late_p4;
    selected_MMN.selected_channel = representative;

end
