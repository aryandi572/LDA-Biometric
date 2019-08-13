%% STEP 6 - function ekstraksi Fitur (ImageTraining = matric data)
function[WeightMatric, ProjectionMatric] = LDA(InputLda)

JmlPoseTraining = InputLda.JmlPoseTraining;
JmlKelas = InputLda.JmlKelas;
JmlData = JmlKelas*JmlPoseTraining;

%% memotong jml kolom sebesar jml kelas
ProyeksiPcaBaru = InputLda.ProjectionMatric(:,1:JmlData-JmlKelas);

%% bentuk input lda
DataMasukanLda = double(InputLda.PelatihanFlat)*ProyeksiPcaBaru;

%% menghitung rata-rata @kelas
counter = 1;
for kls=1:JmlPoseTraining:JmlData
    mulai = kls;
    sampai = kls+JmlPoseTraining-1;
    RataKelas(counter,:) = mean(DataMasukanLda(mulai:sampai,:));
    counter = counter+1;
end

%% menghitung rata2 total
RataTotal = mean(DataMasukanLda);

%% menghitung sb
sb = 0;
for kls=1:JmlKelas
    zk = RataKelas(kls,:)-RataTotal;
    sb = sb+zk'*zk;
end

%% menghitung sw
sw = 0;
for kls=1:JmlKelas
    for data=1:JmlData
        zm = DataMasukanLda(data,:)-RataKelas(kls,:);
        sw = sw+JmlPoseTraining*zm'*zm;
    end
end

%% menghitung eig value & vector lalu shorting
[LdaVector, LdaValue] = svd(sb*inv(sw));

%% mengurangi fitur hingga jml fitur = jml kelas-1
wfld = transpose(LdaVector(:,1:JmlKelas-1));

%% menghitung matrix proyeksi
ProjectionMatric = (wfld*ProyeksiPcaBaru')';

%% menghitung bobot matrik
WeightMatric = double(InputLda.PelatihanFlat)*ProjectionMatric;
