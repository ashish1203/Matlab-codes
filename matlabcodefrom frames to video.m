srcFiles = dir('C:\Users\acer-pc\Desktop\ballet dataset\New folder\frames_tracked\seq_000045\*.jpg');
workingDir=dir('C:\Users\acer-pc\Desktop\ballet dataset\New folder\frames_tracked\seq_000045\*.jpg');
N=10;

imageNames = dir('C:\Users\acer-pc\Desktop\ballet dataset\New folder\frames_tracked\seq_000045\*.jpg');
imageNames = {imageNames.name}';

 writerObj=VideoWriter('45.avi');
 writerObj.FrameRate=N;

% outputVideo = VideoWriter(fullfile(workingDir,'shuttle_out.avi'));
% outputVideo.FrameRate = shuttleVideo.FrameRate;
 open( writerObj)
for i = 1:length(imageNames)
    
    imageNames = strcat('C:\Users\acer-pc\Desktop\ballet dataset\New folder\frames_tracked\seq_000045\',srcFiles(i).name);
    a = imread(imageNames);
%    img = imread(fullfile(workingDir,'images',imageNames{ii}));
   writeVideo(writerObj,a)
end