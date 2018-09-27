total_img=2015;
sizes=[];
error=0;
for img=1:total_img
   if size(imread([num2str(img),'.png']),1)~=32 || size(imread([num2str(img),'.png']),2)~=32 || size(imread([num2str(img),'.png']),3)~=3
       disp(['img ' num2str(img) ': ' num2str(size(imread([num2str(img),'.png'])))]); 
       error=1;
   else
       error=0;
   end
end
if error==0
    disp('all good');
end
