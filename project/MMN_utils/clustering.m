function clustered_MMN = clustering(MMN,n_phase,n_clusters,cl_ch_ind)

n_trials = 1800;

if n_phase==1
    mmn_early = MMN.MMN_early;
    mmn_late = MMN.MMN_late;
    n_subjects = size(mmn_early,1);
    clustered_MMN_early = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_late = zeros(n_subjects,n_clusters,n_trials);
    % clustering
    for i = 1:n_clusters
        clustered_MMN_early(:,i,:) = mean(mmn_early(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_late(:,i,:) = mean(mmn_late(:,cl_ch_ind(i,:),:),2);
    end
    clustered_MMN.MMN_early = clustered_MMN_early;
    clustered_MMN.MMN_late = clustered_MMN_late;

elseif n_phase==2
    mmn_early_p1 = MMN.phase_1.MMN_early;
    mmn_late_p1 = MMN.phase_1.MMN_late;
    mmn_early_p2 = MMN.phase_2.MMN_early;
    mmn_late_p2 = MMN.phase_2.MMN_late;
    n_subjects = size(mmn_early_p1,1);
    clustered_MMN_early_p1 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_late_p1 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_early_p2 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_late_p2 = zeros(n_subjects,n_clusters,n_trials);
    % clustering
    for i = 1:n_clusters
        clustered_MMN_early_p1(:,i,:) = mean(mmn_early_p1(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_late_p1(:,i,:) = mean(mmn_late_p1(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_early_p2(:,i,:) = mean(mmn_early_p2(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_late_p2(:,i,:) = mean(mmn_late_p2(:,cl_ch_ind(i,:),:),2);
    end
    clustered_MMN.phase_1.MMN_early = clustered_MMN_early_p1;
    clustered_MMN.phase_1.MMN_late = clustered_MMN_late_p1;
    clustered_MMN.phase_2.MMN_early = clustered_MMN_early_p2;
    clustered_MMN.phase_2.MMN_late = clustered_MMN_late_p2;

elseif n_phase==4
    mmn_early_p1 = MMN.phase_1.MMN_early;
    mmn_late_p1 = MMN.phase_1.MMN_late;
    mmn_early_p2 = MMN.phase_2.MMN_early;
    mmn_late_p2 = MMN.phase_2.MMN_late;
    mmn_early_p3 = MMN.phase_3.MMN_early;
    mmn_late_p3 = MMN.phase_3.MMN_late;
    mmn_early_p4 = MMN.phase_4.MMN_early;
    mmn_late_p4 = MMN.phase_4.MMN_late;

    n_subjects = size(mmn_early_p1,1);
    clustered_MMN_early_p1 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_late_p1 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_early_p2 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_late_p2 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_early_p3 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_late_p3 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_early_p4 = zeros(n_subjects,n_clusters,n_trials);
    clustered_MMN_late_p4 = zeros(n_subjects,n_clusters,n_trials);
    % clustering
    for i = 1:n_clusters
        clustered_MMN_early_p1(:,i,:) = mean(mmn_early_p1(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_late_p1(:,i,:) = mean(mmn_late_p1(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_early_p2(:,i,:) = mean(mmn_early_p2(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_late_p2(:,i,:) = mean(mmn_late_p2(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_early_p3(:,i,:) = mean(mmn_early_p3(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_late_p3(:,i,:) = mean(mmn_late_p3(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_early_p4(:,i,:) = mean(mmn_early_p4(:,cl_ch_ind(i,:),:),2);
        clustered_MMN_late_p4(:,i,:) = mean(mmn_late_p4(:,cl_ch_ind(i,:),:),2);
    end
    clustered_MMN.phase_1.MMN_early = clustered_MMN_early_p1;
    clustered_MMN.phase_1.MMN_late = clustered_MMN_late_p1;
    clustered_MMN.phase_2.MMN_early = clustered_MMN_early_p2;
    clustered_MMN.phase_2.MMN_late = clustered_MMN_late_p2;
    clustered_MMN.phase_3.MMN_early = clustered_MMN_early_p3;
    clustered_MMN.phase_3.MMN_late = clustered_MMN_late_p3;
    clustered_MMN.phase_4.MMN_early = clustered_MMN_early_p4;
    clustered_MMN.phase_4.MMN_late = clustered_MMN_late_p4;
end