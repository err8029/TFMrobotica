 # !/bin/bash

#320x240 size of the image
#1256 351+4 the point to start cropping
<<<<<<< HEAD
#mogrify -crop 320x240+1256+355 *.png
=======
mogrify -crop 320x240+1256+355 *.png
>>>>>>> 072e61af2bb22ad289d5acff8730778f594b7e80

#rename the files to 001.png style
i=1
for file in *; do
	mv "$file" "$(printf $i).png"
	i=$((i+1))
done
