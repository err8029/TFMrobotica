 # !/bin/bash

#320x240 size of the image
#1256 351+4 the point to start cropping
#mogrify -crop 320x240+1256+355 *.png

#rename the files to 001.png style
i=1
for file in *; do
	mv "$file" "$(printf %03d $i).png"
	i=$((i+1))
done
