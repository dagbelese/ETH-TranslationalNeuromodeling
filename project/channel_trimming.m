% Clustering and channel selection
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling

load Channels.mat
load MMN_amisulpride.mat
load MMN_biperiden.mat
load MMN_galantamine.mat
load MMN_levodopa.mat
load MMN_Placebo.mat

%% Channel clustering
cl1 = ["C1","C2","Cz","CPz","FCz","FC1","FC2"];
cl2 = ["Fp1","Fp2","AF7"];
cl3 = ["Pz","POz","P1","P2"];
cl4 = ["C3","C5","CP3","CP5"];
cl5 = ["FC3","FC5","C5","F3","FT7"];
cl6 = ["FC2","FC4","C2","C4","CP4"];
cl7 = ["P4","P6","PO4","PO8"];

n_clusters = 7;
ch_ind_cl = zeros(n_clusters,length(chan));
ch_ind_cl = logical(ch_ind_cl);
ch_ind_cl(1,:) = matches(chan,cl1);
ch_ind_cl(2,:) = matches(chan,cl2);
ch_ind_cl(3,:) = matches(chan,cl3);
ch_ind_cl(4,:) = matches(chan,cl4);
ch_ind_cl(5,:) = matches(chan,cl5);
ch_ind_cl(6,:) = matches(chan,cl6);
ch_ind_cl(7,:) = matches(chan,cl7);

%% Channel selection
representative = ["Cz","FCz","AF7","Pz","F3","C5","POz"];
rep_ind = matches(chan,representative);

%% amisulpride
MMN_early = MMN_amisulpride.MMN_early;
MMN_late = MMN_amisulpride.MMN_late;
n_subjects = size(MMN_early,1);
clustered_MMN_early = zeros(n_subjects,n_clusters,1800);
clustered_MMN_late = zeros(n_subjects,n_clusters,1800);

% clustering
for i = 1:n_clusters
    clustered_MMN_early(:,i,:) = mean(MMN_early(:,ch_ind_cl(i,:),:),2);
    clustered_MMN_late(:,i,:) = mean(MMN_late(:,ch_ind_cl(i,:),:),2);
end

clustered_MMN_amisulpride = MMN_amisulpride;
clustered_MMN_amisulpride.MMN_early = clustered_MMN_early;
clustered_MMN_amisulpride.MMN_late = clustered_MMN_late;

save("clustered_MMN_amisulpride","clustered_MMN_amisulpride");

% selecting
selected_MMN_early = MMN_early(:,rep_ind,:);
selected_MMN_late = MMN_late(:,rep_ind,:);
selected_MMN_amisulpride = MMN_amisulpride;
selected_MMN_amisulpride.MMN_early = selected_MMN_early;
selected_MMN_amisulpride.MMN_late = selected_MMN_late;
selected_MMN_amisulpride.selected_channel = representative;

save("selected_MMN_amisulpride","selected_MMN_amisulpride");

%% biperiden
MMN_early = MMN_biperiden.MMN_early;
MMN_late = MMN_biperiden.MMN_late;

n_subjects = size(MMN_early,1);
clustered_MMN_early = zeros(n_subjects,n_clusters,1800);
clustered_MMN_late = zeros(n_subjects,n_clusters,1800);

for i = 1:n_clusters
    clustered_MMN_early(:,i,:) = mean(MMN_early(:,ch_ind_cl(i,:),:),2);
    clustered_MMN_late(:,i,:) = mean(MMN_late(:,ch_ind_cl(i,:),:),2);
end

clustered_MMN_biperiden = MMN_biperiden;
clustered_MMN_biperiden.MMN_early = clustered_MMN_early;
clustered_MMN_biperiden.MMN_late = clustered_MMN_late;

save("clustered_MMN_biperiden","clustered_MMN_biperiden");

% selecting
selected_MMN_early = MMN_early(:,rep_ind,:);
selected_MMN_late = MMN_late(:,rep_ind,:);
selected_MMN_biperiden = MMN_biperiden;
selected_MMN_biperiden.MMN_early = selected_MMN_early;
selected_MMN_biperiden.MMN_late = selected_MMN_late;
selected_MMN_biperiden.selected_channel = representative;

