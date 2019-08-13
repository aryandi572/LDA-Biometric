%% STEP 3 - function reshape dataset 2D ke 1D
function [Hasil1D] = TwoD2OneD(namaFile)
InitialFile='TwoD2OneD.m';
functiondir=which(InitialFile);
functiondir=functiondir(1:end-length(InitialFile));
%% get size dataset dan size cel index 1 
[jmlKelas jmlPose] = size(namaFile);
[H W] = size(namaFile{1,1});

%% merubah cell ke bentuk 1D
for kelas = 1:jmlKelas
    for pose = 1:jmlPose
        citra = namaFile{kelas, pose};
        Hasil1D{kelas, pose} = reshape(citra, [1 H*W]);
    end
end

%% save file
RunC=['save ' functiondir 'dataRecord\Hasil1D Hasil1D' ];
eval(RunC);

end