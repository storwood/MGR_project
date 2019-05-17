#!/bin/bash

srcDir=$1
exposure=$2
blur=$3  
noise=$4 
resize=$5 

for filename in "$srcDir"/*.avi; do
		basePath=${filename%.*}
		baseName=${basePath##*/}
		
		#emulacja jasnoscia i blurem
		if [ $exposure == 0 ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0, unsharp=lx=3:ly=3:la=$blur, noise=alls=$noise:allf=t, scale=iw*$resize:ih*$resize" -vcodec libx264 out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize".avi
		elif [ $exposure == '-' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=-0.5, unsharp=lx=3:ly=3:la=$blur, noise=alls=$noise:allf=t, scale=iw*$resize:ih*$resize" -vcodec libx264 out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize".avi
		elif [ $exposure == '+' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0.5, unsharp=lx=3:ly=3:la=$blur, noise=alls=$noise:allf=t, scale=iw*$resize:ih*$resize" -vcodec libx264 out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize".avi
		fi
		
done
