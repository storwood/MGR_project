#!/bin/bash

filename=$1

ffmpeg -i "$filename" -i snow.mp4 -filter_complex "[1:v]colorkey=0x000000:0.5:0.5[ckout];[0:v][ckout]overlay[out]" -map "[out]" -c:a copy -c:v libx264 output_snow.mp4
