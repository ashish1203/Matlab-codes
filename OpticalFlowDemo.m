clc
clear all
close all
video = VideoReader('video1.avi');
nFrames = video.NumberOfFrames;
vidHeight = video.Height;
vidWidth = video.Width;
prevFrame = zeros(241, 321);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:nFrames
   % framedata=read(video,k);
    currFrame = read(video,k);
    %
    currFrame=rgb2gray(currFrame);
    currFrame = double(currFrame);
    %data1=medfilt2(data,[5,5]);
    %data1=im2bw(data);
    %imshow(data1);
    %imshow(currFrame-prevFrame);
    OpticalFlowGradient(currFrame, prevFrame, 0.5, nFrames);
    prevFrame = currFrame;
end
