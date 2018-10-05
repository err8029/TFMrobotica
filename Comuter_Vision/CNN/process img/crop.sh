 # !/bin/bash

#320x240 size of the image
#1256 351+4 the point to start cropping
mogrify -crop 900x900+340+100 *.png
echo "crop done"
mogrify -resize 3.555556% *.png
#mogrify -resize 28.44445% *.png
#for a 256x256 pic
echo "resize done"
#rename the files to 001.png style
i=1
for file in *; do
	mv "$file" "$(printf $i).png"
	i=$((i+1))
done
