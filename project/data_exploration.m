%% Data Exploration
% Dataset: SubjectNr x Channels X Samples X Tones/Trials
% Agon labels: Levodopa (Dopamine) = 1, Galantamine (Acetylcholine) = 2,
% Placebo = 0
% Anta labels: Amisulpride (Dopamine) = 1, Biperiden (Acetylcholine) = 2,
% Placebo = 0
agon_dataset = load('agon_dataset.mat', 'agon_dataset');
anta_dataset = load('anta_dataset.mat', 'anta_dataset');
agon_label = load('agon_label.mat', 'agon_label');
anta_label = load('anta_label.mat', 'anta_label');

%%
agon_dataset = agon_dataset.agon_dataset;
anta_dataset = anta_dataset.anta_dataset;
agon_label = agon_label.agon_label;
anta_label = anta_label.anta_label;

agon_placebo_idx = find(agon_label==0);
agon_levodopa_idx = find(agon_label==1);
agon_galantamine_idx = find(agon_label==2);
anta_placebo_idx = find(anta_label==0);
anta_amisulpride_idx = find(anta_label==1);
anta_biperiden_idx = find(anta_label==2);

%% Exploration
% Agon dataset
standard_tone = 100;
deviant_tone = 1000;
channels = [1:63];
% Mean EEG signal of all subjects of all channels and standard/deviant tone 
agon_tone_standard = squeeze(agon_dataset(:,channels,:,standard_tone));
agon_mean_channels_standard = squeeze(mean(agon_tone_standard, 2));
agon_mean_subjects_standard = squeeze(mean(agon_mean_channels_standard, 1));

agon_tone_deviant = squeeze(agon_dataset(:,channels,:,deviant_tone));
agon_mean_channels_deviant = squeeze(mean(agon_tone_deviant, 2)); 
agon_mean_subjects_deviant = squeeze(mean(agon_mean_channels_deviant, 1));

% Mean EEG signal of placebo subjects of all channels and standard/deviant
% tone
agon_placebo_tone_standard = squeeze(agon_dataset(agon_placebo_idx,channels,:,standard_tone));
agon_placebo_mean_channels_standard = squeeze(mean(agon_placebo_tone_standard, 2));
agon_placebo_standard = squeeze(mean(agon_placebo_mean_channels_standard, 1));

agon_placebo_tone_deviant = squeeze(agon_dataset(agon_placebo_idx,channels,:,deviant_tone));
agon_placebo_mean_channels_deviant = squeeze(mean(agon_placebo_tone_deviant, 2));
agon_placebo_deviant = squeeze(mean(agon_placebo_mean_channels_deviant, 1));

% Mean EEG signal of levodopa subjects of all channels and standard/deviant
% tone
agon_levodopa_tone_standard = squeeze(agon_dataset(agon_levodopa_idx,channels,:,standard_tone));
agon_levodopa_mean_channels_standard = squeeze(mean(agon_levodopa_tone_standard, 2));
agon_levodopa_standard = squeeze(mean(agon_levodopa_mean_channels_standard, 1));

agon_levodopa_tone_deviant = squeeze(agon_dataset(agon_levodopa_idx,channels,:,deviant_tone));
agon_levodopa_mean_channels_deviant = squeeze(mean(agon_levodopa_tone_deviant, 2));
agon_levodopa_deviant = squeeze(mean(agon_levodopa_mean_channels_deviant, 1));

% Mean EEG signal of galantamine subjects of all channels and standard/deviant
% tone
agon_galantamine_tone_standard = squeeze(agon_dataset(agon_galantamine_idx,channels,:,standard_tone));
agon_galantamine_mean_channels_standard = squeeze(mean(agon_galantamine_tone_standard, 2));
agon_galantamine_standard = squeeze(mean(agon_galantamine_mean_channels_standard, 1));

agon_galantamine_tone_deviant = squeeze(agon_dataset(agon_galantamine_idx,channels,:,deviant_tone));
agon_galantamine_mean_channels_deviant = squeeze(mean(agon_galantamine_tone_deviant, 2));
agon_galantamine_deviant = squeeze(mean(agon_galantamine_mean_channels_deviant, 1));

