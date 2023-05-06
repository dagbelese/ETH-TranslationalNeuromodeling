%% Initialization
cd /Users/damolaagbelese/Documents/MATLAB/
addpath spm12/
cd TranslationalNeuromodeling/
spm eeg

%%
root_folder = '/Users/damolaagbelese/Documents/MATLAB/TranslationalNeuromodeling/';
agon_folder = fullfile(root_folder, 'agon/');
anta_folder = fullfile(root_folder, 'anta/');
agon_label_path = fullfile(root_folder, 'Information/pharma/dprst_agon_druglabels_anonym.mat');
anta_label_path = fullfile(root_folder, 'Information/pharma/dprst_anta_druglabels_anonym.mat');

%% agon dataset
agon_folder_names = dir(agon_folder);
agon_folder_names = {agon_folder_names(4:end).name};
cd(agon_folder)
agon_matlab_names = dir('**/*.mat');
agon_matlab_names = {agon_matlab_names(2:2:end).name};
cd ../

agon_dataset = zeros(length(agon_folder_names), 63, 139, 1800);
agon_label = zeros(length(agon_folder_names), 1);
labels = load(agon_label_path);
for i=1:length(agon_matlab_names)
    dataset_path = strcat(agon_folder_names{i},'/', agon_matlab_names{i});
    dataset_path = fullfile(agon_folder, dataset_path);
    % Create dataset
    agon_data = spm_eeg_load(file_path);
    agon_data = agon_data(1:63,:,:); % discard EOG, ECG and pulse channels
    agon_dataset(i,:,:,:) = agon_data;
    % Create label
    subject_id = agon_folder_names{i}(7:end);
    if any(contains(labels.subjDA.subjIDs, subject_id) == 1)
        agon_label(i) = 1;
    elseif any(contains(labels.subjACh.subjIDs, subject_id) == 1)
        agon_label(i) = 2;
    else
        agon_label(i) = 0;
    end
    i
end

%% anta dataset
anta_folder_names = dir(anta_folder);
anta_folder_names = {anta_folder_names(4:end).name};
cd(anta_folder)
anta_matlab_names = dir('**/*.mat');
anta_matlab_names = {anta_matlab_names(2:2:end).name};
cd ../

anta_dataset = zeros(length(anta_folder_names), 63, 139, 1800);
anta_label = zeros(length(anta_folder_names), 1);
labels = load(anta_label_path);
for i=1:length(anta_matlab_names)
    dataset_path = strcat(anta_folder_names{i},'/', anta_matlab_names{i});
    dataset_path = fullfile(anta_folder, dataset_path);
    % Create dataset
    anta_data = spm_eeg_load(file_path);
    anta_data = anta_data(1:63,:,:); % discard EOG, ECG and pulse channels
    anta_dataset(i,:,:,:) = anta_data;
    % Create label
    subject_id = anta_folder_names{i}(7:end);
    if any(contains(labels.subjDA.subjIDs, subject_id) == 1)
        anta_label(i) = 1;
    elseif any(contains(labels.subjACh.subjIDs, subject_id) == 1)
        anta_label(i) = 2;
    else
        anta_label(i) = 0;
    end
    i
end

%%
save('agon_label.mat', 'agon_label', '-v7.3');
save('anta_label.mat', 'anta_label', '-v7.3');
save('anta_dataset.mat', 'anta_dataset', '-v7.3');
save('agon_dataset.mat', 'agon_dataset', '-v7.3');

