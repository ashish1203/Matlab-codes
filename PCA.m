function [PC] = PCA( img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[M,N] = size(img);
% subtract off the mean for each dimension
mn = mean(img,2);
img = img - repmat(mn,1,N);
% calculate the covariance matrix
covariance = 1 / (N-1) * (img) * img';
% find the eigenvectors and eigenvalues
[PC, V] = eig(covariance);% extract diagonal of matrix as vector
V = diag(V);
% sort the variances in decreasing order
[junk, rindices] = sort(-1*V);
V = V(rindices);
PC = PC(:,rindices);
% project the original img set
signals = PC' * img;

end

