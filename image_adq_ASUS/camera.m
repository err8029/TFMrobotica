clear
clc
close all

%camera list
%-1: Depth camera
%-2: RGB camera
%-3: WebCam
cam = webcam(2);

%get the current image number
fileID = fopen('current_img.txt','r');
formatSpec = '%d';
sizeA = [1 1];
num = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);

%get a preview of the selected camera
img = snapshot(cam);
imshow(img)

%write the image as a png file
imwrite(img,['newImage' num2str(num+1) '.png'])
%write the image as a JPG file
imwrite(img,['newImage' num2str(num+1) '.jpg'],'jpg','Comment','My JPEG file')

%close is needed if not the stream will stay alive and other cams cant be
%opnened
closePreview(cam)

%write the next image number
fileID = fopen('current_img.txt','w');
fprintf(fileID,'%d',num+1);
fclose(fileID);