save("selected_MMN_biperiden","selected_MMN_biperiden");

%% galantamine
MMN_early = MMN_galantamine.MMN_early;
MMN_late = MMN_galantamine.MMN_late;
n_subjects = size(MMN_early,1);
clustered_MMN_early = zeros(n_subjects,n_clusters,1800);
clustered_MMN_late = zeros(n_subjects,n_clusters,1800);

for i = 1:n_clusters
    clustered_MMN_early(:,i,:) = mean(MMN_early(:,ch_ind_cl(i,:),:),2);
    clustered_MMN_late(:,i,:) = mean(MMN_late(:,ch_ind_cl(i,:),:),2);
end

clustered_MMN_galantamine = MMN_galantamine;
clustered_MMN_galantamine.MMN_early = clustered_MMN_early;
clustered_MMN_galantamine.MMN_late = clustered_MMN_late;

save("clustered_MMN_galantamine","clustered_MMN_galantamine");

% selecting
selected_MMN_early = MMN_early(:,rep_ind,:);
selected_MMN_late = MMN_late(:,rep_ind,:);
selected_MMN_galantamine = MMN_galantamine;
selected_MMN_galantamine.MMN_early = selected_MMN_early;
selected_MMN_galantamine.MMN_late = selected_MMN_late;
selected_MMN_galantamine.selected_channel = representative;

save("selected_MMN_galantamine","selected_MMN_galantamine");

%% levodopa
MMN_early = MMN_levodopa.MMN_early;
MMN_late = MMN_levodopa.MMN_late;
n_subjects = size(MMN_early,1);
clustered_MMN_early = zeros(n_subjects,n_clusters,1800);
clustered_MMN_late = zeros(n_subjects,n_clusters,1800);

for i = 1:n_clusters
    clustered_MMN_early(:,i,:) = mean(MMN_early(:,ch_ind_cl(i,:),:),2);
    clustered_MMN_late(:,i,:) = mean(MMN_late(:,ch_ind_cl(i,:),:),2);
end

clustered_MMN_levodopa = MMN_levodopa;
clustered_MMN_levodopa.MMN_early = clustered_MMN_early;
clustered_MMN_levodopa.MMN_late = clustered_MMN_late;

save("clustered_MMN_levodopa","clustered_MMN_levodopa");

% selecting
selected_MMN_early = MMN_early(:,rep_ind,:);
selected_MMN_late = MMN_late(:,rep_ind,:);
selected_MMN_levodopa = MMN_levodopa;
selected_MMN_levodopa.MMN_early = selected_MMN_early;
selected_MMN_levodopa.MMN_late = selected_MMN_late;
selected_MMN_levodopa.selected_channel = representative;

save("selected_MMN_levodopa","selected_MMN_levodopa");

%% placebo
MMN_early = MMN_placebo.MMN_early;
MMN_late = MMN_placebo.MMN_late;
n_subjects = size(MMN_early,1);
clustered_MMN_early = zeros(n_subjects,n_clusters,1800);
clustered_MMN_late = zeros(n_subjects,n_clusters,1800);

for i = 1:n_clusters
    clustered_MMN_early(:,i,:) = mean(MMN_early(:,ch_ind_cl(i,:),:),2);
    clustered_MMN_late(:,i,:) = mean(MMN_late(:,ch_ind_cl(i,:),:),2);
end

clustered_MMN_placebo = MMN_placebo;
clustered_MMN_placebo.MMN_early = clustered_MMN_early;
clustered_MMN_placebo.MMN_late = clustered_MMN_late;

save("clustered_MMN_placebo","clustered_MMN_placebo");

% selecting
selected_MMN_early = MMN_early(:,rep_ind,:);
selected_MMN_late = MMN_late(:,rep_ind,:);
selected_MMN_placebo = MMN_placebo;
selected_MMN_placebo.MMN_early = selected_MMN_early;
selected_MMN_placebo.MMN_late = selected_MMN_late;
selected_MMN_placebo.selected_channel = representative;

save("selected_MMN_placebo","selected_MMN_placebo");
