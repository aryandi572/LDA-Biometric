%% STEP 4 - function mengubah data cell ke bentuk matrix
function [ImgInMat] = CellKeMat(data1D)

%% Mencari Height dan Width Cell
[jmlKelas jmlPose] = size(data1D);

%% Inital matrix
ImgInMat = [];

%% Merubah cell ke matrix
for kelas=1:jmlKelas
    for pose=1:jmlPose
        temp = data1D{kelas, pose};
        ImgInMat = [ImgInMat; temp];
    end
end

%% ubah mat ke double
ImgInMat = double(ImgInMat);
%save TrainImgInMat TrainImgInMat;

end