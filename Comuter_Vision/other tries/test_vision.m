clear
clc
close all

%num of images to be read
files=15;
%init matrix
imageMatrix = uint8(zeros(240,320,3,files));
BWMatrix = uint8(zeros(240,320,files));

%read and store all the images
for k = 1:files
    image = imread([num2str(k) '.png']);
    imageMatrix(:,:,:,k) = image;
    
    image = rgb2gray(image);
    
    mask = false(size(image)); 
    mask(120,160) = true;
    W = graydiffweight(image, mask,'GrayDifferenceCutoff', 25);
    thresh=0.001;
    
    [BW, D] = imsegfmm(W, mask, thresh);
    BWMatrix(:,:,k)=BW;
    
end
figure();
p=1;
for p=1:1:15
    subplot(5,3,p)
    imshow(BWMatrix(:,:,p),[]);
    p=p+1;
    hold on
end
hold off

figure();
p=1;
for p=1:1:15
    subplot(5,3,p)
    imshow(imageMatrix(:,:,:,p),[]);
    p=p+1;
    hold on
end
hold off