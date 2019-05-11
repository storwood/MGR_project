#!/bin/bash

srcDir=$1
exposure=$2
blur=$3

for filename in "$srcDir"/*.avi; do
		basePath=${filename%.*}
		baseName=${basePath##*/}
		
		#emulacja jasnoscia i blurem
		if [ $exposure == 0 ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0, unsharp=lx=3:ly=3:la=$blur" out/out_"$baseName"_"$exposure"_"$blur".avi
		elif [ $exposure == '-' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=-0.5, unsharp=lx=3:ly=3:la=$blur" out/out_"$baseName"_"$exposure"_"$blur".avi
		elif [ $exposure == '+' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0.5, unsharp=lx=3:ly=3:la=$blur" out/out_"$baseName"_"$exposure"_"$blur".avi
		fi
		
done
