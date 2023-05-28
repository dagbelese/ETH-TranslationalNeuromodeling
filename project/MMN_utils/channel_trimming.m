% Clustering and channel selection
clearvars
clc
cd /Users/liyitong/Documents/Frühlingssemester-2023/TN/TranslationalNeuromodelling
addpath MMN_utils/
load Channels.mat

%% Cluster selection
cl1 = ["Fp1","Fp2","AF7"];
cl2 = ["P1","P2","Pz"];
cl3 = ["C1","C2","Cz"];
cl4 = ["FCz","FC1","FC2"];
cl5 = ["CPz","CP1","CP2","Pz"];
cl6 = ["Cz","Fz"];
cl7 = ["FC4","CP4","C4","C6"];
cl8 = ["C3","CP3","CP5"];
cl9 = ["P3","P5","CP3"];

n_clusters = 9;
ch_ind_cl = zeros(n_clusters,length(chan));
ch_ind_cl = logical(ch_ind_cl);
ch_ind_cl(1,:) = matches(chan,cl1);
ch_ind_cl(2,:) = matches(chan,cl2);
ch_ind_cl(3,:) = matches(chan,cl3);
ch_ind_cl(4,:) = matches(chan,cl4);
ch_ind_cl(5,:) = matches(chan,cl5);
ch_ind_cl(6,:) = matches(chan,cl6);
ch_ind_cl(7,:) = matches(chan,cl7);
ch_ind_cl(8,:) = matches(chan,cl8);
ch_ind_cl(9,:) = matches(chan,cl9);

%% Single channel selection
%representative = ["Fp1","C3","Cz","FCz","FC5","C1","CPz","AF7","Pz","F3","C4","C5","POz","P4"];
representative = ["Fp1","C3","P3","P7","Fz","Pz","CP1","CP5","C1","P2","P5","FC4","AF7","FCz"];
rep_ind = matches(chan,representative);

%% clustering
cd MMN_data/

% uni-phase
load uni-phase-MMN/all-channels/uni_phase_MMN_amisulpride.mat
load uni-phase-MMN/all-channels/uni_phase_MMN_biperiden.mat
load uni-phase-MMN/all-channels/uni_phase_MMN_galantamine.mat
load uni-phase-MMN/all-channels/uni_phase_MMN_levodopa.mat
load uni-phase-MMN/all-channels/uni_phase_MMN_Placebo.mat
n_phase = 1;
cl_uni_phase_MMN_ami = clustering(uni_phase_MMN_amisulpride,n_phase,n_clusters,ch_ind_cl);
cl_uni_phase_MMN_bip = clustering(uni_phase_MMN_biperiden,n_phase,n_clusters,ch_ind_cl);
cl_uni_phase_MMN_gal = clustering(uni_phase_MMN_galantamine,n_phase,n_clusters,ch_ind_cl);
cl_uni_phase_MMN_lev = clustering(uni_phase_MMN_levodopa,n_phase,n_clusters,ch_ind_cl);
cl_uni_phase_MMN_pla = clustering(uni_phase_MMN_placebo,n_phase,n_clusters,ch_ind_cl);

save uni-phase-MMN/clusters/cl_uni_phase_MMN_ami cl_uni_phase_MMN_ami
save uni-phase-MMN/clusters/cl_uni_phase_MMN_bip cl_uni_phase_MMN_bip
save uni-phase-MMN/clusters/cl_uni_phase_MMN_gal cl_uni_phase_MMN_gal
save uni-phase-MMN/clusters/cl_uni_phase_MMN_lev cl_uni_phase_MMN_lev
save uni-phase-MMN/clusters/cl_uni_phase_MMN_pla cl_uni_phase_MMN_pla

% bi-phase
load bi-phase-MMN/all-channels/bi_phase_MMN_amisulpride.mat
load bi-phase-MMN/all-channels/bi_phase_MMN_biperiden.mat
load bi-phase-MMN/all-channels/bi_phase_MMN_galantamine.mat
load bi-phase-MMN/all-channels/bi_phase_MMN_levodopa.mat
load bi-phase-MMN/all-channels/bi_phase_MMN_placebo.mat

n_phase = 2;
cl_bi_phase_MMN_ami = clustering(bi_phase_MMN_amisulpride,n_phase,n_clusters,ch_ind_cl);
cl_bi_phase_MMN_bip = clustering(bi_phase_MMN_biperiden,n_phase,n_clusters,ch_ind_cl);
cl_bi_phase_MMN_gal = clustering(bi_phase_MMN_galantamine,n_phase,n_clusters,ch_ind_cl);
cl_bi_phase_MMN_lev = clustering(bi_phase_MMN_levodopa,n_phase,n_clusters,ch_ind_cl);
cl_bi_phase_MMN_pla = clustering(bi_phase_MMN_placebo,n_phase,n_clusters,ch_ind_cl);

save bi-phase-MMN/clusters/cl_bi_phase_MMN_ami cl_bi_phase_MMN_ami
save bi-phase-MMN/clusters/cl_bi_phase_MMN_bip cl_bi_phase_MMN_bip
save bi-phase-MMN/clusters/cl_bi_phase_MMN_gal cl_bi_phase_MMN_gal
save bi-phase-MMN/clusters/cl_bi_phase_MMN_lev cl_bi_phase_MMN_lev
save bi-phase-MMN/clusters/cl_bi_phase_MMN_pla cl_bi_phase_MMN_pla


