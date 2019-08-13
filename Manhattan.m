%% function mengukur kemiripan manhattan
function [kelas, pose] = Manhattan(bobotTrain, bobotTest, jmlPose)

%% hitung jarak
jarak = abs(bsxfun(@minus, bobotTrain, bobotTest));
jarak = transpose(sum(jarak'));

%% hitung jarak minimal
[aMin, pose] = min(jarak);

%% pembulatan ke atas
kelas = ceil(pose/jmlPose);

%%
pose = mod(pose, jmlPose);

%% 
if pose == 0
    pose = jmlPose;
end
end