% Plot
figure
subplot(2,2,1)
plot(agon_mean_subjects_standard)
title('Agon: Standard Tone')
hold on
plot(agon_placebo_standard)
hold on
plot(agon_levodopa_standard)
hold on
plot(agon_galantamine_standard)
hold off
legend('All subjects', 'Placebo', 'Levodopa', 'Galantamine')

subplot(2,2,2)
plot(agon_mean_subjects_deviant)
title('Agon: Deviant Tone')
hold on
plot(agon_placebo_deviant)
hold on
plot(agon_levodopa_deviant)
hold on
plot(agon_galantamine_deviant)
hold off
legend('All subjects', 'Placebo', 'Levodopa', 'Galantamine')

% Anta dataset
standard_tone = 100;
deviant_tone = 1000;
channels = [1:63];
% Mean EEG signal of all subjects of all channels and standard/deviant tone 
anta_tone_standard = squeeze(anta_dataset(:,channels,:,standard_tone));
anta_mean_channels_standard = squeeze(mean(anta_tone_standard, 2));
anta_mean_subjects_standard = squeeze(mean(anta_mean_channels_standard, 1));

anta_tone_deviant = squeeze(anta_dataset(:,channels,:,deviant_tone));
anta_mean_channels_deviant = squeeze(mean(anta_tone_deviant, 2)); 
anta_mean_subjects_deviant = squeeze(mean(anta_mean_channels_deviant, 1));

% Mean EEG signal of placebo subjects of all channels and standard/deviant
% tone
anta_placebo_tone_standard = squeeze(anta_dataset(anta_placebo_idx,channels,:,standard_tone));
anta_placebo_mean_channels_standard = squeeze(mean(anta_placebo_tone_standard, 2));
anta_placebo_standard = squeeze(mean(anta_placebo_mean_channels_standard, 1));

anta_placebo_tone_deviant = squeeze(anta_dataset(anta_placebo_idx,channels,:,deviant_tone));
anta_placebo_mean_channels_deviant = squeeze(mean(anta_placebo_tone_deviant, 2));
anta_placebo_deviant = squeeze(mean(anta_placebo_mean_channels_deviant, 1));

% Mean EEG signal of amisulpride subjects of all channels and standard/deviant
% tone
anta_amisulpride_tone_standard = squeeze(anta_dataset(anta_amisulpride_idx,channels,:,standard_tone));
anta_amisulpride_mean_channels_standard = squeeze(mean(anta_amisulpride_tone_standard, 2));
anta_amisulpride_standard = squeeze(mean(anta_amisulpride_mean_channels_standard, 1));

anta_amisulpride_tone_deviant = squeeze(anta_dataset(anta_amisulpride_idx,channels,:,deviant_tone));
anta_amisulpride_mean_channels_deviant = squeeze(mean(anta_amisulpride_tone_deviant, 2));
anta_amisulpride_deviant = squeeze(mean(anta_amisulpride_mean_channels_deviant, 1));

% Mean EEG signal of biperiden subjects of all channels and standard/deviant
% tone
anta_biperiden_tone_standard = squeeze(anta_dataset(anta_biperiden_idx,channels,:,standard_tone));
anta_biperiden_mean_channels_standard = squeeze(mean(anta_biperiden_tone_standard, 2));
anta_biperiden_standard = squeeze(mean(anta_biperiden_mean_channels_standard, 1));

anta_biperiden_tone_deviant = squeeze(anta_dataset(anta_biperiden_idx,channels,:,deviant_tone));
anta_biperiden_mean_channels_deviant = squeeze(mean(anta_biperiden_tone_deviant, 2));
anta_biperiden_deviant = squeeze(mean(anta_biperiden_mean_channels_deviant, 1));

% Plot
%figure
subplot(2,2,3)
plot(anta_mean_subjects_standard)
title('Anta: Standard Tone')
hold on
plot(anta_placebo_standard)
hold on
plot(anta_amisulpride_standard)
hold on
plot(anta_biperiden_standard)
hold off
legend('All subjects', 'Placebo', 'Amisulpride', 'Biperiden')

subplot(2,2,4)
plot(anta_mean_subjects_deviant)
title('Anta: Deviant Tone')
hold on
plot(anta_placebo_deviant)
hold on
plot(anta_amisulpride_deviant)
hold on
plot(anta_biperiden_deviant)
hold off
legend('All subjects', 'Placebo', 'Amisulpride', 'Biperiden')