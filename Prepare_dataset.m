%%% Data Preparation for Classifier
%% Load datasets
GLM_levodopa = load("selected_GLM1_levodopa.mat");
GLM_galantamine = load("selected_GLM1_galantamine.mat");
GLM_amisulpride = load("selected_GLM1_amisulpride.mat");
GLM_biperiden = load("selected_GLM1_biperiden.mat");
GLM_placebo = load("selected_GLM1_placebo.mat");

GLM_levodopa = GLM_levodopa.GLM_levodopa;
GLM_galantamine = GLM_galantamine.GLM_galantamine;
GLM_amisulpride = GLM_amisulpride.GLM_amisulpride;
GLM_biperiden = GLM_biperiden.GLM_biperiden;
GLM_placebo = GLM_placebo.GLM_placebo;

%% Label Assignment
label_levodopa = ones(size(GLM_levodopa,1), 1);
label_galantamine = 2.* ones(size(GLM_galantamine,1), 1);
label_amisulpride = 3.* ones(size(GLM_amisulpride, 1), 1);
label_biperiden = 4.* ones(size(GLM_biperiden, 1), 1);
label_placebo = 5.* ones(size(GLM_placebo, 1), 1);

GLM_levodopa = [GLM_levodopa label_levodopa];
GLM_galantamine = [GLM_galantamine label_galantamine];
GLM_amisulpride = [GLM_amisulpride label_amisulpride];
GLM_biperiden = [GLM_biperiden label_biperiden];
GLM_placebo = [GLM_placebo label_placebo];

%% (80/20) Train-Test Split
% Levodopa
split = randperm(size(GLM_levodopa,1));
train_levodopa = GLM_levodopa(split(1:20),:);
test_levodopa = GLM_levodopa(split(21:26),:);
% Galantamine
split = randperm(size(GLM_galantamine,1));
train_galantamine = GLM_galantamine(split(1:20),:);
test_galantamine = GLM_galantamine(split(21:26),:);
% Amisulpride
split = randperm(size(GLM_amisulpride,1));
train_amisulpride = GLM_amisulpride(split(1:20),:);
test_amisulpride = GLM_amisulpride(split(21:25),:);
% Biperiden
split = randperm(size(GLM_biperiden,1));
train_biperiden = GLM_biperiden(split(1:19),:);
test_biperiden = GLM_biperiden(split(20:23),:);
% Placebo
placebo_anta = GLM_placebo(1:25,:);
split = randperm(size(placebo_anta,1));
train_placebo_anta = placebo_anta(split(1:20),:);
test_placebo_anta = placebo_anta(split(21:25),:);

placebo_agon = GLM_placebo(26:51,:);
split = randperm(size(placebo_agon,1));
train_placebo_agon = placebo_agon(split(1:20),:);
test_placebo_agon = placebo_agon(split(21:26),:);

split = randperm(size(GLM_placebo,1));
train_placebo = GLM_placebo(split(1:40),:);
test_placebo = GLM_placebo(split(41:51),:);

%% Create dataset
% Whole dataset
train_GLM1 = [train_levodopa; train_galantamine; train_amisulpride; train_biperiden; train_placebo];
test_GLM1 = [test_levodopa; test_galantamine; test_amisulpride; test_biperiden; test_placebo];
train_GLM1 = train_GLM1(randperm(size(train_GLM1, 1)), :);
test_GLM1 = test_GLM1(randperm(size(test_GLM1, 1)), :);

% Dataset Anta: Amisulpride, Biperiden, Placebo (First 25)
train_GLM1_amis_bipe = [train_amisulpride; train_biperiden];
train_GLM1_amis_bipe = train_GLM1_amis_bipe(randperm(size(train_GLM1_amis_bipe, 1)), :);
test_GLM1_amis_bipe = [test_amisulpride; test_biperiden];
test_GLM1_amis_bipe = test_GLM1_amis_bipe(randperm(size(test_GLM1_amis_bipe, 1)), :);

train_GLM1_amis_plac = [train_amisulpride; train_placebo_anta];
train_GLM1_amis_plac = train_GLM1_amis_plac(randperm(size(train_GLM1_amis_plac, 1)), :);
test_GLM1_amis_plac = [test_amisulpride; test_placebo_anta];
test_GLM1_amis_plac = test_GLM1_amis_plac(randperm(size(test_GLM1_amis_plac, 1)), :);

train_GLM1_bipe_plac = [train_biperiden; train_placebo_anta];
train_GLM1_bipe_plac = train_GLM1_bipe_plac(randperm(size(train_GLM1_bipe_plac, 1)), :);
test_GLM1_bipe_plac = [test_biperiden; test_placebo_anta];
test_GLM1_bipe_plac = test_GLM1_bipe_plac(randperm(size(test_GLM1_bipe_plac, 1)), :);

% Dataset Agon: Levodopa, Galantamine, Placebo (Last 26)
train_GLM1_levo_gala = [train_levodopa; train_galantamine];
train_GLM1_levo_gala = train_GLM1_levo_gala(randperm(size(train_GLM1_levo_gala, 1)), :);
test_GLM1_levo_gala = [test_levodopa; test_galantamine];
test_GLM1_levo_gala = test_GLM1_levo_gala(randperm(size(test_GLM1_levo_gala, 1)), :);

train_GLM1_levo_plac = [train_levodopa; train_placebo_agon];
train_GLM1_levo_plac = train_GLM1_levo_plac(randperm(size(train_GLM1_levo_plac, 1)), :);
test_GLM1_levo_plac = [test_levodopa; test_placebo_agon];
test_GLM1_levo_plac = test_GLM1_levo_plac(randperm(size(test_GLM1_levo_plac, 1)), :);

train_GLM1_gala_plac = [train_galantamine; train_placebo_agon];
train_GLM1_gala_plac = train_GLM1_gala_plac(randperm(size(train_GLM1_gala_plac, 1)), :);
test_GLM1_gala_plac = [test_galantamine; test_placebo_agon];
test_GLM1_gala_plac = test_GLM1_gala_plac(randperm(size(test_GLM1_gala_plac, 1)), :);

%%
save train_GLM1.mat train_GLM1
save test_GLM1.mat test_GLM1

save train_GLM1_amis_bipe.mat train_GLM1_amis_bipe
save test_GLM1_amis_bipe.mat test_GLM1_amis_bipe
save train_GLM1_amis_plac.mat train_GLM1_amis_plac
save test_GLM1_amis_plac.mat test_GLM1_amis_plac
save train_GLM1_bipe_plac.mat train_GLM1_bipe_plac
save test_GLM1_bipe_plac.mat test_GLM1_bipe_plac

save train_GLM1_levo_gala.mat train_GLM1_levo_gala
save test_GLM1_levo_gala.mat test_GLM1_levo_gala
save train_GLM1_levo_plac.mat train_GLM1_levo_plac
save test_GLM1_levo_plac.mat test_GLM1_levo_plac
save train_GLM1_gala_plac.mat train_GLM1_gala_plac
save test_GLM1_gala_plac.mat test_GLM1_gala_plac