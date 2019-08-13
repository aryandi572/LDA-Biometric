%% function untuk melakukan reduksi dimensi PCA dan uji coba pengenalan data (sampelUji : orang yg diuji, poseUji : pose yg diuji)
function Main()
InitialFile = 'Main.m';
functiondir=which(InitialFile);
functiondir= functiondir(1:end-length(InitialFile));
%% load dataset
FileSIG = [functiondir 'dataRecord\dataSIG'];
load(FileSIG)
%% melakukan split data training dan testing
poseWonted = 11;
[dataTraining, dataTesting] = splitData(dataSIG, poseWonted);
RunC=['save ' functiondir 'dataRecord\dataTraining dataTraining' ];
eval(RunC);
RunC=['save ' functiondir 'dataRecord\dataTesting dataTesting' ];
eval(RunC);

%% get size
[JmlKelas JmlPoseTraining] = size(dataTraining);

%% mengubah bentuk 2D ke 1D
hasil1DTrain = TwoD2OneD(dataTraining);

%% mengubah bentuk cell ke matrix
ImgInMatTrain = CellKeMat(hasil1DTrain);

%% proses PCA
[weightMatricPca, projectionMatricPca] = PCA(ImgInMatTrain);

%% simpan ke record outpca
InputLda.WeightMatric = weightMatricPca;
InputLda.ProjectionMatric = projectionMatricPca;
InputLda.JmlPoseTraining = JmlPoseTraining;
InputLda.JmlKelas = JmlKelas;
InputLda.PelatihanFlat = ImgInMatTrain;

%% proses LDA
[weightMatric, projectionMatric] = LDA(InputLda);
OutLda.weightMatric = weightMatric;
OutLda.projectionMatric = projectionMatric;
% save OutLda OutLda;
RunC=['save ' functiondir 'dataRecord\OutLda OutLda' ];
eval(RunC);
% 2:8 4:7
% tes kemiripan dgn melakukan reduksi dimensi
[jmlKelas jmlPose] = size(dataTesting);
Evaluasi = [];
for JmlDimen=4:7
    benar = 0; salah = 0;
    for kelas=1:jmlKelas
        for pose=1:jmlPose
            similarity = UjiCoba(kelas, pose, JmlDimen);
            if similarity == 1
                benar = benar+1;
            else
                salah = salah+1;
            end
        end
    end
    persentase = (benar/(benar+salah))*100;
    Evaluasi = [Evaluasi; [JmlDimen benar salah persentase]]
end
% % save EvaluasiYale Evaluasi;
RunC=['save ' functiondir 'dataRecord\EvaluasiData Evaluasi' ];
eval(RunC);

plot(Evaluasi(:,2),Evaluasi(:,4),'b:');
title('Grafik Hasil')

