function [ image ] = VideoShot( ~ )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation/ goes here
clc
clear all
close all
file1 =aviinfo('video.avi');
nFrames=file1.NumFrames;
fHeight=file1.Height;
fWidth=file1.Width;
nPixel=fHeight*fWidth;
file=aviread('video.avi');
HDi=zeros(nFrames);
%finding histogram intersection
HistDiff=zeros(nFrames);
for i=1:nFrames 
    frame=file(i);
    framedata=frame.cdata;
    differ=zeros(fHeight,fWidth);
    
    [r1,l1]=imhist(framedata(:,:,1));
    [g1,m1]=imhist(framedata(:,:,2));
    [b1,n1]=imhist(framedata(:,:,3));
    if (i==1)
        r2=r1;
        g2=g1;
        b2=b1;
        prev_framedata=framedata;
    end
    r3=min(r1,r2);
    g3=min(g1,g2);
    b3=min(b1,b2);
    netsum=(sum(r3)+sum(g3)+sum(b3))/(3*fHeight*fWidth);
    HDi(i)=1-netsum;
    %parameter update
     r2=r1;
    g2=g1;
    b2=b1;
   % Gr2=Gr1;
    prev_framedata=framedata;
    imshow(framedata);
    hold on;      
end
 figure,plot(HDi);
for k = 1 : nFrames       
    % abrupt change || gradual change || gradual change 
    if((HDi(k)>=0.25))
    %if((HDi(i)>=0.7 && hd(k-1)<=0.5 && hd(k+1)<=0.5) || (HDi(i)>=0.5 && HDi(i)<=0.7 && (hd(k-1)>=0.5 || hd(k+1)>=0.5)) || (HDi(i)>=0.7 && (hd(k-1)>=0.5 ||hd(k+1)>=0.5)))
        image=file(k).cdata;
         figure(k);
         imshow(image);
         %title('Frame Number - ',frameNo);
        Demo2(image);
    end;
end

end

