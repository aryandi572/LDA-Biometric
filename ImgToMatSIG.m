%% STEP 1 - function konversi citra ke file matlab .mat (data JAFFE default  folder:10, pose:20)
function ImgToMatSIG(jmlFolder, jmlPose)
InitialFile='ImgToMatSIG.m';
functiondir=which(InitialFile);
functiondir=functiondir(1:end-length(InitialFile));
%%  looping per folder per pose
for folder=1:jmlFolder
    for pose=1:jmlPose
        path = strcat('C:\ProjectMatlab\LDA_UAS\dataSet\a',int2str(folder),'\',int2str(pose),'.tiff');
        dataSIG{folder, pose} = imread(path);
    end
end
%% save file .mat
RunC=['save ' functiondir 'dataRecord\dataSIG dataSIG' ];
eval(RunC);
end