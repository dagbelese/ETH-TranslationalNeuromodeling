%% Data Exploration
% Dataset: SubjectNr x Channels X Samples X Tones/Trials
% Agon labels: Levodopa (Dopamine) = 1, Galantamine (Acetylcholine) = 2,
% Placebo = 0
% Anta labels: Amisulpride (Dopamine) = 1, Biperiden (Acetylcholine) = 2,
% Placebo = 0
agon_dataset = load('agon_dataset.mat');
anta_dataset = load('anta_dataset.mat');
agon_label = load('agon_label.mat');
anta_label = load('anta_label.mat');

%% Agon dataset


%% Anta dataset