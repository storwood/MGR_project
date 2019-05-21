#!/bin/bash

srcDir=$1
exposure=$2
blur=$3  
noise=$4 
resize=$5
motion_blur=$6 

for filename in "$srcDir"/*.avi; do
		basePath=${filename%.*}
		baseName=${basePath##*/}
		
		#emulacja jasnoscia i blurem
		if [ $exposure == 0 ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0, 
						   unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize,
						   tblend=all_mode=$motion_blur" -vcodec libx264 out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize"_"$motion_blur".avi
		elif [ $exposure == '-' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=-0.5,
						   unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize, 
						   tblend=all_mode=$motion_blur" -vcodec libx264 out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize"_"$motion_blur".avi
		elif [ $exposure == '+' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0.5,
						   unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize,
						   tblend=all_mode=$motion_blur" -vcodec libx264 out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize"_"$motion_blur".avi
		fi
		
done
