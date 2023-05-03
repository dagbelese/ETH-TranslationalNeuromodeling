%% Initialization
cd /Users/damolaagbelese/Documents/MATLAB/
addpath spm12/
cd TranslationalNeuromodeling/
spm eeg

%%
root_folder = '/Users/damolaagbelese/Documents/MATLAB/TranslationalNeuromodeling/';
agon_folder = fullfile(root_folder, 'agon/');
anta_folder = fullfile(root_folder, 'anta/');
info_folder = fullfile(root_folder, 'Information/');

%% agon dataset
agon_folder_names = dir(agon_folder);
agon_folder_names = {agon_folder_names(4:end).name};
cd(agon_folder)
agon_matlab_names = dir('**/*.mat');
agon_matlab_names = {agon_matlab_names(2:2:end).name};
cd ../

agon_dataset = zeros(length(agon_folder_names), 67, 139, 1800);
%agon_dataset = {};
for i=1:length(agon_matlab_names)
    i
    file_path = strcat(agon_folder_names{i},'/', agon_matlab_names{i});
    file_path = fullfile(agon_folder, file_path);
    agon_data = spm_eeg_load(file_path);
    agon_data = agon_data(:,:,:);
    agon_dataset(i,:,:,:) = agon_data;
end

%% anta dataset
anta_folder_names = dir(anta_folder);
anta_folder_names = {anta_folder_names(4:end).name};
cd(anta_folder)
anta_matlab_names = dir('**/*.mat');
anta_matlab_names = {anta_matlab_names(2:2:end).name};
cd ../

anta_dataset = zeros(length(anta_folder_names), 67, 139, 1800);
for i=1:length(anta_matlab_names)
    i
    file_path = strcat(anta_folder_names{i},'/', anta_matlab_names{i});
    file_path = fullfile(anta_folder, file_path);
    anta_data = spm_eeg_load(file_path);
    anta_data = anta_data(:,:,:);
    anta_dataset(i,:,:,:) = anta_data;
end

