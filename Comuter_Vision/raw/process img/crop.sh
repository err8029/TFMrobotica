 # !/bin/bash

#320x240 size of the image
#1256 351+4 the point to start cropping
mogrify -crop 920x920+340+80 *.png
mogrify -resize 3.4783% *.png
s
#rename the files to 001.png style
i=1
for file in *; do
	mv "$file" "$(printf $i).png"
	i=$((i+1))
done
