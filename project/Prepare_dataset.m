%%% Data Preparation for Classifier
%% Load datasets
load GLM1_levodopa.mat
load GLM1_galantamine.mat
load GLM1_amisulpride.mat
load GLM1_biperiden.mat
load GLM1_placebo.mat

%% Label Assignment
label_levodopa = ones(size(GLM_levodopa.D,1), 1);
label_galantamine = 2.* ones(size(GLM_galantamine.D,1), 1);
label_amisulpride = 3.* ones(size(GLM_amisulpride.D, 1), 1);
label_biperiden = 4.* ones(size(GLM_biperiden.D, 1), 1);
label_placebo = 5.* ones(size(GLM_placebo.D, 1), 1);

GLM_levodopa.D = [GLM_levodopa.D label_levodopa];
GLM_galantamine.D = [GLM_galantamine.D label_galantamine];
GLM_amisulpride.D = [GLM_amisulpride.D label_amisulpride];
GLM_biperiden.D = [GLM_biperiden.D label_biperiden];
GLM_placebo.D = [GLM_placebo.D label_placebo];

%% (80/20) Train-Test Split
% Levodopa
split = randperm(size(GLM_levodopa.D,1));
train_levodopa = GLM_levodopa.D(split(1:20),:);
test_levodopa = GLM_levodopa.D(split(21:26),:);
% Galantamine
split = randperm(size(GLM_galantamine.D,1));
train_galantamine = GLM_galantamine.D(split(1:20),:);
test_galantamine = GLM_galantamine.D(split(21:26),:);
% Amisulpride
split = randperm(size(GLM_amisulpride.D,1));
train_amisulpride = GLM_amisulpride.D(split(1:20),:);
test_amisulpride = GLM_amisulpride.D(split(21:25),:);
% Biperiden
split = randperm(size(GLM_biperiden.D,1));
train_biperiden = GLM_biperiden.D(split(1:19),:);
test_biperiden = GLM_biperiden.D(split(20:23),:);
% Placebo
split = randperm(size(GLM_placebo.D,1));
train_placebo = GLM_placebo.D(split(1:40),:);
test_placebo = GLM_placebo.D(split(41:51),:);

%% Create dataset
training = [train_levodopa; train_galantamine; train_amisulpride; train_biperiden; train_placebo];
testing = [test_levodopa; test_galantamine; test_amisulpride; test_biperiden; test_placebo];

train_GLM1 = training(randperm(size(training, 1)), :);
test_GLM1 = testing(randperm(size(testing, 1)), :);

save train_GLM1.mat train_GLM1
save test_GLM1.mat test_GLM1