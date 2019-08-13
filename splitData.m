%% STEP 2 - function split data training & testing
function [dataTraining, dataTesting] = splitData(file1D, poseWonted)

%% ambil size dataset dan random (jika split data memakai random)
%[H W] = size(file1D);
%urutan = randperm(W);

%% ambil data train, test per folder
dataTraining = file1D(1:end, 1:poseWonted);
dataTesting = file1D(1:end, poseWonted+1:end);

%% save file
%save dataTraining dataTraining;
%save dataTesting dataTesting;

end