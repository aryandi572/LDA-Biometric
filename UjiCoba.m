%% STEP 7 - function uji coba
function [similar] = UjiCoba(SampelUji, PoseUji, JmlDimen)
InitialFile='UjiCoba.m';
functiondir=which(InitialFile);
functiondir=functiondir(1:end-length(InitialFile));
%[weightMatricTrain, projectionMatricTrain, zeromeanTrain] = EkstraksiFitur(matricTrain)
%% OutPca
OutLda = [functiondir 'dataRecord\OutLda'];
load(OutLda)

%% cellujicoba
dataTesting = [functiondir 'dataRecord\dataTesting'];
load(dataTesting)

%% cellpelatihan
dataTraining = [functiondir 'dataRecord\dataTraining'];
load(dataTraining)
%% get size citra
[H W] = size(dataTesting{SampelUji, PoseUji});

%% get jml kls dan jml pose data pelatihan
[jmlKelas jmlPose] = size(dataTraining);

%% ambil data uji
citraUjiCoba = double(dataTesting{SampelUji, PoseUji});

%% ubah citra data uji 2D ke 1D
citraUji = reshape(citraUjiCoba, 1, H*W);

%% proyeksi data uji
bobotTesting = citraUji*OutLda.projectionMatric;

%% ukur kemiripan gunakan manhattan
[kelas, pose] = Manhattan(OutLda.weightMatric(:,1:JmlDimen), bobotTesting(:,1:JmlDimen), jmlPose);

%% show hasil
hasilPengenalan = [uint8(citraUjiCoba) dataTraining{kelas, pose}];
%imshow(hasilPengenalan);

%% cek hasil perbandingan
if kelas == SampelUji
   %msgbox('Hasil Kemiripan : Benar');
   imwrite(hasilPengenalan,strcat('foto',num2str(SampelUji),'_',num2str(PoseUji),'_Benar_','.jpeg'));
   similar = 1;
else
   %msgbox('Hasil Kemiripan : Salah');
   imwrite(hasilPengenalan,strcat('foto',num2str(SampelUji),'_',num2str(PoseUji),'_Salah_','.jpeg'));
   similar = 0;
end
end