% quad-phase
load quad-phase-MMN/all-channels/quad_phase_MMN_amisulpride.mat
load quad-phase-MMN/all-channels/quad_phase_MMN_biperiden.mat
load quad-phase-MMN/all-channels/quad_phase_MMN_galantamine.mat
load quad-phase-MMN/all-channels/quad_phase_MMN_levodopa.mat
load quad-phase-MMN/all-channels/quad_phase_MMN_placebo.mat

n_phase = 4;
cl_quad_phase_MMN_ami = clustering(quad_phase_MMN_amisulpride,n_phase,n_clusters,ch_ind_cl);
cl_quad_phase_MMN_bip = clustering(quad_phase_MMN_biperiden,n_phase,n_clusters,ch_ind_cl);
cl_quad_phase_MMN_gal = clustering(quad_phase_MMN_galantamine,n_phase,n_clusters,ch_ind_cl);
cl_quad_phase_MMN_lev = clustering(quad_phase_MMN_levodopa,n_phase,n_clusters,ch_ind_cl);
cl_quad_phase_MMN_pla = clustering(quad_phase_MMN_placebo,n_phase,n_clusters,ch_ind_cl);

save quad-phase-MMN/clusters/cl_quad_phase_MMN_ami cl_quad_phase_MMN_ami
save quad-phase-MMN/clusters/cl_quad_phase_MMN_bip cl_quad_phase_MMN_bip
save quad-phase-MMN/clusters/cl_quad_phase_MMN_gal cl_quad_phase_MMN_gal
save quad-phase-MMN/clusters/cl_quad_phase_MMN_lev cl_quad_phase_MMN_lev
save quad-phase-MMN/clusters/cl_quad_phase_MMN_pla cl_quad_phase_MMN_pla


%% selecting
% uni-phase
n_phase = 1;
slc_uni_phase_MMN_ami = selecting(uni_phase_MMN_amisulpride,n_phase,representative, rep_ind);
slc_uni_phase_MMN_bip = selecting(uni_phase_MMN_biperiden,n_phase,representative, rep_ind);
slc_uni_phase_MMN_gal = selecting(uni_phase_MMN_galantamine,n_phase,representative, rep_ind);
slc_uni_phase_MMN_lev = selecting(uni_phase_MMN_levodopa,n_phase,representative, rep_ind);
slc_uni_phase_MMN_pla = selecting(uni_phase_MMN_placebo,n_phase,representative, rep_ind);

save uni-phase-MMN/selected-channels/slc_uni_phase_MMN_ami slc_uni_phase_MMN_ami
save uni-phase-MMN/selected-channels/slc_uni_phase_MMN_bip slc_uni_phase_MMN_bip
save uni-phase-MMN/selected-channels/slc_uni_phase_MMN_gal slc_uni_phase_MMN_gal
save uni-phase-MMN/selected-channels/slc_uni_phase_MMN_lev slc_uni_phase_MMN_lev
save uni-phase-MMN/selected-channels/slc_uni_phase_MMN_pla slc_uni_phase_MMN_pla

% bi-phase
n_phase = 2;
slc_bi_phase_MMN_ami = selecting(bi_phase_MMN_amisulpride,n_phase,representative, rep_ind);
slc_bi_phase_MMN_bip = selecting(bi_phase_MMN_biperiden,n_phase,representative, rep_ind);
slc_bi_phase_MMN_gal = selecting(bi_phase_MMN_galantamine,n_phase,representative, rep_ind);
slc_bi_phase_MMN_lev = selecting(bi_phase_MMN_levodopa,n_phase,representative, rep_ind);
slc_bi_phase_MMN_pla = selecting(bi_phase_MMN_placebo,n_phase,representative, rep_ind);

save bi-phase-MMN/selected-channels/slc_bi_phase_MMN_ami slc_bi_phase_MMN_ami
save bi-phase-MMN/selected-channels/slc_bi_phase_MMN_bip slc_bi_phase_MMN_bip
save bi-phase-MMN/selected-channels/slc_bi_phase_MMN_gal slc_bi_phase_MMN_gal
save bi-phase-MMN/selected-channels/slc_bi_phase_MMN_lev slc_bi_phase_MMN_lev
save bi-phase-MMN/selected-channels/slc_bi_phase_MMN_pla slc_bi_phase_MMN_pla

% quad-phase
n_phase = 4;
slc_quad_phase_MMN_ami = selecting(quad_phase_MMN_amisulpride,n_phase,representative, rep_ind);
slc_quad_phase_MMN_bip = selecting(quad_phase_MMN_biperiden,n_phase,representative, rep_ind);
slc_quad_phase_MMN_gal = selecting(quad_phase_MMN_galantamine,n_phase,representative, rep_ind);
slc_quad_phase_MMN_lev = selecting(quad_phase_MMN_levodopa,n_phase,representative, rep_ind);
slc_quad_phase_MMN_pla = selecting(quad_phase_MMN_placebo,n_phase,representative, rep_ind);

save quad-phase-MMN/selected-channels/slc_quad_phase_MMN_ami slc_quad_phase_MMN_ami
save quad-phase-MMN/selected-channels/slc_quad_phase_MMN_bip slc_quad_phase_MMN_bip
save quad-phase-MMN/selected-channels/slc_quad_phase_MMN_gal slc_quad_phase_MMN_gal
save quad-phase-MMN/selected-channels/slc_quad_phase_MMN_lev slc_quad_phase_MMN_lev
save quad-phase-MMN/selected-channels/slc_quad_phase_MMN_pla slc_quad_phase_MMN_pla


