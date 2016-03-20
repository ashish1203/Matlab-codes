clc; clear all; 
% ImgPathName = 'image.jpg'; 
% binNum = 9; number of angle ranges
% angle = 180; 
% CellSize=9;
% SkipStep=9; it should be graeter than or equal to CellSize
% filter_para= [3 0.5]; size of gaussian filter and its variance
% p = ImgHOGFeature(ImgPathName, SkipStep, BinNum, Angle, CellSize, filter_para) 
 
tic; 
 
ImgPathName = 'cube.jpg'; 
SkipStep=9;
BinNum = 9; 
Angle = 180; 
CellSize = 9; 
filter_para= [3 0.5];  
feat = ImgHOGFeature(ImgPathName, SkipStep, BinNum, Angle, CellSize, filter_para); 
toc