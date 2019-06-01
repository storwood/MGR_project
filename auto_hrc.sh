#!/bin/bash

filename=$1
exposure=$2
blur=$3
noise=$4
resize=$5
snow=$6
rain_drops=$7

mkdir out
mkdir frames



if [ $snow == 1 ]; then
ffmpeg -i "$filename" -i snow.mp4 -filter_complex "[1:v]colorkey=0x000000:0.5:0.5[ckout];[0:v][ckout]overlay[out]" -map "[out]" -c:a copy -c:v libx264 output_snow.mp4
ffmpeg -i output_snow.mp4 frames/agh_frames%04d.jpg
else
ffmpeg -i "$filename" frames/agh_frames%04d.jpg
fi

for filename in frames/*.jpg; do
		basePath=${filename%.*}
		baseName=${basePath##*/}

		if [ $exposure == 0 ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0,
						  unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize" out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize"_"$snow"_"$rain_drops".bmp
		elif [ $exposure == '-' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=-0.5,
						  unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize" out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize"_"$snow"_"$rain_drops".bmp
		elif [ $exposure == '+' ]
		then
			ffmpeg -i "$filename" -vf "eq=brightness=0.5,
						  unsharp=lx=3:ly=3:la=$blur,
						   noise=alls=$noise:allf=t,
						   scale=iw*$resize:ih*$resize" out/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize"_"$snow"_"$rain_drops".bmp
		fi	
done

if [ $rain_drops == 1 ]; then
	mkdir out_with_rain
	for filename in out/*.bmp; do
		basePath=${filename%.*}
		baseName=${basePath##*/}
		ffmpeg -i $filename -i rain.png -filter_complex "
		        [0:v]setpts=PTS-STARTPTS, scale=1280x720[top]; \
		        [1:v]setpts=PTS-STARTPTS, scale=1280x720, \
		             format=yuva420p,colorchannelmixer=aa=0.5[bottom]; \
		        [top][bottom]overlay=shortest=1" \
		out_with_rain/out_"$baseName"_"$exposure"_"$blur"_"$noise"_"$resize"_"$snow"_"$rain_drops".bmp
	done
rm -rf out
else
echo "No rain drops filter"
fi


	
