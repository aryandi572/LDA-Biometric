%% STEP 5 - function ekstraksi Fitur (ImageTraining = matric data)
function[weightMatric, projectionMatric] = PCA(ImageTraining)

%% get size
[jmlKelas jmlPose] = size(ImageTraining);

%% get average
average = mean(ImageTraining);

%% hitung zeromean
zeromean = bsxfun(@minus,ImageTraining,average);
%zeromean = zscore(ImageTraining);

%% hitung kovarian
covmatric = (1/(jmlKelas-1))*(zeromean*zeromean');
%covmatric = cov(zeromean);

%% hitung eigen value & vector
[eigvector, eigvalue] = eig(covmatric);

%% sorting descending eigen value
eigvalue = diag(eigvalue);
[result, index] = sort(eigvalue,'descend');
eigvalue = eigvalue(index);

%% sorting eigen vector sesuai dengan perubahan index eigen value
eigvector = eigvector(:, index);

%% cek eigen value mendekati 0
nonDominant = find(eigvalue < 0.00000000001);
jml = length(nonDominant);

%% reduce eigen vector yg punya posisi sama dgn eigen value dgn nilai mendekati 0
eigvector = eigvector(:, 1:end-jml);

%% hitung matrix proyeksi
projectionMatric = ImageTraining'*eigvector;
rootSumProjmat = (1./(sum(projectionMatric.^2).^0.5));
projectionMatric = bsxfun(@times, projectionMatric, rootSumProjmat);

%% hitung matrix bobot
weightMatric = ImageTraining*projectionMatric;

end