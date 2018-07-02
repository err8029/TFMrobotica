function [img] = img_view(msg)


%Get msg details
imgData = msg.Data;
imgH = msg.Height;
imgW = msg.Width;


%Reshape image data and assign each layer to the corresponding in the
%matrix
imgR = reshape(imgData(1:3:end),imgW,imgH)';
imgG = reshape(imgData(2:3:end),imgW,imgH)';
imgB = reshape(imgData(3:3:end),imgW,imgH)';
img(:,:,1) = imgB;
img(:,:,2) = imgG;
img(:,:,3) = imgR;
end

