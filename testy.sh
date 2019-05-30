#!/bin/bash

filename=$1
exposure=$2
blur=$3
noise=$4
resize=$5

mkdir out
mkdir frames

# split a sequence into frames 
ffmpeg -i "$filename" frames/agh_frames%04d.jpg

for filename in frames/*.jpg; do
		basePath=${filename%.*}
		baseName=${basePath##*/}
		
		#emulacja jasnoscia i blurem
		if [ $exposure == 0 ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0,
						  unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize" out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize".bmp
		elif [ $exposure == '-' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=-0.5,
						  unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize" out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize".bmp
		elif [ $exposure == '+' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0.5,
						  unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize" out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize".bmp
		fi
		
done
